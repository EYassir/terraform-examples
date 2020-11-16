resource "aws_subnet" "private_01" {
  vpc_id            = aws_vpc.ey_vpc.id
  cidr_block        = "11.0.1.0/24"
  availability_zone = "${var.region_name}a"
  tags = {
    Name = "eyassir-private-sub-01"
  }
}
resource "aws_subnet" "private_02" {
  vpc_id            = aws_vpc.ey_vpc.id
  cidr_block        = "11.0.2.0/24"
  availability_zone = "${var.region_name}b"
  tags = {
    Name = "eyassir-private-sub-02"
  }
}
resource "aws_subnet" "private_03" {
  vpc_id            = aws_vpc.ey_vpc.id
  cidr_block        = "11.0.3.0/24"
  availability_zone = "${var.region_name}c"
  tags = {
    Name = "eyassir-private-sub-03"
  }
}

resource "aws_subnet" "public_01" {
  vpc_id                  = aws_vpc.ey_vpc.id
  cidr_block              = "11.0.4.0/24"
  availability_zone       = "${var.region_name}a"
  map_public_ip_on_launch = true
  tags = {
    Name = "eyassir-public-sub-01"
  }
}

resource "aws_route_table_association" "ey_a" {
  subnet_id      = aws_subnet.public_01.id
  route_table_id = aws_route_table.ey_public_route.id
}

output "public_subnet" {
  value = aws_subnet.public_01
}
