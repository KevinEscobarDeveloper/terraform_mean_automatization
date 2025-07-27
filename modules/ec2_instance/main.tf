resource "aws_instance" "app" {
  ami           = var.app_ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  vpc_security_group_ids = [var.sg_app_id]
  user_data     = file("${path.module}/scripts/user_data_app.sh")
  tags = { Name = "app-instance" }
}

resource "aws_instance" "mongo" {
  ami           = var.mongo_ami
  instance_type = var.instance_type
  subnet_id     = var.mongo_subnet_id
  vpc_security_group_ids = [var.sg_mongo_id]
  user_data     = file("${path.module}/scripts/user_data_mongo.sh")
  tags = { Name = "mongo-instance" }
}
