resource "aws_iam_role" "nodes-general" {
  name               = "eks-node-group-general"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-worker-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.nodes-general.name
}

resource "aws_iam_role_policy_attachment" "eks-cni-node-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.nodes-general.name
}

resource "aws_iam_role_policy_attachment" "ec2-container-registry-read-only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.nodes-general.name
}

resource "aws_iam_role_policy_attachment" "cloudwatch-logs-full-access" {
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLogsFullAccess"
  role       = aws_iam_role.nodes-general.name
}

resource "aws_eks_node_group" "nodes-general" {
  cluster_name    = aws_eks_cluster.eks.name
  node_group_name = "nodes-general"
  node_role_arn   = aws_iam_role.nodes-general.arn
  subnet_ids      = [
    aws_subnet.private-1.id,
    aws_subnet.private-2.id
  ]
  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }
  ami_type             = "AL2_x86_64"
  capacity_type        = "ON_DEMAND"
  disk_size            = 20
  force_update_version = false
  instance_types       = ["t2.medium"]
  labels               = {
    role = "nodes-general"
  }
  version    = "1.21"
  depends_on = [
    aws_iam_role_policy_attachment.eks-worker-node-policy,
    aws_iam_role_policy_attachment.eks-cni-node-policy,
    aws_iam_role_policy_attachment.ec2-container-registry-read-only,
    aws_iam_role_policy_attachment.cloudwatch-logs-full-access
  ]
  tags   = {
    Name = "nodes-general"
  }
}