resource "aws_iam_role" "eks-cluster" {
  name = "eks-cluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_iam_role_policy_attachment" "eks-vpc-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-cluster.name
}

resource "aws_eks_cluster" "eks" {
  name     = "eks"
  role_arn = aws_iam_role.eks-cluster.arn
  version  = "1.21"
  enabled_cluster_log_types = ["api", "audit"]
  depends_on = [aws_cloudwatch_log_group.eks-logs]
  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    security_group_ids = [aws_security_group.eks-cluster-sg.id]
    subnet_ids = [
      aws_subnet.private-1.id,
      aws_subnet.private-2.id,
      aws_subnet.public-1.id,
      aws_subnet.public-2.id]
  }
  tags = {
    Name = "eks"
  }
}

resource "aws_cloudwatch_log_group" "eks-logs" {
  name              = "/aws/eks/eks/cluster"
  retention_in_days = 7
}