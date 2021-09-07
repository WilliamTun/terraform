resource "aws_iam_role" "eks_cluster" {
  # Role Name
  name = "eks-cluster"

  # The policy that grants an entity permission to assume the iam role.
  # This is used to grant access to aws resources
  # and to grant the ability to create AWS resources for Kubernetes cluster.  
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

# Resource: aws_iam_role_policy_attachment
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment

resource "aws_iam_role_policy_attachment" "amazon_eks_cluster_policy" {
  # The ARN of the policy you want to apply
  # https://github.com/SummitRoute/aws_managed_policies/blob/master/policies/AmazonEKSClusterPolicy
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

  # The role the policy should be applied to
  role = aws_iam_role.eks_cluster.name
}

# Resource: aws_eks_cluster
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster

resource "aws_eks_cluster" "eks" {
  # Cluster Name
  name = "eks"

  # Amazon Resource Name (ARN) of the IAM role that
  # grants permission to Kubernetes control plane 
  # to communicate with AWS API operations. 
  role_arn = aws_iam_role.eks_cluster.arn

  # Desired Kubernetes master version
  version = "1.18"

  vpc_config {
    # Indicates whether or not the Amazon EKS private API server endpoint is enabled
    endpoint_private_access = false

    # Indicates whether or not the Amazon EKS public API server endpoint is enabled
    endpoint_public_access = true

    # Choice of availability zones to launch to
    subnet_ids = [
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
      aws_subnet.private_1.id,
      aws_subnet.private_2.id
    ]
  }

  # Enforce proper life cycle of IAM Role permission
  # Eg. permissions created before the the EKS cluster spins up
  #     and deleted after the EKS cluster is destroyed. 
  # Otherwise, EC2 infrastructure such as security groups, may not be properly deleted. 
  depends_on = [
    aws_iam_role_policy_attachment.amazon_eks_cluster_policy
  ]
}