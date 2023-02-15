
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


##Security private
/*resource "aws_security_group" "private-all" {
  vpc_id = aws_vpc.iron.id
  name   = "private_all"
  description = "private_all"
}
*/

# Security Group
## private Seucurity Group

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
  /*egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }
*/
}
##길수님이 원하시는 요청 (RDS 가 node SG 허가)
## private Seucurity Group
resource "aws_security_group" "private-rds" {
  name = "private-rds"
  description = "rds-private"
  vpc_id = "${aws_vpc.iron.id}"  # 이건 올바른 vpc id 로 되었음.
  /*ingress = [ {
      cidr_blocks = null
      description = null
      from_port = 0          # MySQL/Aurora 로 설정해야함. (TCP /3306)
      ipv6_cidr_blocks = null
      prefix_list_ids = null
      protocol = -1
      security_groups = null     # EC2 보안그룹으로 바꿔야 함. sg-0d50317b04c77642d (eks-cluster-sg-iron)
      # rds SG\ sg-04b981c82ae6c1771 (생성한 보안그룹 ID)	private-rds
      self = false
      to_port = 0
  } ]
  */
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