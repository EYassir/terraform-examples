terraform {
  backend "s3" {
    bucket         = "terraform-fitec-example-bucket-state"
    key            = "env/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-fitec-example-dynamodb-lock"
    encrypt        = true
  }
}

provider "aws" {
  region = var.region_name
}

module "asg_ansible" {
  source                  = "../../modules/asg"
  key_name                = "ansible-demo-keypair"
  key_value               = var.key_value
  vpc_id                  = var.app_vpc_id
  app_port                = var.app_port
  private_vpc_app_subnets = var.private_vpc_app_subnets
}

module "alb_ansible" {
  source                 = "../../modules/alb"
  vpc_id                 = var.app_vpc_id
  target_group           = module.asg_ansible.asg_taget_group
  public_vpc_app_subnets = var.public_vpc_app_subnets
  app_port               = var.app_port
}

module "mysql_rds" {
  source = "../../modules/rds"

  vpc_id           = var.database_vpc_id
  db_password      = var.db_password
  admin_user       = var.admin_user
  db_name          = var.db_name
  db_instance_type = var.db_instance_type
  db_storage       = var.db_storage
}

