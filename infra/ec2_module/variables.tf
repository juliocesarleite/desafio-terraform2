# Definição da AMI Linux
variable "ami" {
  type        = string
  description = ""
  default     = "ami-0c02fb55956c7d316" #AMI Linux
}

# Definição do tipo de instância EC2
variable "instance_type" {
  type        = string
  description = ""
  default     = "t2.micro" #Free Tier
}

# Definição do nome da chave
variable "key_name" {
  type        = string
  description = ""
  default     = ""
}

# Definição dos id do security group da VPC
variable "vpc_security_group_ids" {
  type        = list
  description = ""
}

# Definição da subnet
variable "subnet_id" {
  type        = string
  description = ""
  default     = ""
}

# Definição do ip privado
variable "private_ip" {
  type        = string
  description = ""
  default     = ""
}

# Definição das Tags das instâncias
variable "tags" {
  type        = map(string)
  description = ""
  default     = {
    Project   = "KT Terraform 2"
    CreatedAt = "2022-03-31"
    ManagedBy = "Terraform"
    Owner     = "Julio Leite"
  }
}

# Definição da variável de associação de ip público
variable "associate_public_ip_address" {
  type        = string
  description = ""
  default     = true
}

# Definição da variável de dados de usuário
variable "user_data" {
  type        = string
  description = ""
  default     = ""
}