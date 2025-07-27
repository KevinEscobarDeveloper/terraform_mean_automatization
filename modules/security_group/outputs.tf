output "app_sg_id" {
  description = "ID of the application security group"
  value       = aws_security_group.app.id
}

output "mongo_sg_id" {
  description = "ID of the MongoDB security group"
  value       = aws_security_group.mongo.id
}

output "elb_sg_id" {
  description = "ID of the ELB security group"
  value       = aws_security_group.elb.id
}