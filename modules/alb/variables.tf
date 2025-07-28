variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs for the load balancer"
  type        = list(string)
}

variable "instance_id" {
  description = "ID of the app instance"
  type        = string
}

variable "security_groups" {
  description = "List of security group IDs for the load balancer"
  type        = list(string)
}
