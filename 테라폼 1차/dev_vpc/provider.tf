provider "aws" {
    region = "ap-northeast-2"
    access_key = "AKIAZT3IHXRVF4LVFZ47"
    secret_key = "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"
}
terraform {
  required_providers {
    aws = {
    source = "hashicorp/aws"
    version = "4.52.0"
    }
  }
}