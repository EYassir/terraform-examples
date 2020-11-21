
variable "vpc_id" {
  description = "the id of vpc to work on"
}

data "aws_vpc" "custom_vpc" {
  id = var.vpc_id
}

# #subnet public
# data "aws_subnet_ids" "custom_vpc_subnets_ids" {
#   vpc_id = data.aws_vpc.custom_vpc.id
#   filter {
#     name   = "tag:Name"
#     values = ["eyassir-lb-public-*"]
#   }
# }

variable "public_vpc_app_subnets" {
  default = []
}

variable "app_port" {
  description = "the port number of the web"
  type        = number
  default     = 80
}

variable "target_group" {
  description = "arn of target"
}

