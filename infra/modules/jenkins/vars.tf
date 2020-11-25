variable "jenkins_key_name" {
  description = "The name of the keypair"
}
variable "jenkins_key_value" {
  description = "The value of the keypair"
}
variable "custom_subnet_id" {
  description = "The custom public subnet"
}
variable "custom_vpc_id" {
  description = "The vpc id"
}
variable "number_of_jenkins"{
    description="number of jenkins to create"
}