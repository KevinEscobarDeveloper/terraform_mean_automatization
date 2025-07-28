output "app_public_ip"    { value = module.ec2_app.public_ip }
output "app_private_ip"   { value = module.ec2_app.private_ip }
output "mongo_public_ip"  { value = module.ec2_mongo.public_ip }
output "mongo_private_ip" { value = module.ec2_mongo.private_ip }
output "alb_dns"          { value = module.alb.alb_dns_name }
output "nat_gateway_ip"   { value = module.nat.nat_gateway_public_ip }
