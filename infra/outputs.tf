# Output para o public IP a ser acessado da instância com NGINX
output "public_ip" {
  value = module.instancia_ec2.public_ip
  depends_on = [
    module.instancia_ec2
  ]
}

# Output para os ips privados de cada instância com Apache
output "private_ip" {
  value = module.aws_instance_ec2[*].private_ip
  depends_on = [
    module.aws_instance_ec2
  ]
}