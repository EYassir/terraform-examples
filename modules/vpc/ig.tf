resource "aws_internet_gateway" "ey_ig" {
  count  = var.vpc_object["has_ig"] ? 1 : 0
  vpc_id = aws_vpc.ey_vpc.id

  tags = {
    Name = "ey-${var.vpc_object["name"]}-vpc-ig"
  }
}

resource "aws_route_table" "ey_public_route" {
  count  = var.vpc_object["has_ig"] ? 1 : 0
  vpc_id = aws_vpc.ey_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ey_ig[count.index].id
  }

  tags = {
    Name = "ey-${var.vpc_object["name"]}-public-route"
  }
}

resource "aws_route_table_association" "ey_a" {
  count          = length(var.vpc_object["subnet_public"])
  subnet_id      = aws_subnet.public_0[count.index].id
  route_table_id = aws_route_table.ey_public_route["${count.index - count.index}"].id
}
