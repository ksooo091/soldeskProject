resource "aws_iam_policy_attachment" "kiwon_policy" {
   name       = "kiwon_policy"
   users      = [aws_iam_user.user_kiwon.name]
   policy_arn =  "arn:aws:iam::aws:policy/AmazonVPCFullAccess"
 }

resource "aws_iam_policy_attachment" "joonpyo_watchlog_policy" {
  name       = "user_joonpyo_watchlog_policy"
  users      = [aws_iam_user.user_joonpyo.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
}

resource "aws_iam_policy_attachment" "joonpyo_waf_policy" {
  name       = "user_joonpyo_waf_policy"
  users      = [aws_iam_user.user_joonpyo.name]
  policy_arn = "arn:aws:iam::aws:policy/AWSWAFFullAccess"
}
resource "aws_iam_policy_attachment" "joonpyo_watch_policy" {
  name       = "user_joonpyo_watch_policy"
  users      = [aws_iam_user.user_joonpyo.name]
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchFullAccess"

}

resource "aws_iam_policy_attachment" "user_jinha" {
  name       = "user_jinha"
  users      = [aws_iam_user.user_jinha.name]
  policy_arn =  "arn:aws:iam::aws:policy/AmazonRDSFullAccess"
}

