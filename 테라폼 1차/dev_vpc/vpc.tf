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
resource "aws_vpc_endpoint" "rds" {
    vpc_id = aws_vpc.iron.id
    service_name = "com.amazonaws.ap-northeast-2.rds"
    vpc_endpoint_type = "Interface"
}


###vpc endpoint associate
resource "aws_vpc_endpoint_route_table_association" "priavate_rds_a" {
    route_table_id = aws_route_table.eks_private_a.id
    vpc_endpoint_id = aws_vpc_endpoint.rds.id
}

resource "aws_vpc_endpoint_route_table_association" "private_rds_c" {
    route_table_id = aws_route_table.eks_private_c.id
    vpc_endpoint_id = aws_vpc_endpoint.rds.id
}

*/