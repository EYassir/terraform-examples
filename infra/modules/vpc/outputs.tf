output "custom_vpc" {
  value = aws_vpc.ey_vpc
}

output "custom_vpc_public_subnets" {
  value = aws_subnet.public_0
}

output "custom_vpc_private_subnets" {
  value = aws_subnet.private_0
}
