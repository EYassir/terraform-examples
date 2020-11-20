output "custom_vpc" {
  value = aws_vpc.ey_vpc
}

output "custom_vpc_public_subnets" {
  value = aws_subnet.public_0
}
