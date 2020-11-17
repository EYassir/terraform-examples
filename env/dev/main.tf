# terraform {
#   backend "s3" {
#     bucket         = "terraform-fitec-example-bucket-state"
#     key            = "env/dev/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-fitec-example-dynamodb-lock"
#     encrypt        = true
#   }
# }
module "vpc_module" {
  source      = "../../modules/vpc-app"
  vpc_cidr    = var.vpc_cidr
  region_name = var.region_name
}

module "bastion_module" {
  source           = "../../modules/bastion"
  custom_subnet_id = module.vpc_module.public_subnet.id
  custom_vpc_id    = module.vpc_module.custom_app_vpc.id
  region_name      = var.region_name
}

module "vpc_database_module" {
  source      = "../../modules/vpc-db"
  vpc_cidr    = "30.0.0.0/16"
  region_name = var.region_name
}

module "vpc_peering" {
  source        = "../../modules/peering"
  vpc_requester = module.vpc_module.custom_app_vpc.id
  vpc_accepter  = module.vpc_database_module.custom_db_vpc.id
  region_name   = var.region_name
  route_a       = module.vpc_module.custom_app_main_route
  route_b       = module.vpc_database_module.custom_database_main_route
  cidr_vpc_a    = "11.0.0.0/16" #var.vpc_cidr
  cidr_vpc_b    = "30.0.0.0/16"
}

module "asg_ansible" {
  source      = "../../modules/asg"
  key_name    = "ansible-demo-keypair"
  key_value   = var.key_value
  region_name = var.region_name
  vpc_id      = module.vpc_module.custom_app_vpc.id
}

module "alb_ansible" {
  source           = "../../modules/alb"
  region_name      = var.region_name
  vpc_id           = module.vpc_module.custom_app_vpc.id
  target_group     = module.asg_ansible.asg_taget_group
  vpc_public_route = module.vpc_module.public_app_vpc_route
}

module "mysql_rds" {
  source           = "../../modules/rds"
  region_name      = var.region_name
  vpc_id           = module.vpc_database_module.custom_database_vpc.id
  db_password      = var.db_password
  admin_user       = var.admin_user
  db_name          = var.db_name
  db_instance_type = var.db_instance_type
  db_storage       = var.db_storage
}

