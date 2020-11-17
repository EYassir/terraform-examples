resource "aws_subnet" "public_01" {
  vpc_id                  = var.vpc_id
  cidr_block              = "11.0.5.0/24"
  availability_zone       = "${var.region_name}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "eyassir-lb-public-sub-01"
  }
}

resource "aws_route_table_association" "ey_a" {
  subnet_id      = aws_subnet.public_01.id
  route_table_id = var.vpc_public_route.id
}


resource "aws_subnet" "public_02" {
  vpc_id                  = var.vpc_id
  cidr_block              = "11.0.6.0/24"
  availability_zone       = "${var.region_name}b"
  map_public_ip_on_launch = true
  tags = {
    Name = "eyassir-lb-public-sub-02"
  }
}

resource "aws_route_table_association" "ey_b" {
  subnet_id      = aws_subnet.public_02.id
  route_table_id = var.vpc_public_route.id
}

resource "aws_subnet" "public_03" {
  vpc_id                  = var.vpc_id
  cidr_block              = "11.0.7.0/24"
  availability_zone       = "${var.region_name}c"
  map_public_ip_on_launch = true
  tags = {
    Name = "eyassir-lb-public-sub-03"
  }
}

resource "aws_route_table_association" "ey_c" {
  subnet_id      = aws_subnet.public_02.id
  route_table_id = var.vpc_public_route.id
}
