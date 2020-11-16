
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

