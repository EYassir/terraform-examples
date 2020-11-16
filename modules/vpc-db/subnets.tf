resource "aws_subnet" "private_01" {
  vpc_id            = aws_vpc.ey_db_vpc.id
  cidr_block        = "30.0.1.0/24"
  availability_zone = "${var.region_name}a"
  tags = {
    Name = "eyassir-private-database-01"
  }
}
resource "aws_subnet" "private_02" {
  vpc_id            = aws_vpc.ey_db_vpc.id
  cidr_block        = "30.0.2.0/24"
  availability_zone = "${var.region_name}b"
  tags = {
    Name = "eyassir-private-database-02"
  }
}
resource "aws_subnet" "private_03" {
  vpc_id            = aws_vpc.ey_db_vpc.id
  cidr_block        = "30.0.3.0/24"
  availability_zone = "${var.region_name}c"
  tags = {
    Name = "eyassir-private-database-03"
  }
}
