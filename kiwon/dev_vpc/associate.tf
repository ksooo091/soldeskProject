### vpc endpoint associate
/*
resource "aws_vpc_endpoint_route_table_association" "private-a-end" {
  route_table_id = aws_route_table.eks_private_a.id
  vpc_endpoint_id = aws_subnet_endpoint.private_a.id
}

resource "aws_vpc_endpoint_route_table_association" "private-c-end" {
  route_table_id = aws_route_table.eks_private_c.id
  vpc_endpoint_id = aws_subnet_endpoint.private_c.id
}


### subnet associate
#eks subnet
resource "aws_route_table_association" "private-a-eks" {
  subnet_id = aws_subnet.private_EKS1.id
  route_table_id = aws_route_table.eks_private_a.id
}

resource "aws_route_table_association" "private-c-eks" {
  subnet_id = aws_subnet.private_EKS2.id
  route_table_id = aws_route_table.eks_private_c.id
}
#public ec2 subnet
resource "aws_route_table_association" "public-association-01" {
  subnet_id = aws_subnet.public_a.id
  route_table_id = aws_route_table.route_public_a.id
}

resource "aws_route_table_association" "public-association-02" {
  subnet_id = aws_subnet.public_c.id
  route_table_id = aws_route_table.route_public_c.id
}
#private rds subnet
resource "aws_route_table_association" "private-rds-a" {
  subnet_id = aws_subnet.private_a.id
  route_table_id = aws_route_table.route_private_a.id
}

resource "aws_route_table_association" "private-rds-c" {
  subnet_id = aws_subnet.private_c.id
  route_table_id = aws_route_table.route_private_c.id
}



resource "aws_subnet_endpoint_association" "eks-a-association" {
  subnet_id = aws_subnet.private_EKS1.id
  subnet_endpoint_id = aws_subnet.public_a.id
}

resource "aws_subnet_association" "eks-c-association" {
  subnet_id = aws_subnet.private_EKS2.id
  subnet_endpoint_id = aws_subnet.public_c.id
}

*/