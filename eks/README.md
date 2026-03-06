# EKS Cluster Template

## What This Creates
- 1 EKS Cluster (managed Kubernetes on AWS)
- 1 Node Group (worker EC2 instances that run your containers)
- IAM Roles (permissions for the cluster and nodes)

## Prerequisites
- **VPC with subnets** — Create VPC first using the `vpc/` template
- **kubectl installed** — To interact with the cluster

## Step-by-Step Guide

### 1. Create a VPC first (if you don't have one)
```bash
cd ../vpc
terraform init && terraform apply
terraform output    # Copy the subnet IDs
```

### 2. Go to this folder
```bash
cd ../eks
```

### 3. Edit your values
Open `terraform.tfvars`:
```hcl
aws_region         = "ap-south-1"
project_name       = "my-eks-cluster"
k8s_version        = "1.29"
subnet_ids         = ["subnet-xxxxx", "subnet-yyyyy"]  # ⚠️ From VPC output
node_instance_type = "t3.medium"                        # Minimum for EKS
desired_nodes      = 2                                  # Number of worker nodes
min_nodes          = 1
max_nodes          = 3
```

### 4. Deploy (takes 10-15 minutes!)
```bash
terraform init
terraform plan
terraform apply     # ⏳ This takes a while — EKS cluster creation is slow
```

### 5. Configure kubectl
```bash
# Run the command from terraform output
aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster

# Verify connection
kubectl get nodes
```

### 6. Deploy your app
```bash
kubectl apply -f your-deployment.yaml
kubectl get pods
```

### 7. Destroy when done (⚠️ EKS costs ~$0.10/hour!)
```bash
terraform destroy
```

## ⚠️ Cost Warning
- EKS control plane costs **$0.10/hour (~$73/month)** even with no workloads
- Worker nodes cost depends on instance type
- **Always destroy when not using!**

## Files

| File | Purpose |
|------|---------|
| `main.tf` | EKS cluster + node group + IAM roles |
| `variables.tf` | Cluster config (version, node size, count) |
| `terraform.tfvars` | **Your values here** |
| `outputs.tf` | Cluster name, endpoint, kubectl command |
