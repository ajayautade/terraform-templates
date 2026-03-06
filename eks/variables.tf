variable "aws_region" {
  description = "AWS region"
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name for the EKS cluster"
  default     = "my-eks-cluster"
}

variable "k8s_version" {
  description = "Kubernetes version"
  default     = "1.29"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the cluster (use output from VPC template)"
  type        = list(string)
}

variable "node_instance_type" {
  description = "EC2 instance type for worker nodes (t3.medium recommended minimum)"
  default     = "t3.medium"
}

variable "desired_nodes" {
  description = "Number of worker nodes to start with"
  default     = 2
}

variable "min_nodes" {
  description = "Minimum number of worker nodes"
  default     = 1
}

variable "max_nodes" {
  description = "Maximum number of worker nodes (for auto-scaling)"
  default     = 3
}
