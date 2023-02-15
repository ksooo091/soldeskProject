provider "aws" {
  region = "ap-northeast-2"
}
resource "aws_acm_certificate" "cert" {
  domain_name       = "*.jecheolso.site"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}