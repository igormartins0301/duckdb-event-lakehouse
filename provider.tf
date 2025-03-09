# terraform {
#   required_version = ">= 1.0"

#   backend "s3" {
#     bucket = "nome-do-seu-bucket-terraform"
#     key    = "terraform.tfstate"
#     region = "us-east-1"
#   }
# }

provider "aws" {
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::443370712526:role/principal-terraform-project"
    session_name = "github-actions"
  }
}
