
module "vpc_module" {
  source   = "../../modules/vpc"
  vpc_cidr = var.vpc_cidr
}

module "bastion_module" {
  source           = "../../modules/bastion"
  custom_subnet_id = module.vpc_module.public_subnet.id
  custom_vpc_id    = module.vpc_module.custom_vpc.id
}
