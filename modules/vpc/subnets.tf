resource "aws_subnet" "private_0" {
  count             = length(var.vpc_object["subnet_prive"])
  vpc_id            = aws_vpc.ey_vpc.id
  cidr_block        = var.vpc_object["subnet_prive"][count.index]
  availability_zone = "${var.region_name}${var.vpc_object["subnet_az"][count.index]}"
  tags = {
    Name = "eyassir-${var.vpc_object["name"]}-private-sub-${count.index}"
  }
}

resource "aws_subnet" "public_0" {
  count             = length(var.vpc_object["subnet_public"])
  vpc_id            = aws_vpc.ey_vpc.id
  cidr_block        = var.vpc_object["subnet_public"][count.index]
  availability_zone = "${var.region_name}${var.vpc_object["subnet_az"][count.index]}"
  tags = {
    Name = "eyassir-${var.vpc_object["name"]}-public-sub-${count.index}"
  }
}
