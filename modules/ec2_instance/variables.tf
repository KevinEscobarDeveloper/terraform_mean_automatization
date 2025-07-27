variable "ami" {
  description = "AMI ID"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}
variable "subnet_id" {
  description = "Subnet ID"
  type        = string
}
variable "vpc_security_group_ids" {
  description = "Security group IDs"
  type        = list(string)
}
variable "key_name" {
  description = "SSH key pair name"
  type        = string
}
variable "user_data" {
  description = "User data script"
  type        = string
  default     = ""
}
variable "tags" {
  description = "Tags for instance"
  type        = map(string)
  default     = {}
}
