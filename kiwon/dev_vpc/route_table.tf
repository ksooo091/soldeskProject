##_public
resource "aws_route_table" "route_public" {
    vpc_id = "${aws_vpc.iron.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.i-igw.id}"
        nat_gateway_id = "${aws_nat_gateway.nat_a.id}"
    }

    tags = {
        Name = "route_public"
    }
}

resource "aws_route_table_association" "route_public_a" {
    subnet_id = "${aws_subnet.public_a.id}"
    route_table_id = "${aws_route_table.route_public.id}"
}

resource "aws_route_table_association" "route_public_c" {
    subnet_id = "${aws_subnet.public_c.id}"
    route_table_id = "${aws_route_table.route_public.id}"
}

##private A
resource "aws_route_table" "route_private_a" {
    vpc_id = "${aws_vpc.iron.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_a.id}"
    }

    tags = {
        Name = "route_private_a"
    }
}
resource "aws_route_table_association" "private_a" {
    subnet_id = "${aws_subnet.private_a.id}"
    route_table_id = "${aws_route_table.route_private_a.id}"
}

##private C
resource "aws_route_table" "route_private_c" {
    vpc_id = "${aws_vpc.iron.id}"

    route {
        cidr_block = "0.0.0.0/0"
        nat_gateway_id = "${aws_nat_gateway.nat_c.id}"
    }

    tags = {
        Name = "route_private_c"
    }
}

resource "aws_route_table_association" "private_c" {
    subnet_id = "${aws_subnet.private_c.id}"
    route_table_id = "${aws_route_table.route_private_c.id}"
}

##private_EKS1
resource "aws_route_table" "eks_private_a" {
    vpc_id = "${aws_vpc.iron.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.i-igw.id}"
    }

    tags = {
        Name = "eks_private_a"
    }
}

resource "aws_route_table_association" "eks_private_a" {
    subnet_id = "${aws_subnet.private_EKS1.id}"
    route_table_id = "${aws_route_table.eks_private_a.id}"
}

##private_EKS2
resource "aws_route_table" "eks_private_c" {
    vpc_id = "${aws_vpc.iron.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.i-igw.id}"
    }

    tags = {
        Name = "eks_private_c"
    }
}

resource "aws_route_table_association" "eks_private_c" {
    subnet_id = "${aws_subnet.private_EKS2.id}"
    route_table_id = "${aws_route_table.eks_private_c.id}"
}