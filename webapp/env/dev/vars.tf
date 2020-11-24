variable "region_name" {
  description = "The region name"
  default     = "eu-west-1"
}

variable "app_vpc_id" {
  default = "vpc-08d925842e27f96a4"
}
variable "database_vpc_id" {
  default = "vpc-03e28602edd552ef8"
}

#START :  ASG PARAMS
variable "key_name" {
  description = "The key pair that will be used"
  default     = "ansible-keypair"
}
variable "key_value" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDlWSg6THNMNH/HSq7hsCZRdJx/0LdALLLMm8hNkbrD4La65TqMTWxVTdKq3jBfcByu5WwsWdx9dtzm/Oi+nGBpN6UXCeW64JWVy4VP6YeMpCRsJMgaRUTf6RuReJ93P/KfZZXg/C7/3KcKih5ESctyWWYHfKH9NIQU0zoqO26e+hbnzv2jtc6ObgsESgMpyDsWAcU5RmgnWYvES7dQvEQOjE2Cml9emU7E3h11eIZccUxjGzRvDYhD/SKfliFwhUMulN6sD5VG0ovxPd7LOjOcoMzfzdj4h1DY+Od1mrsTj5tCEUo6dsUzytW40bQWbhDzhyP7A5velD2H83rSwwll yassir@ubuntu"
}

variable "app_port" {
  description = "the port number of the web"
  type        = number
  default     = 80
}

variable "private_vpc_app_subnets" {
  default = ["subnet-0a3d8a788d3411e8a", "subnet-09e8c6aa679ee1e91", "subnet-04b971d848b06af3c"]
}
#END : ASG PARAMS

#START : ALB PARAMS
variable "public_vpc_app_subnets" {
  default = ["subnet-0f8466b9a2a0a455a", "subnet-07c1255215366e4f8", "subnet-08d14c56271e7c1fd"]
}
#END : ALB PARAMS

#START : RDS PARAMS
variable "db_storage" {
  default = 20
}
variable "db_instance_type" {
  default = "db.t2.micro"
}
variable "db_name" {
  default = "webapp"
}
variable "admin_user" {
  default = "admin"
}
variable "db_password" {
  default = "admin2020" #TODO: Use secret manager
}
#END : END PARAMS





