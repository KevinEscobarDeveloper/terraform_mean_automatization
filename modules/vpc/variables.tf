variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}
variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
}
variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
}
variable "az" {
  description = "Availability Zone"
  type        = string
}
variable "name" {
  description = "Project name/prefix"
  type        = string
}

variable "az_b" {}
variable "public_subnet_b_cidr" {}
