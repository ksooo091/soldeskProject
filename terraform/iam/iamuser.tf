resource "aws_iam_user" "user_kiwon"{
    name = "userkiwon"
    # tags = {
    #   "temauser" = "name"
    # }
}

resource "aws_iam_user" "user_joonpyo"{
    name = "userjoonpyo"
    # tags = {
    #   "temauser" = "name"
    # }
}

resource "aws_iam_user" "user_jinha"{
    name = "userjinha"
    # tags = {
    #   "temauser" = "name"
    # }
}
resource "aws_iam_user" "user_gilsu"{
    name = "usergilsu"
    # tags = {
    #   "temauser" = "name"
    # }
}

resource "aws_iam_access_key" "user_kiwon" {
  user    = aws_iam_user.user_kiwon.name
}

resource "aws_iam_access_key" "user_joonpyo" {
  user    = aws_iam_user.user_joonpyo.name
}

resource "aws_iam_access_key" "user_jinha" {
  user    = aws_iam_user.user_jinha.name
}

resource "aws_iam_access_key" "user_gilsu" {
  user    = aws_iam_user.user_gilsu.name
}

resource "aws_iam_user_login_profile" "user_gilsu" {
  user    = aws_iam_user.user_gilsu.name
  password_reset_required = true
}

resource "aws_iam_user_login_profile" "user_jinha" {
  user    = aws_iam_user.user_jinha.name
  password_reset_required = true
}
resource "aws_iam_user_login_profile" "user_joonpyo" {
  user    = aws_iam_user.user_joonpyo.name
  password_reset_required = true
}
resource "aws_iam_user_login_profile" "user_kiwon" {
  user    = aws_iam_user.user_kiwon.name
  password_reset_required = true
}

output "password" {
  value = aws_iam_user_login_profile.user_gilsu.encrypted_password
}