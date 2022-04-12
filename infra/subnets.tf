#Criação das subnets públicas para ser utilizada pelo servidor NGINX e pelo Nat Gateway
resource "aws_subnet" "publics_subnets" {
  count = var.az_count
  vpc_id = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_cidr_base}${var.public_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(", ", var.aws_azs), count.index)
  tags = merge(
    {
      "Name" = "public_az${count.index + 1}"
    },
    var.public_subnet_tags,
  )
}

# Criação das subnets privadas para serem utilizadas no deploy das instâncias EC2 com Apache
resource "aws_subnet" "private_subnets" {
  count             = var.az_count
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "${var.vpc_cidr_base}${var.private_subnet_cidrs[format("zone%d", count.index)]}"
  availability_zone = element(split(", ", var.aws_azs), count.index)
  tags = merge(
    {
      "Name" = "private_subnet_az${count.index + 1}"
    },
    var.private_subnet_tags,
  )
}

# Criação da tabela de roteamento pública para o Internet Gateway
resource "aws_route_table" "public_routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table publica"
  }
}


# Criação da tabela de roteamento privada para o Nat Gateway
resource "aws_route_table" "private_routetable" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "Route Table privada"
  }
}

# Associação das Subnets na Route Table publica
resource "aws_route_table_association" "public_rtassoc" {
  for_each       = local.public_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.public_routetable.id

}

# Associação das Subnets na Route Table privada
resource "aws_route_table_association" "private_rtassoc" {
  for_each       = local.private_ids
  subnet_id      = each.value
  route_table_id = aws_route_table.private_routetable.id
}





