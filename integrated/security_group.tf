
resource "aws_default_security_group" "iron_default_sg" {
    vpc_id = "${aws_vpc.iron.id}"

    ingress {
        protocol = "-1"
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
}




# # Security Group
# ## private Seucurity Group

# 인바운드 SSH 포트 허용, 소스를 bastion SG 로 설정하기
resource "aws_security_group" "private-eks" {
  name = "private-eks"
  description = "eks-private"
  vpc_id = "${aws_vpc.iron.id}"
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
  }
  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
}

resource "aws_security_group" "private-rds" {
  name = "private-rds"
  description = "rds-private"
  vpc_id = "${aws_vpc.iron.id}"  
#   ingress {
#     security_groups = [aws_security_group.test-soldesk.id]
#     from_port = 3306
#     protocol = "tcp"
#     to_port = 3306
#   }
     ingress {
    security_groups = [aws_security_group.bastion.id]
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
  }
       ingress {
    security_groups = [aws_eks_cluster.iron_eks.vpc_config[0].cluster_security_group_id]
    from_port = 3306
    protocol = "tcp"
    to_port = 3306
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}


