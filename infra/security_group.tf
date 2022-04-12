resource "aws_security_group" "security_group" {
  name = "intancia_nginx"
  description = "Security group for nginx instance"
  vpc_id = aws_vpc.vpc.id
  
  #Habilitando as portas de entrada via dynamic block
  dynamic "ingress" {
    for_each = var.sg_nginx_ingress
    content {
      from_port = ingress.key
      to_port = ingress.key
      cidr_blocks = ingress.value
      protocol = "tcp"
    }
  }

  #Habilitando as portas de saída via dynamic block
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "instancias_sg" {
  name = "instancias_apache"
  description = "Security group for apache instance"
  vpc_id = aws_vpc.vpc.id

  #Habilitando as portas de entrada via dynamic block
  dynamic "ingress" {
    for_each = var.sg_apache_ingress
    content {
      from_port = ingress.key
      to_port = ingress.key
      cidr_blocks = ingress.value
      protocol = "tcp"
    }
  }

  #Habilitando as portas de saída via dynamic block
   egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}



