### vpc 생성
resource "aws_vpc" "ironworks-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "ironworks-vpc"
    }
}


## Subnet 생성

#public
resource "aws_subnet" "ironworks-sub-public-a" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.1.0/24"
    availability_zone = "ap-northeast-2a"
    #public ip
    map_public_ip_on_launch = true
    
    tags = {
        Name = "ironworks-sub-public-a"
    }
}
resource "aws_subnet" "ironworks-sub-public-c" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.2.0/24"
    availability_zone = "ap-northeast-2c"
    map_public_ip_on_launch = true

    tags = {
        Name = "ironworks-sub-public-c"
    }
}

#Private 
resource "aws_subnet" "ironworks-sub-private-a1" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "ironworks-sub-private-a1"
    }
}
resource "aws_subnet" "ironworks-sub-private-b1" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.20.0/24"
    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "ironworks-sub-private-b1"
    }
}

resource "aws_subnet" "ironworks-sub-private-a2" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.30.0/24"
    availability_zone = "ap-northeast-2a"

    tags = {
        Name = "ironworks-sub-private-a2"
    }
}
resource "aws_subnet" "ironworks-sub-private-b2" {
    vpc_id = aws_vpc.ironworks-vpc.id
    cidr_block = "10.0.40.0/24"
    availability_zone = "ap-northeast-2c"

    tags = {
        Name = "ironworks-sub-private-b2"
    }
}