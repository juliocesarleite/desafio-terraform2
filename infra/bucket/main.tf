provider "aws" {
  version = "~> 3.0"
  region  = "us-east-1"
}

data "aws_caller_identity" "current" {}

# Cria o bucket S3
resource "aws_s3_bucket" "remotestate" {
  bucket = "s3tfstate-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Remote State"
    Environment = "Dev"
  }

  versioning {
    enabled = true
  }
}

#Bloqueia o acesso a internet
resource "aws_s3_bucket_public_access_block" "block_public_acess" {
  bucket = aws_s3_bucket.remotestate.id

  block_public_acls   = true
  block_public_policy = true
}

output "remote_state_bucket" {
  value = aws_s3_bucket.remotestate.bucket
}

output "remote_state_bucket_arn" {
  value = aws_s3_bucket.remotestate.arn
}