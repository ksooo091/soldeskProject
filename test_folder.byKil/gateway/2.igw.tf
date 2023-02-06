### 인터넷 gateway 생성
resource "aws_internet_gateway" "sold-igw" {
    vpc_id = aws_vpc.soldesk-vpc
    tags = {
        Name = "sold-igw"
    }
}

#public >>>> igw
resource "aws_route_table" "soldesk-public-rt" {
    vpc_id = aws_vpc.soldesk-vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.soldesk-igw.id
    }
    tags = {
        Name = "soldesk-public-rt"
    }
}

# public subnet 을 public route table에 연결
resource "aws_route_table_association" "soldesk-route-public-a" {
    subnet_id = aws_subnet.soldesk-sub-public-a.id
    route_table_id = aws_route_table.soldesk-public-rt.id
}

resource "aws_route_table_association" "soldesk-route-public-c" {
    subnet_id = aws_subnet.soldesk-sub-public-c.id
    route_table_id = aws_route_table.soldesk-public-rt.id
}

#private web >>>>> natgate
/*
resource "aws_route_table" "soldesk-route-private" {
    vpc_id = aws_vpc.soldesk-vpc.id

    tags = {
        Name = "soldesk-route-private"
    }
}

resource "aws_route" "soldesk-route-private-web" {
    route_table_id = aws_route_table.soldesk-public-rt.id
    destination_cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.soldesk-ngw.id
}
*/

#Private web subnet 을 private route table에 연결
resource "aws_route_table_association" "soldesk-rtass-private-Aweb" {
    subnet_id = aws_subnet.soldesk-sub-private-a.id
    route_table_id = aws_route_table.soldesk-rtass-private-Aweb.id 
}

resource "aws_route_table_association" "soldesk-rtass-private-Cweb" {
    subnet_id = aws_subnet.soldesk-sub-private-c.id
    route_table_id = aws_route_table.soldesk-rtass-private-Cweb.id
}
