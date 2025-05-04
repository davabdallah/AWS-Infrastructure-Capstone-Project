variable "project" {
  description = "The name of the current project."
  type        = string
  default     = "final-project"
}


variable "region" {
  type    = string
}

variable "add_public_ip" {
  type    = bool
  default = true
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_a_cidr" {
  type    = string
  default = "10.10.1.0/24"
}
variable "subnet_b_cidr" {
  type    = string
  default = "10.10.2.0/24"
}

variable "instance_count_min" {
  description = "Min number of instances to provision."
  type        = number
  default     = 1
}

variable "instance_count_max" {
  description = "Max number of instances to provision."
  type        = number
  default     = 2
}
variable "instance_type" {
  description = "The size of the VM instances."
  type        = string
  default     = "t2.micro"
}

variable "image_id" {
  description = "The id of the machine image (AMI) to use for the server."
  type        = map(string)
  default = {
    us-east-1 = "ami-0be2609ba883822ec",
    us-east-2 = "ami-0a0ad6b70e61be944"
  }
}
