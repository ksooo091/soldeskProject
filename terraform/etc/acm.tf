resource "aws_acm_certificate" "cert" {
  domain_name       = "*.https://jecheolso.site/"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}