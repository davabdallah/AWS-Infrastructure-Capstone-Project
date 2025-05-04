variable "region" {
  type    = string
}

variable "project" {
  description = "The name of the current project."
  type        = string
}

variable "image_id" {
  type    = string
}

variable "instance_type" {
  description = "The size of the VM instances."
  type        = string
}
