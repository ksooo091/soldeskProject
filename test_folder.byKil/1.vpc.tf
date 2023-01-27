### vpc 생성
resource "aws_vpc" "soldesk-vpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    instance_tenancy = "default"
    tags = {
        Name = "soldesk-vpc"
    }
}

### 인터넷 gateway 생성
resource "aws_internet_gateway" "sold-igw" {
    vpc_id = aws_vpc.soldesk-vpc
    tags = {
        Name = "sold-igw"
    }
}
.
#################################안녕하세요.
