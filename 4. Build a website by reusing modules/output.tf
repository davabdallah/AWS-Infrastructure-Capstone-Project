output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "public_subnet_a_id" {
  description = "ID of public subnet in first AZ"
  value       = module.vpc.public_subnets[0]
}

output "public_subnet_b_id" {
  description = "ID of public subnet in second AZ"
  value       = module.vpc.public_subnets[1]
}

output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = module.vpc.igw_id
}

output "default_route_table_id" {
  description = "The ID of the default route table"
  value       = module.vpc.default_route_table_id
}

output "elb-url" {
  description = "The website url"
  value       = module.elb.lb_dns_name
}