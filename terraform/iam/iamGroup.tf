resource "aws_iam_group" "eks_group"{
 name = "eksGroup"
}


resource "aws_iam_group_policy_attachment" "eks_group_attach" {
  group      = aws_iam_group.eks_group.name
  policy_arn =  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_group_membership" "eksteam" {
  name = "eks-group-membership"

  users = [
    aws_iam_user.user_kiwon.name,
    aws_iam_user.user_joonpyo.name,
    aws_iam_user.user_jinha.name,
    aws_iam_user.user_gilsu.name,
  ]

  group = aws_iam_group.eks_group.name
}