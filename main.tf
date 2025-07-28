provider "aws" {
  region  = var.region
  profile = "default"  # Uses credentials from ~/.aws/credentials
}

module "vpc" {
  source              = "./modules/vpc"
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  az                  = var.az
  name                = var.project_name

  az_b                = var.az_b
  public_subnet_b_cidr = var.public_subnet_b_cidr
}


module "sg" {
  source              = "./modules/security_group"
  vpc_id              = module.vpc.vpc_id
  public_subnet_cidr  = var.public_subnet_cidr
  name                = var.project_name
}

module "ec2_mongo" {
  source                 = "./modules/ec2_instance"
  ami                    = var.mongo_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.private_subnet_id
  vpc_security_group_ids = [module.sg.mongo_sg_id]
  key_name               = var.key_name
  user_data              = file("${path.root}/modules/scripts/user_data_mongo.sh")
  tags                   = { Name = "${var.project_name}-mongo" }
}

data "template_file" "app_userdata" {
  template = file("${path.root}/modules/scripts/user_data_app.sh")
  vars = {
    mongo_ip = module.ec2_mongo.private_ip
  }
  depends_on = [module.ec2_mongo]
}

module "ec2_app" {
  source                 = "./modules/ec2_instance"
  ami                    = var.app_ami
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id
  vpc_security_group_ids = [module.sg.app_sg_id]
  key_name               = var.key_name
  user_data              = data.template_file.app_userdata.rendered
  tags                   = { Name = "${var.project_name}-app" }
}

module "nat" {
  source            = "./modules/nat_gateway"
  public_subnet_id  = module.vpc.public_subnet_id
  private_subnet_id = module.vpc.private_subnet_id
  vpc_id            = module.vpc.vpc_id
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  subnets = [
    module.vpc.public_subnet_id,
    module.vpc.public_subnet_id_b
  ]
  security_groups   = [module.sg.elb_sg_id]
  instance_id       = module.ec2_app.instance_id
}

