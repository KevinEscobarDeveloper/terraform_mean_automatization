# AWS Region
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# VPC and Subnets
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "az" {
  description = "Availability zone"
  type        = string
  default     = "us-east-1a"
}

# EC2 Instance
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH"
  type        = string
}

# AMI IDs
variable "app_ami" {
  description = "AMI ID for the App (Node.js/Nginx/Angular)"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}

variable "mongo_ami" {
  description = "AMI ID for MongoDB"
  type        = string
  default     = "ami-0fc5d935ebf8bc3bc"
}

# Project Name
variable "project_name" {
  description = "Project name (for resource tagging)"
  type        = string
  default     = "mean-app"
}
