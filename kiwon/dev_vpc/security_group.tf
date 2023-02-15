resource "aws_default_security_group" "bastion_iron" {
    vpc_id = "${aws_vpc.iron.id}"

    ingress {
        protocol = -1
        self = true
        from_port = 0
        to_port = 0
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "iron_default"
    }
}


# Security Group
## public Seucurity Group
resource "aws_security_group" "public-SG" {
  name = "public-SG-01"
  description = "Allow all HTTP"
  vpc_id = "${aws_vpc.iron.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}


# Security Group
## private Seucurity Group
resource "aws_security_group" "private-az-a" {
  name = "private-SG-01"
  description = "Allow HTTP from ALB"
  vpc_id = "${aws_vpc.iron.id}"
  ingress = [ {
      cidr_blocks = null
      description = null
      from_port = 1004
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      protocol = "tcp"
      security_groups = [ aws_security_group.public-SG.id ]
      self = false
      to_port = 1004
  } ]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]
}

## private Seucurity Group
resource "aws_security_group" "private-az-c" {
  name = "private-SG-01"
  description = "Allow HTTP from ALB"
  vpc_id = "${aws_vpc.iron.id}"
  ingress = [ {
      cidr_blocks = null
      description = null
      from_port = 1004
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      protocol = "tcp"
      security_groups = [ aws_security_group.public-SG.id ]
      self = false
      to_port = 1004
  } ]

  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = null
    from_port = 0
    ipv6_cidr_blocks = null
    prefix_list_ids = null
    protocol = "-1"
    security_groups = null
    self = false
    to_port = 0
  } ]
}