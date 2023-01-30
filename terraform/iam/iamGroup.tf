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

resource "aws_iam_policy" "mfa_policy" {
  name        = "mfa_policy"
  description = "mfa 생성허용 정책"
  policy      = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowViewAccountInfo",
            "Effect": "Allow",
            "Action": "iam:ListVirtualMFADevices",
            "Resource": "*"
        },
        {
            "Sid": "AllowManageOwnVirtualMFADevice",
            "Effect": "Allow",
            "Action": [
                "iam:CreateVirtualMFADevice"
            ],
            "Resource": "arn:aws:iam::*:mfa/*"
        },
        {
            "Sid": "AllowManageOwnUserMFA",
            "Effect": "Allow",
            "Action": [
                "iam:DeactivateMFADevice",
                "iam:EnableMFADevice",
                "iam:GetUser",
                "iam:ListMFADevices",
                "iam:ResyncMFADevice"
            ],
            "Resource": "arn:aws:iam::*:user/$${aws:username}"
        },
        {
            "Sid": "DenyAllExceptListedIfNoMFA",
            "Effect": "Deny",
            "NotAction": [
                "iam:CreateVirtualMFADevice",
                "iam:EnableMFADevice",
                "iam:GetUser",
                "iam:ListMFADevices",
                "iam:ListVirtualMFADevices",
                "iam:ResyncMFADevice",
                "sts:GetSessionToken"
            ],
            "Resource": "*",
            "Condition": {
                "BoolIfExists": {"aws:MultiFactorAuthPresent": "false"}
            }
        }
    ]
})
  
}

resource "aws_iam_group_policy_attachment" "mfa_attach" {
  group      = aws_iam_group.eks_group.name
  policy_arn = aws_iam_policy.mfa_policy.arn

}