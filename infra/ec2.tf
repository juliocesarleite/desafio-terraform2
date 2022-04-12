# Chave AWS
resource "aws_key_pair" "my_key" {
  key_name = "aws_key"
  public_key = file(pathexpand("~/.ssh/id_rsa.pub"))
}

#Criação da instância EC2 com Nginx
module "instancia_ec2" {
  source                      = "./ec2_module"
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  vpc_security_group_ids      = ["${aws_security_group.security_group.id}"]
  subnet_id                   = aws_subnet.publics_subnets[1].id
  user_data                   = file("./scripts/nginx.sh")

  tags = {
    "Name" = "Instância_Ngix"
  }
}

# Criação das três instâncias EC2 com Apache através do Count
module "aws_instance_ec2" {
  source                 = "./ec2_module"
  count                  = var.az_count
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.my_key.key_name
  vpc_security_group_ids = ["${aws_security_group.instancias_sg.id}"]
  subnet_id              = aws_subnet.private_subnets[count.index].id
  private_ip             = "${var.vpc_cidr_base}.${count.index + 1}.${count.index + 5}"
  user_data              = file("./scripts/apache${count.index}.sh")
  tags = {
    "Name" = "Instancia_Apache_${count.index + 1}"
  }
  depends_on = [aws_nat_gateway.nat]
}


