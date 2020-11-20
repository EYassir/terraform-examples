resource "aws_nat_gateway" "ey_ngw" {
  count         = var.vpc_object["has_natg"] ? 1 : 0
  allocation_id = aws_eip.ey_eip_ngw.id
  subnet_id     = aws_subnet.public_0[0].id

  tags = {
    Name = "ey-${var.vpc_object["name"]}-nat-gateway"
  }
}

resource "aws_eip" "ey_eip_ngw" {
  vpc = true
}

resource "aws_default_route_table" "r" {
  count                  = var.vpc_object["has_natg"] ? 1 : 0
  default_route_table_id = aws_vpc.ey_vpc.default_route_table_id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ey_ngw[0].id
  }

  tags = {
    Name = "ey-${var.vpc_object["name"]}-private-route"
  }
}

