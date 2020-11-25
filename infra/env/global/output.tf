output "bastion_ip" {
  value = module.bastion_module.bastion.public_ip
}
