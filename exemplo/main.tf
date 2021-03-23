provider "aws" {
  region  = "us-east-1"
  profile = "terraform"
}

/*terraform {
  backend "s3" {
    profile = "terraform"
    bucket  = "terraform-exemplos-tfstates"
    key     = "banco/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}*/

/*data "terraform_remote_state" "infra" {
  backend = "s3"
  config = {
    profile = "terraform"
    bucket  = "terraform-exemplos-tfstates"
    key     = "infra/terraform.tfstate"
    region  = "us-east-1"
  }
}*/