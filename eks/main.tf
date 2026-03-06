# ============================================
# Terraform Template: EKS Cluster
# Creates a managed Kubernetes cluster on AWS
# EKS = Elastic Kubernetes Service
# AWS manages the control plane, you manage the worker nodes
# ============================================

provider "aws" {
  region = var.aws_region
}

# --- IAM Role for EKS Cluster ---
# EKS needs an IAM role to manage AWS resources on your behalf
resource "aws_iam_role" "eks_cluster_role" {
  name = "${var.project_name}-eks-cluster-role"

  # This policy says "EKS service is allowed to use this role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks.amazonaws.com"
      }
    }]
  })
}

# Attach the required AWS-managed policy to the EKS role
resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster_role.name
}

# --- IAM Role for Worker Nodes ---
# Worker nodes need their own role to join the cluster and pull container images
resource "aws_iam_role" "eks_node_role" {
  name = "${var.project_name}-eks-node-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
  })
}

# Attach required policies for worker nodes
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

resource "aws_iam_role_policy_attachment" "ecr_read_only" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}

# --- EKS Cluster ---
# This creates the Kubernetes control plane (the brain of the cluster)
resource "aws_eks_cluster" "cluster" {
  name     = var.project_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = var.k8s_version

  vpc_config {
    subnet_ids = var.subnet_ids   # Subnets where the cluster will run
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]
}

# --- Node Group ---
# These are the actual EC2 instances (worker nodes) that run your containers
resource "aws_eks_node_group" "nodes" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "${var.project_name}-nodes"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_ids

  instance_types = [var.node_instance_type]

  # How many worker nodes to run
  scaling_config {
    desired_size = var.desired_nodes   # Start with this many
    min_size     = var.min_nodes       # Never go below this
    max_size     = var.max_nodes       # Never go above this
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ecr_read_only,
  ]
}
