terraform {
  backend "s3" {

    region         = "us-east-1"
    dynamodb_table = "terraform-state-lock"

  }
}

provider "aws" {
  region = "us-east-1"
}
