terraform {
  backend "s3" {
    bucket = "s3tfstate-979937110395"
    key    = "state/terraform.tfstate"
    region = "us-east-1"
  }
}