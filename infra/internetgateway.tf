# Criação do Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Internet gateway"
  }
}

# Criação do elastic IP pra ser utilizado no Nat Gateway
resource "aws_eip" "eip_ngw" {
  vpc            = true
}

# Criação do Nat Gateway
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.eip_ngw.id
  subnet_id     = aws_subnet.publics_subnets[0].id

  tags = {
    Name = "Nat Gateway"
  }

  depends_on = [aws_internet_gateway.igw]
}

#Uma outra opção ao invés da utilização do depends_on
/*
resource "time_sleep" "wait_60_seconds" {
  depends_on = [aws_nat_gateway.nat]

  create_duration = "60s"
}
*/