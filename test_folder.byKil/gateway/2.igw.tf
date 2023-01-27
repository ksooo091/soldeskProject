### 인터넷 gateway 생성
resource "aws_internet_gateway" "sold-igw" {
    vpc_id = aws_vpc.soldesk-vpc
    tags = {
        Name = "sold-igw"
    }
}