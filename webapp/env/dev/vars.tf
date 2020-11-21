variable "region_name" {
  description = "The region name"
  default     = "eu-west-1"
}

variable "app_vpc_id" {
  default = ""
}
variable "database_vpc_id" {
  default = ""
}

#START :  ASG PARAMS
variable "key_name" {
  description = "The key pair that will be used"
  default     = "ansible-keypair"
}
variable "key_value" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCpPriXUOy0eFzDLVa2Hh1ftjdplazUcnZw0scT1yxu20qP3j/WBjnFtMJim/E2aKxZApjImbTUG2sJPYRK18NfEcncP9EpnkafxBoUj4wyTFL5pbsC0RC1tVXWlEX/YFCgiX0A5VCe1PV19gzJd11PGkuhjUsvKohgVHGZn815TDDDRpHfxn1GmloIth3P9T9+61vgP6JZ6fCgW5EtdGVMJr95HyVqh9FRkwvGYPg5POm4zW4O28BCE4fiaItl7zIcojb4rHwEH+VY/QoZjbRLXxXaHo4gY9fnEfckBI/v4qzmAtPBnjvRaMRYIKRuLYynH3fxRYEGgDvxzF8dlr5J yassir@ubuntu"
}

variable "app_port" {
  description = "the port number of the web"
  type        = number
  default     = 80
}

variable "private_vpc_app_subnets" {
  default = []
}
#END : ASG PARAMS

#START : ALB PARAMS
variable "public_vpc_app_subnets" {
  default = []
}
#END : ALB PARAMS

#END : VPC PARAMS


#START : BASTION PARAMS
variable "key_value" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAa8s/HyEapMVRbF6i2y0eq433G+lkCNUoSicGiTlVZK6jj2D6nkeApyjMvO+b9d68Gr8sokh/sOiE91suZm33ZN0u1Fho9kbkI5tZmi6yJJlcbha7/Yjg6Hb8ZptV8f6TqML0JkIMp50Z1itE1UPThUzcVyJ5AM2J47k0LseYC640BEzjlJOd45I5LCA7ew7sBmYLzP+yb5Z3EkxvADCQwtlWfnO1goMwnqnG5Zkmt3fKdzCmQ6Ig4Vu54XzbqeHoSyuVp7xRdPq/BO3XnrrWIjBff9amyOajKVzq6XkvEfOp5n8O0Y5X+RiHrPxWDvkGPi27P5IQmiXCCPCUc7dN yassir@ubuntu"
}
variable "key_name" {
  description = "The name of the keypair"
  default     = "bastion-key"
}
#END : BASTION PARAMS




