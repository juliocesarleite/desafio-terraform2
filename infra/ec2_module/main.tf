# Definição do recurso modularizado da EC2
resource "aws_instance" "this" {
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  private_ip                  = var.private_ip
  tags                        = var.tags
  associate_public_ip_address = var.associate_public_ip_address
  user_data                   = var.user_data
}