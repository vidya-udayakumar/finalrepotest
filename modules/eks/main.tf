provider "aws" {
  region = "ap-south-1"
}

resource "aws_eks_cluster" "eks_cluster_Dev" {
  name     = var.name
  role_arn = aws_iam_role.iam_role_eks.arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }
  version = var.cluster_version

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.iam_role_policy_attachment_AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.iam_role_policy_attachment_AmazonEKSVPCResourceController,
  ]
}

resource "aws_iam_role" "iam_role_eks" {
  name = "eks-cluster-dev-role-${var.name}"

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


#Assigns AmazonEKSClusterPolicy to EKS via role
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.iam_role_eks.name
}

# Optionally, enable Security Groups for Pods
# Reference: https://docs.aws.amazon.com/eks/latest/userguide/security-groups-for-pods.html

#Assigns AmazonEKSVPCResourceController to EKS via role
resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.iam_role_eks.name
}
