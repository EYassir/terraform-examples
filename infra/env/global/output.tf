output "bastion_ip" {
  value = module.bastion_module.bastion.public_ip
}
output "jenkins_hosts" {
  value = module.jenkins_module.jenkins
}
