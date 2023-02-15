provider "aws" {
    region = "ap-northeast-2"
    access_key = "AKIAZT3IHXRVP3XXFAFP"
    secret_key = "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"
}


terraform {
  required_providers {
    kubectl = {
      source = "gavinbunney/kubectl"
      version = ">= 1.14.0"
    }
    helm = {
      source = "hashicorp/helm"
      version = ">= 2.6.0"
    }
  }

  required_version = "~> 1.0"
}