#VPC Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                       = "custom_VPC"
  cidr                       = var.vpc_cidr
  azs                        = ["us-east-1a", "us-east-1b"]
  public_subnets             = [var.subnet_a_cidr, var.subnet_b_cidr]
  enable_dns_hostnames       = true
  enable_dns_support         = true
  enable_nat_gateway         = false
  create_igw                 = true
  manage_default_route_table = true
  default_route_table_tags   = {
    Name = "${var.project}-default-rt"
  }

  default_route_table_routes = [
    {
      cidr_block = "0.0.0.0/0"
      gateway_id = module.vpc.igw_id
    }
  ]
  tags = {
    Name = "custom_VPC"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "custom_VPC"
  }
}


#SecurityGroup Modules
module "http_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name        = "${var.project}-allow-http"
  description = "Enable HTTP Access"
  vpc_id      = module.vpc.vpc_id

  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "HTTP Access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

module "ssh_security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.0.0"

  name        = "${var.project}-allow-ssh"
  description = "Enable SSH Access"
  vpc_id      = module.vpc.vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH Access"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]

}


#ALB Module
module "elb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.7.0"

  name               = "${var.project}-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets
  security_groups    = [module.http_security_group.security_group_id]

  target_groups = [
    {
      name_prefix      = "tg-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      vpc_id           = module.vpc.vpc_id
      health_check = {
        enabled             = true
        interval            = 30
        path               = "/"
        port               = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout            = 3
        protocol           = "HTTP"
      }
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      target_group_index = 0
    }
  ]
}



#AutoScaling Modul
  module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "~> 6.0"  # Using a version constraint for stability

  name                      = "${var.project}-autoscaling-group"
  min_size                  = var.instance_count_min
  max_size                  = var.instance_count_max
  desired_capacity          = var.instance_count_min
  vpc_zone_identifier       = module.vpc.public_subnets
  target_group_arns         = module.elb.target_group_arns

  health_check_type         = "ALB"
  health_check_grace_period = 300

  # Launch template
  create_launch_template = true
  image_id               = var.image_id[var.region]
  instance_type          = var.instance_type
  security_groups        = [module.http_security_group.security_group_id,module.ssh_security_group.security_group_id]
  user_data              = filebase64("install_space_invaders.sh")

  network_interfaces = [
    {
      associate_public_ip_address = var.add_public_ip
      delete_on_termination       = true
    }
  ]

  # Tags
  tags = {
    Name = "${var.project}-instance"
  }

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      min_healthy_percentage = 50
    }
  }
}
