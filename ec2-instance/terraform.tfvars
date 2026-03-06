# ============================================
# terraform.tfvars — PUT YOUR VALUES HERE
# ============================================

aws_region    = "ap-south-1"             # Your AWS Region (e.g., us-east-1, ap-south-1)
project_name  = "YOUR_INSTANCE_NAME"     # Name for your EC2 server (e.g., my-web-server)
instance_type = "t2.micro"               # Instance size (t2.micro is free tier)
key_pair_name = "YOUR_KEY_PAIR_NAME"     # ⚠️ The name of your AWS Key Pair (without .pem)
volume_size   = 20                       # Disk space in GB
my_ip         = "YOUR_IP_ADDRESS/32"     # ⚠️ Your Public IP (Find at whatismyip.com) e.g., "1.2.3.4/32"
custom_port   = 8080                     # Extra port to open (Jenkins=8080, Grafana=3000, etc.)
