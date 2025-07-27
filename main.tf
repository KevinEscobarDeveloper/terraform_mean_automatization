module "vpc" {
  source = "./modules/vpc"
}
module "security_group" {
  source = "./modules/security_group"
}
module "ec2_app" {
  source = "./modules/ec2_instance"
}
module "ec2_mongo" {
  source = "./modules/ec2_instance"
}
module "elb" {
  source = "./modules/elb"
}
module "nat_gateway" {
  source = "./modules/nat_gateway"
}
