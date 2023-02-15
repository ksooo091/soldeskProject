# rds.tf
resource "aws_db_subnet_group" "iron_rds_eks" {
  name = "eks_group"
  subnet_ids = [aws_subnet.private_a.id, aws_subnet.private_c.id]
  tags = {
    "Name" = "iron_rds_eks"
  }
}

resource "aws_db_instance" "iron_db" {
  allocated_storage      = 20
  max_allocated_storage  = 50
  vpc_security_group_ids = [aws_security_group.private-rds.id]       ## private-rds 로 잘 설정되어있음.
  db_subnet_group_name   = aws_db_subnet_group.iron_rds_eks.name
  multi_az = true
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  skip_final_snapshot    = true
  identifier             = "test-mysql"
  username               = "root"
  password               = "iron1234"
  name                   = "ironworks"
  port                   = "3306"
}

/*
resource "aws_db_subnet_group" "iron_rds_c" {
  name = "test_c"
  subnet_ids = [aws_subnet.private_c.id, aws_subnet.private_eks2.id]

  tags = {
    "Name" = "iron_rds_c"
  }
}

resource "aws_db_instance" "iron_c" {
  allocated_storage      = 20
  max_allocated_storage  = 50
  vpc_security_group_ids = [aws_security_group.private-az-c.id]
  db_subnet_group_name   = aws_db_subnet_group.iron_rds_c.name
  engine                 = "mysql"
  engine_version         = "8.0.28"
  instance_class         = "db.t2.micro"
  skip_final_snapshot    = true
  identifier             = "test-mysql"
  username               = "root"
  password               = "iron1234"
  name                   = "ironworks"
  port                   = "3306"
}
*/