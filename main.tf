provider "aws" {
  region = var.region
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
}

module "security_group" {
  source             = "./modules/security_group"
  vpc_id             = module.vpc.vpc_id
  public_subnet_cidr = var.public_subnet_cidr
}

module "ec2_app" {
  source                 = "./modules/ec2_instance"
  ami                    = var.app_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.security_group.app_sg_id]
  key_name               = var.key_name
  user_data              = file("${path.module}/modules/scripts/user_data_app.sh")
  tags = {
    Name = "${var.project_name}-app"
  }
}

module "ec2_mongo" {
  source                 = "./modules/ec2_instance"
  ami                    = var.mongo_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnet_id
  vpc_security_group_ids = [module.security_group.mongo_sg_id]
  key_name               = var.key_name
  user_data              = file("${path.module}/modules/scripts/user_data_mongo.sh")
  tags = {
    Name = "${var.project_name}-mongo"
  }
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet_id = module.vpc.public_subnet_id
  vpc_id           = module.vpc.vpc_id
}

module "elb" {
  source          = "./modules/elb"
  vpc_id          = module.vpc.vpc_id
  subnet_id       = module.vpc.public_subnet_id
  instance_id     = module.ec2_app.instance_id
  security_groups = [module.security_group.elb_sg_id]
}
