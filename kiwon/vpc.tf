# main 이라는 VPC 생성

resource "aws_vpc" "main" {
    # CIDR
    cidr_block = "192.168.0.0/16"

    instance_tenancy = "default"

    enable_dns_support = true
    
    enable_dns_hostnames = true

    enable_classiclink = false

    enable_classiclink_dns_support = false

    assign_generated_ipv6_cidr_block = false

    tags = {
        Name = "main"
    }
}
# 아웃풋이 뭐지? main.id는?
    output "vpc_id" {
        value   = aws_vpc.main.id
        description = "VPC id."

        sensitive = false
    }

