resource "aws_iam_user" "eks_user"{
    name = "eks_user"
    tags = {
      "temauser" = "name"
    }
}



resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  users      = [aws_iam_user.eks_user.name]
  policy_arn =  "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}
