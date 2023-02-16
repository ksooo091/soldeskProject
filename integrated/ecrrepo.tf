resource "aws_ecr_repository" "back_ecr" {
  name = "back_test"
}

resource "aws_ecr_repository" "front_ecr_repo" {
  name = "front_test"
}


