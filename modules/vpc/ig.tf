resource "aws_internet_gateway" "ey_ig" {
  vpc_id = aws_vpc.ey_vpc.id

  tags = {
    Name = "ey-vpc-ig"
  }
}

resource "aws_route_table" "ey_public_route" {
  vpc_id = aws_vpc.ey_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ey_ig.id
  }

  tags = {
    Name = "ey-public-route"
  }
}
