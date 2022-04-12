# Output para o ip público da instância
output "public_ip" {
  value = "http://${aws_instance.this.public_ip}"
}

# Output para o ip privado da instância
output "private_ip" {
  value = "http://${aws_instance.this.private_ip}"
}