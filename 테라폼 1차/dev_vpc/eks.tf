resource "aws_iam_role" "eks_cluster" {
  name = "eks_cluster"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role" "eks_node" {
  name = "eks_node"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_eks_node_group" "eks_node_group" {
    cluster_name = aws_eks_cluster.iron_eks.name
    node_group_name = "eks_node_group"
    subnet_ids = [aws_subnet.private_eks1.id, aws_subnet.private_eks2.id]
    instance_types = ["t3.micro"]
    scaling_config {
      desired_size = 2
      max_size = 3
      min_size = 2
    }
    node_role_arn = aws_iam_role.eks_node.arn
    
}

resource "aws_iam_role_policy_attachment" "iron_eks-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "ec2_read_only_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node.name
}

resource "aws_iam_role_policy_attachment" "AmazoneEKS_CNI_Policy" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
    role       = aws_iam_role.eks_node.name
}

resource "aws_eks_cluster" "iron_eks" {
  name     = "iron_eks"
  role_arn = aws_iam_role.eks_cluster.arn
  
  vpc_config {
    subnet_ids = [aws_subnet.private_eks1.id, aws_subnet.private_eks2.id]
    security_group_ids = [aws_security_group.test-soldesk.id]
    endpoint_private_access = true
    endpoint_public_access = false
  }

  depends_on = [
    aws_iam_role_policy_attachment.iron_eks-AmazonEKSClusterPolicy
  ]
}

resource "aws_security_group" "test-soldesk" {
  name = "test-soldesk"
  vpc_id = aws_vpc.iron.id
}