variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block of the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block of the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "name" {
  description = "Project name/prefix"
  type        = string
  default     = "mean"
}
