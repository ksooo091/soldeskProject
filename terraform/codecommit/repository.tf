resource "aws_codecommit_repository" "backend-server" {
  repository_name = "backend-server"
  description     = "Backend demo"
}

resource "aws_codecommit_repository" "frontend-server" {
  repository_name = "frontend-server"
  description     = "Frontend demo"
}