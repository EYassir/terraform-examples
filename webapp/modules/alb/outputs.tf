output "public_dns_lb" {
  value = aws_lb.tf_lb_wp.dns_name
}
