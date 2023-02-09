provider "aws" {
    region = "ap-northeast-2"
    access_key = ""
    secret_key = ""
}
terraform {
  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "4.52.0"
    }
  }
}