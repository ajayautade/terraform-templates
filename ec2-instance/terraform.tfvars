# ============================================
# terraform.tfvars — PUT YOUR VALUES HERE
# ============================================

aws_region    = "ap-south-1"          # Change to your preferred AWS region
project_name  = "my-ec2-server"       # Name for your server
instance_type = "t2.micro"            # t2.micro = free tier | t2.medium = more power
key_pair_name = "your-key-pair-name"  # ⚠️ CHANGE THIS to your actual AWS key pair name
volume_size   = 20                    # Disk space in GB
my_ip         = "0.0.0.0/0"          # ⚠️ CHANGE THIS to your IP (e.g., "1.2.3.4/32")
custom_port   = 8080                  # Extra port to open (Jenkins=8080, Grafana=3000)
