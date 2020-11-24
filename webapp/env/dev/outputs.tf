output "alb_public_dns" {
  value = module.alb_ansible.public_dns_lb
}
output "rds_db_adress" {
  value = module.mysql_rds.rds_db.address
}
