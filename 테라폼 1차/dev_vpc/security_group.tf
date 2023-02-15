# 배스천 보안
resource "aws_default_security_group" "bastion_iron" {
    vpc_id = "${aws_vpc.iron.id}"
# IPV4 anywhere 0.0.0.0/0 으로 바꾸기
# ingress 포트번호 22 만 허용
    ingress {
        protocol = "-1"
        self = true
        from_port = 0
        to_port = 0
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




# Security  Group
## private Seucurity Group

# 인바운드 SSH 포트 허용, 소스를 bastion SG 로 설정하기
# EKs 안클러스터 보그룹
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

# eks 노드 보안그룹
resource "aws_security_group" "private-eks-node1" {
    vpc_id = "${aws_vpc.iron.id}"
    name = "private-eks-node1"
    description = "eks-node1"
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group_rule" "node1-rule" {
    security_group_id = aws_security_group.private-eks-node1.id
    source_security_group_id = aws_security_group.bastion.id
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "node1-rule"
}


resource "aws_security_group" "private-eks-node2" {
    vpc_id = "${aws_vpc.iron.id}"
    name = "private-eks-node2"
    description = "eks-node2"
    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group_rule" "node2-rule" {
    security_group_id = aws_security_group.private-eks-node2.id
    source_security_group_id = aws_security_group.bastion.id
    type = "ingress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    description = "node2-rule"
}

##길수님이 원하시는 요청 (RDS 가 node SG 허가)
## private Seucurity Group
#RDS 보안그룹 설정
resource "aws_security_group" "private-rds" {
  name = "private-rds"
  description = "rds-private"
  vpc_id = "${aws_vpc.iron.id}"  # 이건 올바른 vpc id 로 되었음.
}

resource "aws_security_group_rule" "private-rds-rule-in" {
    security_group_id = aws_security_group.private-rds.id
    source_security_group_id = aws_security_group.private-eks-node1.id
    type = "ingress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    description = "Allow communicate with RDS"   
}
resource "aws_security_group_rule" "private-rds-rule-out" {
    security_group_id = aws_security_group.private-rds.id
    source_security_group_id = aws_security_group.private-eks-node1.id
    type = "egress"
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    description = "Allow communicate with RDS"   
}



######ALB GROUP

resource "aws_security_group" "alb_sg" {
  name        = "alb_security_group"
  description = "Allow inbound HTTP traffic"
  vpc_id      = aws_vpc.iron.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    name = "alb_sg"
  }
}