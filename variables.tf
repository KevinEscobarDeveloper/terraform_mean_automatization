variable "region"              { default = "us-east-1" }
variable "vpc_cidr"            { default = "10.0.0.0/16" }
variable "public_subnet_cidr"  { default = "10.0.1.0/24" }
variable "private_subnet_cidr" { default = "10.0.2.0/24" }
variable "az"                  { default = "us-east-1a" }
variable "instance_type"       { default = "t3.micro" }
variable "key_name"            { description = "MiKeyPair" }
variable "app_ami"             { default = "ami-0fc5d935ebf8bc3bc" }
variable "mongo_ami"           { default = "ami-0fc5d935ebf8bc3bc" }
variable "project_name"        { default = "mean-app" }


variable "az_b" {
  description = "Segunda Availability Zone"
  type        = string
  default     = "us-east-1b"
}

variable "public_subnet_b_cidr" {
  description = "CIDR de la subred pública en la segunda AZ"
  type        = string
  default     = "10.0.3.0/24"
}