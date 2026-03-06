aws_region         = "ap-south-1"               # Your AWS Region
project_name       = "YOUR_EKS_CLUSTER_NAME"    # Name for your Kubernetes cluster
k8s_version        = "1.29"                     # Kubernetes version
subnet_ids         = ["YOUR_SUBNET_1", "YOUR_SUBNET_2"] # ⚠️ Subnet IDs (Get from VPC output)
node_instance_type = "t3.medium"                # Minimum recommended for EKS
desired_nodes      = 2                          # How many worker nodes to run
min_nodes          = 1
max_nodes          = 3
