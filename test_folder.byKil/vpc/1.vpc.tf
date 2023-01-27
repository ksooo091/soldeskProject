### vpc 생성
resource "aws_vpc" "soldesk-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "soldesk-vpc"
    }
}


## Subnet 생성

#public
resource "aws_subnet" "soldesk-sub-public-a" {
    vpc_id = aws_vpc.soldesk-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"
    #public ip
    map_public_ip_on_launch = true
    
    tags = {
        Name = "soldesk-sub-public-a"
    }
}
resource "aws_subnet" "soldesk-sub-public-c" {
    vpc_id = aws_vpc.soldesk-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true

    tags = {
        Name = "soldesk-sub-public-c"
    }
}

