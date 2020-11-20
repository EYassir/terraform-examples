
variable "region_name" {
  description = "The region name"
  default     = "eu-west-1"
}

#START : VPC PARAMS
variable "vpc_app" {
  description = "The Application VPC"
  default = {
    "name" : "app"
    "cidr" : "11.0.0.0/16",
    "has_ig" : true,
    "subnet_prive" : ["11.0.1.0/24", "11.0.2.0/24", "11.0.3.0/24"],
    "subnet_public" : ["11.0.5.0/24", "11.0.6.0/24", "11.0.7.0/24", "11.0.8.0/24"],
    "subnet_az" : ["a", "b", "c", "a"],
    "has_natg" : true
  }
}

variable "vpc_database" {
  description = "The database VPC"
  default = {
    "name" : "database"
    "cidr" : "12.0.0.0/16",
    "has_ig" : false,
    "subnet_prive" : ["12.0.1.0/24", "12.0.2.0/24", "12.0.3.0/24"],
    "subnet_public" : [],
    "subnet_az" : ["a", "b", "c"],
    "has_natg" : false
  }
}

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




