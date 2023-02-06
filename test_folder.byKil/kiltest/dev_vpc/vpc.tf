resource "aws_vpc" "iron" {
    cidr_block = "172.20.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true
    instance_tenancy = "default"

    tags = {
        Name = "iron"
    }
}



/*
내일 
vpc 합쳐보고
엔드포인트나 association 정해서 길 연결하기 !!!
*/