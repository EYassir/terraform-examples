resource "aws_route" "ra" {
  route_table_id            = var.route_a.id
  destination_cidr_block    = var.cidr_vpc_b
  vpc_peering_connection_id = aws_vpc_peering_connection.ey_vpc_peering.id
}

resource "aws_route" "rb" {
  route_table_id            = var.route_b.id
  destination_cidr_block    = var.cidr_vpc_a
  vpc_peering_connection_id = aws_vpc_peering_connection.ey_vpc_peering.id
}

variable "route_a" {
  description = "the route a"
}

variable "route_b" {
  description = "the route b"
}

variable "cidr_vpc_a" {
  description = "the cidr of  a"
}

variable "cidr_vpc_b" {
  description = "the cidr of b"
}
