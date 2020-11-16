resource "aws_nat_gateway" "ey_ngw" {
  allocation_id = aws_eip.ey_eip_ngw.id
  subnet_id     = aws_subnet.public_01.id

  tags = {
    Name = "ey-nat-gateway"
  }
}

resource "aws_eip" "ey_eip_ngw" {
  vpc = true
}
