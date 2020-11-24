
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
  description = "The Database VPC"
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
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/CvgQztRy9exBDG1furKTDapPWsQyftLv+ZnITRhNNAfbqbNdW5o98hA0FWKXT6Lck9I/OUpDYW77dHKfQ0M1g0g+iL+7a1OY67YBGDmwgyYcq5igq/JcpaXs6ysAijiwHLBvHqpq/UswNmAqvfxRp9jL79ui81d9fUd6YLuzdBA34VPad6Tog9rLEb0apwEE1668aAdhN8JbuIz6lVkf8OB2hmDEX0pliZOrFicfkkDfQIXiLVpds26fYU2QD6KWrSpqVD0TLKwlDSx9ZdYAq+jAEcq2RHlDnt9hlUf1zA3wPLQG2LiFYqi+ttuEsU/m30r8aiGsFHxCQlYRHe45 yassir@ubuntu"
}
variable "key_name" {
  description = "The name of the keypair"
  default     = "bastion-key"
}
#END : BASTION PARAMS




