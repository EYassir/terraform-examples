provider "aws" {
  region = var.region_name
}

variable "vpc_requester" {
  description = "The requester"
}

variable "vpc_accepter" {
  description = "The accepter"
}

variable "region_name" {
  description = "region name"
}

resource "aws_vpc_peering_connection" "ey_vpc_peering" {
  peer_vpc_id = var.vpc_accepter
  vpc_id      = var.vpc_requester
  auto_accept = true
  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}
