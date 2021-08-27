provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

# terraform {
#   backend "s3" {
#     profile = "terraform"
#     bucket  = "terraform-exemplos-tfstates"
#     key     = "banco/terraform.tfstate"
#     region  = "us-east-1"
#     encrypt = true
#   }
# }