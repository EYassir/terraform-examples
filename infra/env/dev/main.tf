# terraform {
#   backend "s3" {
#     bucket         = "terraform-fitec-example-bucket-state"
#     key            = "env/dev/terraform.tfstate"
#     region         = "eu-west-1"
#     dynamodb_table = "terraform-fitec-example-dynamodb-lock"
#     encrypt        = true
#   }
# }
module "vpc_app_module" {
  source      = "../../modules/vpc"
  vpc_object  = var.vpc_app
  region_name = var.region_name
}

module "vpc_database_module" {
  source      = "../../modules/vpc"
  vpc_object  = var.vpc_database
  region_name = var.region_name
}

module "vpc_sysop_module" {
  source      = "../../modules/vpc"
  vpc_object  = var.vpc_sysops
  region_name = var.region_name
}

module "bastion_module" {
  source           = "../../modules/bastion"
  custom_subnet_id = module.vpc_sysop_module.custom_vpc_public_subnets[0].id
  custom_vpc_id    = module.vpc_sysop_module.custom_vpc.id
  region_name      = var.region_name
  key_name         = var.key_name
  key_value        = var.key_value
}

module "vpc_peering_app_database" {
  source        = "../../modules/peering"
  vpc_requester = module.vpc_app_module.custom_vpc.id
  vpc_accepter  = module.vpc_database_module.custom_vpc.id
  region_name   = var.region_name
  route_a_id    = module.vpc_app_module.custom_vpc.default_route_table_id
  route_b_id    = module.vpc_database_module.custom_vpc.default_route_table_id
  cidr_vpc_a    = var.vpc_app["cidr"]
  cidr_vpc_b    = var.vpc_database["cidr"]
}

