provider "aws" {
    region = "ap-northeast-2"
    access_key = "AKIARL5BV3NS3G5TD5WA"
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