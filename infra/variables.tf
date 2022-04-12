# Definição da região da AWS
variable "aws_region" {
  type        = string
  description = ""
  default     = "us-east-1" #Região Norte da Virgínia
}

# Definição de quais zonas de disponibilidades serão utilizadas para deploy das EC2
variable "aws_azs" {
  description = "comma separated string of availability zones in order of precedence"
  default     = "us-east-1a, us-east-1b, us-east-1c"
}

# Definição da quantidade de instâncias com apache
variable "az_count" {
  description = "number of active availability zones in VPC"
  default     = "3"
}

# Definição do endereço das subnets públicas
variable "public_subnet_cidrs" {
  description = "CIDRs for the public subnets"
  default = {
    zone0 = ".4.0/24"
    zone1 = ".5.0/24"
    zone2 = ".6.0/24"
  }
}

# Definição da variavél de security group do nginx via dynamic block
variable "sg_nginx_ingress" {
  type = map(any)
  default = {
    "80" = ["0.0.0.0/0"]
    "8080" = ["0.0.0.0/0"]
    "22" = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
  }
}

# Definição da variavél de security group do apache via dynamic block
variable "sg_apache_ingress" {
  type = map(any)
  default = {
    "3001" = ["0.0.0.0/0"]
    "3002" = ["0.0.0.0/0"]
    "3003" = ["0.0.0.0/0"]
    "22" = ["0.0.0.0/0"]
    "443" = ["0.0.0.0/0"]
  }
}

# Definição de tags exclusivas das subnets públicas
variable "public_subnet_tags" {
  description = "Tags to apply to the public subnets"
  default     = {}
}

# Definição das tags exclusivas das subnets privadas
variable "private_subnet_tags" {
  description = "Tags to apply to the private working subnets"
  default     = {}
}

# Definição do endereço das subnets privadas
variable "private_subnet_cidrs" {
  description = "CIDRs for the public subnets"
  default = {
    zone0 = ".1.0/24"
    zone1 = ".2.0/24"
    zone2 = ".3.0/24"
  }
}

# Definição da base do endereço da VPC
variable "vpc_cidr_base" {
  default = "10.0"
}

# Definição de tags exclusivas da tabela de roteamento pública
variable "public_route_table_tags" {
  description = "Tags to apply to the public route table"
  default = {}
}

# Definição de tags exclusivas da tabela de roteamento privada
variable "private_route_table_tags" {
  description = "Tags to apply to the private route table"
  default = {}
}

# Definição da AMI Linux
variable "ami" {
  type        = string
  description = ""
  default     = "ami-0c02fb55956c7d316" #AMI Linux
}

# Definação do tipo da instância do EC2
variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro" #Free Tier
}