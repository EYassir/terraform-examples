variable "db_storage" {
  description = "How much storage disk to allow"
}
variable "db_instance_type" {
  description = "db instance"
}
variable "db_name" {
  description = "db instance"
}
variable "admin_user" {
  description = "db instance"
}
variable "db_password" {
  description = "db instance"
}
variable "vpc_id" {
  description = "The id of the database vpc"
}

data "aws_vpc" "database_vpc" {
  id = var.vpc_id
}

#subnet privé
data "aws_subnet_ids" "database_vpc_subnets_ids" {
  vpc_id = data.aws_vpc.database_vpc.id
  filter {
    name   = "tag:Name"
    values = ["*-private-*"]
  }
}
