variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_id" {
  description = "ID of the public subnet where the NAT Gateway will be placed"
  type        = string
}

variable "private_subnet_id" {
  description = "ID of the private subnet that will use the NAT Gateway"
  type        = string
}

variable "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  type        = string
  default     = null
}