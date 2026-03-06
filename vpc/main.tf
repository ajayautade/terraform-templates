# ============================================
# Terraform Template: VPC (Virtual Private Cloud)
# Creates a complete network setup with:
# - 1 VPC (your private network in AWS)
# - 2 Public subnets (for web servers, load balancers)
# - 2 Private subnets (for databases, internal services)
# - Internet Gateway (lets public subnets reach the internet)
# - NAT Gateway (lets private subnets download packages)
# ============================================

provider "aws" {
  region = var.aws_region
}

# --- VPC ---
# A VPC is your own isolated network inside AWS
# All your resources (EC2, RDS, etc.) live inside this network
resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr        # IP range for the entire VPC (e.g., 10.0.0.0/16)
  enable_dns_support   = true                # Allows DNS resolution inside the VPC
  enable_dns_hostnames = true                # Gives EC2 instances DNS hostnames

  tags = {
    Name = "${var.project_name}-vpc"
  }
}

# --- Internet Gateway ---
# This allows resources in PUBLIC subnets to connect to the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "${var.project_name}-igw"
  }
}

# --- Public Subnets ---
# Public subnets can directly reach the internet (via Internet Gateway)
# Good for: web servers, load balancers, bastion hosts
resource "aws_subnet" "public_1" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_1_cidr
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true    # EC2 instances here get public IPs automatically

  tags = {
    Name = "${var.project_name}-public-1"
  }
}

resource "aws_subnet" "public_2" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_2_cidr
  availability_zone       = "${var.aws_region}b"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name}-public-2"
  }
}

# --- Private Subnets ---
# Private subnets CANNOT directly reach the internet
# Good for: databases, internal APIs, backend services
resource "aws_subnet" "private_1" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_1_cidr
  availability_zone = "${var.aws_region}a"

  tags = {
    Name = "${var.project_name}-private-1"
  }
}

resource "aws_subnet" "private_2" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.private_subnet_2_cidr
  availability_zone = "${var.aws_region}b"

  tags = {
    Name = "${var.project_name}-private-2"
  }
}

# --- Elastic IP for NAT Gateway ---
# NAT Gateway needs a static public IP
resource "aws_eip" "nat" {
  domain = "vpc"

  tags = {
    Name = "${var.project_name}-nat-eip"
  }
}

# --- NAT Gateway ---
# Allows private subnets to download packages from the internet
# WITHOUT being directly accessible from the internet
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public_1.id    # NAT Gateway lives in a public subnet

  tags = {
    Name = "${var.project_name}-nat"
  }
}

# --- Route Table for Public Subnets ---
# Tells public subnets: "to reach the internet, go through the Internet Gateway"
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"                # All internet traffic
    gateway_id = aws_internet_gateway.igw.id # Goes through Internet Gateway
  }

  tags = {
    Name = "${var.project_name}-public-rt"
  }
}

# Connect public subnets to the public route table
resource "aws_route_table_association" "public_1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = aws_subnet.public_2.id
  route_table_id = aws_route_table.public.id
}

# --- Route Table for Private Subnets ---
# Tells private subnets: "to reach the internet, go through the NAT Gateway"
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id   # Goes through NAT Gateway
  }

  tags = {
    Name = "${var.project_name}-private-rt"
  }
}

# Connect private subnets to the private route table
resource "aws_route_table_association" "private_1" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = aws_subnet.private_2.id
  route_table_id = aws_route_table.private.id
}
