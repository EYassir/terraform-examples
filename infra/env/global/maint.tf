terraform {
  backend "s3" {
    bucket         = "terraform-fitec-example-bucket-state"
    key            = "env/dev/terraform.tfstate"
    region         = "eu-west-1"
    dynamodb_table = "terraform-fitec-example-dynamodb-lock"
    encrypt        = true
  }
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
  tag_name         = "jenkins-bastion"
}

module "jenkins_module" {
  source            = "../../modules/jenkins"
  custom_subnet_id  = module.vpc_sysop_module.custom_vpc_private_subnets[0].id
  custom_vpc_id     = module.vpc_sysop_module.custom_vpc.id
  region_name       = var.region_name
  jenkins_key_name  = var.jenkins_key_name
  jenkins_key_value = var.jenkins_key_value
  number_of_jenkins = 1
}

# module "vpc_peering_app_database" {
#   source        = "../../modules/peering"
#   vpc_requester = module.vpc_app_module.custom_vpc.id
#   vpc_accepter  = module.vpc_database_module.custom_vpc.id
#   region_name   = var.region_name
#   route_a_id    = module.vpc_app_module.custom_vpc.default_route_table_id
#   route_b_id    = module.vpc_database_module.custom_vpc.default_route_table_id
#   cidr_vpc_a    = var.vpc_app["cidr"]
#   cidr_vpc_b    = var.vpc_database["cidr"]
# }

