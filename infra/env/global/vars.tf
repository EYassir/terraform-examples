
variable "region_name" {
  description = "The region name"
  default     = "eu-west-1"
}

#START : VPC PARAMS
variable "vpc_sysops" {
  description = "The sysops VPC"
  default = {
    "name" : "sysops"
    "cidr" : "20.0.0.0/16",
    "has_ig" : true,
    "subnet_prive" : ["20.0.1.0/24"],
    "subnet_public" : ["20.0.2.0/24"],
    "subnet_az" : ["a"],
    "has_natg" : true
  }
}

#END : VPC PARAMS


#START : BASTION PARAMS
variable "key_value" {
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/CvgQztRy9exBDG1furKTDapPWsQyftLv+ZnITRhNNAfbqbNdW5o98hA0FWKXT6Lck9I/OUpDYW77dHKfQ0M1g0g+iL+7a1OY67YBGDmwgyYcq5igq/JcpaXs6ysAijiwHLBvHqpq/UswNmAqvfxRp9jL79ui81d9fUd6YLuzdBA34VPad6Tog9rLEb0apwEE1668aAdhN8JbuIz6lVkf8OB2hmDEX0pliZOrFicfkkDfQIXiLVpds26fYU2QD6KWrSpqVD0TLKwlDSx9ZdYAq+jAEcq2RHlDnt9hlUf1zA3wPLQG2LiFYqi+ttuEsU/m30r8aiGsFHxCQlYRHe45 yassir@ubuntu"
}
variable "key_name" {
  description = "The name of the keypair"
  default     = "ops-bastion-key"
}
#END : BASTION PARAMS


#START : JENKINS
variable "jenkins_key_name" {
  default="jenkins-key"
}
variable "jenkins_key_value" {
  default="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC/CvgQztRy9exBDG1furKTDapPWsQyftLv+ZnITRhNNAfbqbNdW5o98hA0FWKXT6Lck9I/OUpDYW77dHKfQ0M1g0g+iL+7a1OY67YBGDmwgyYcq5igq/JcpaXs6ysAijiwHLBvHqpq/UswNmAqvfxRp9jL79ui81d9fUd6YLuzdBA34VPad6Tog9rLEb0apwEE1668aAdhN8JbuIz6lVkf8OB2hmDEX0pliZOrFicfkkDfQIXiLVpds26fYU2QD6KWrSpqVD0TLKwlDSx9ZdYAq+jAEcq2RHlDnt9hlUf1zA3wPLQG2LiFYqi+ttuEsU/m30r8aiGsFHxCQlYRHe45 yassir@ubuntu"
}
#END :JENKINS

