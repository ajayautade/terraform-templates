aws_region         = "ap-south-1"
project_name       = "my-eks-cluster"
k8s_version        = "1.29"
subnet_ids         = ["subnet-xxxxx", "subnet-yyyyy"]  # ⚠️ CHANGE — use your VPC subnet IDs
node_instance_type = "t3.medium"
desired_nodes      = 2
min_nodes          = 1
max_nodes          = 3
