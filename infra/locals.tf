locals {
  # Variável para criação da associação das subnets com o route table
  public_ids = { for k, v in aws_subnet.publics_subnets : v.tags.Name => v.id }
  private_ids = {  for k, v in aws_subnet.private_subnets : v.tags.Name => v.id }
}