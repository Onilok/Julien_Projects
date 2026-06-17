provider "aws" {
  region = "eu-west-3"
}

# VPC CREATION

module "vpc" {
  source = "./modules/vpc"
}

# NLB Network load balancer Amazon
module "nlb" {
  source               = "./modules/nlb"
  nlb_name             = "penpot-nlb"
  subnets              = module.vpc.public_subnets
  vpc_id               = module.vpc.vpc_id
  traefik_instance_ids = module.traefik.instance_ids
}

# Bucket S3 AWS
module "s3" {
  source      = "./modules/s3"
  bucket_name = "penpot-s3-prd-bucket"
  folders     = ["database", "logs"]
}

# EC2 S3 bucket access
module "iam" {
  source     = "./modules/iam"
  name       = "penpot"
  bucket_arn = module.s3.bucket_arn
}

# Penpot asset S3 access
module "penpot_s3_auth" {
  source      = "./modules/s3-auth"
  bucket_name = "penpot-s3-prd-bucket"
  user_name   = "penpot"
}

# OS DEFINITION 
data "aws_ami" "debian13" {
  most_recent = true
  owners      = ["136693071363"] # propriétaire officiel Debian

  filter {
    name   = "name"
    values = ["debian-13-amd64-*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# SSH KEYS

resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion"
  public_key = file("./ssh-key/bastion-sshkey.pub") 
}

resource "aws_key_pair" "traefik" {
  key_name   = "traefik"
  public_key = file("./ssh-key/traefik-sshkey.pub")
}

# Bastion SG
resource "aws_security_group" "bastion_sg" {
  name   = "penpot-bastion-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "SSH depuis Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH depuis Internet TCP/4242"
    from_port   = 4242
    to_port     = 4242
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus monitoring"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24"]
  }

  ingress {
    description = "Prometheus monitoring"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24"]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "penpot-bastion-sg"
  }
}

# Traefik SG
resource "aws_security_group" "traefik_sg" {
  name   = "penpot-traefik-sg"
  vpc_id = module.vpc.vpc_id

  # SSH 
  ingress {
    description = "SSH from Bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "HTTP from NLB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Traefik dashboard
  ingress {
    description = "HTTP from NLB"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["88.160.62.238/32"]
  }

  # Grafana dashboard - ip src to review !
  ingress {
    description = "Grafana access from www by traefik"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["88.160.62.238/32", "82.121.249.235/32", "88.165.199.123/32"]
  }

  ingress {
    description = "HTTPS from NLB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Prometheus monitoring"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24"]
  }

  ingress {
    description = "Prometheus monitoring"
    from_port   = 9095
    to_port     = 9095
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "bastion" {
  source             = "./modules/bastion"
  ami_id             = data.aws_ami.debian13.id
  ssh_key_name       = aws_key_pair.bastion_key.key_name
  public_subnets     = module.vpc.public_subnets
  security_group_ids = [aws_security_group.bastion_sg.id]
}

module "traefik" {
  source             = "./modules/traefik"
  ami_id             = data.aws_ami.debian13.id
  ssh_key_name       = aws_key_pair.traefik.key_name
  public_subnets     = module.vpc.public_subnets
  security_group_ids = [aws_security_group.traefik_sg.id]
}

# Nat gateway pour les machines du réseau interne (accès internet)

module "nat_gw" {
  source = "./modules/nat_gw"

  name                   = module.vpc.vpc_name # si utilisé
  public_subnet_id       = module.vpc.public_subnets[0]
  private_route_table_id = module.vpc.private_route_table_id
  internet_gateway_id    = module.vpc.internet_gateway_id
}

# K3S MASTER - SSH KEYS
resource "aws_key_pair" "k3s_key" {
  key_name   = "k3s"
  public_key = file("./ssh-key/k3s-sshkey.pub") 
}

# PENPOT K3S CLUSTER PART - PENPOT APPLICATION
# K3S SG
resource "aws_security_group" "k3s_master_sg" {
  name   = "k3s-master-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description     = "SSH from bastion"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "k3s etcd flow"
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  # Flannel VXLAN (UDP 8472)
  ingress {
    description = "Flannel VXLAN"
    from_port   = 8472
    to_port     = 8472
    protocol    = "udp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  # WireGuard port 51820
  ingress {
    description = "WireGuard port 51820"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  # WireGuard port 51821
  ingress {
    description = "WireGuard port 51821"
    from_port   = 51821
    to_port     = 51821
    protocol    = "udp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  # Bootstrap data etcd
  ingress {
    description = "bootstrap etcd 6443"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  # Traefik to k3s
  ingress {
    description = "http Traefik flow to k3s"
    from_port   = 30080
    to_port     = 30080
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24", "10.0.21.0/24", "10.0.22.0/24"]
  }

  egress {
    description = "Tout le trafic sortant"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "k3s_masters" {
  source            = "./modules/k3s-master"
  ami_id            = data.aws_ami.debian13.id
  ssh_key_name      = aws_key_pair.k3s_key.key_name
  private_subnets   = module.vpc.private_subnets
  security_group_id = aws_security_group.k3s_master_sg.id
  name_prefix       = "k3s-master"
  root_volume_size  = 30
  instance_type     = "m7i-flex.large"
}

# ---------- #
# MONITORING #
# ---------- #

# MONITORING - SSH KEYS
resource "aws_key_pair" "prometheus_key" {
  key_name   = "prometheus"
  public_key = file("./ssh-key/prometheus-sshkey.pub") 
}

# PROMETHEUS SG
resource "aws_security_group" "prometheus_sg" {
  name   = "penpot-prometheus-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    description = "SSH from bastion"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = [aws_security_group.bastion_sg.id]
  }

  ingress {
    description = "http Traefik flow to grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["10.0.1.0/24", "10.0.2.0/24"]
  }

  ingress {
    description = "Prometheus flow"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["10.0.11.0/24", "10.0.12.0/24", "10.0.1.0/24", "10.0.2.0/24"]
  }

  egress {
    description = "Allow all output"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

module "prometheus" {
  source            = "./modules/prometheus"
  ami_id            = data.aws_ami.debian13.id
  ssh_key_name      = aws_key_pair.prometheus_key.key_name
  private_subnets   = module.vpc.private_subnets
  security_group_id = aws_security_group.prometheus_sg.id
}


# ----------- #
# STAGING ENV #
# ----------- #

module "k3s_masters_stg" {
  source            = "./modules/k3s-master-stg"
  ami_id            = data.aws_ami.debian13.id
  ssh_key_name      = aws_key_pair.k3s_key.key_name
  private_stg_subnets   = module.vpc.private_stg_subnets
  security_group_id = aws_security_group.k3s_master_sg.id
  name_prefix       = "k3s-stg-master"
  root_volume_size  = 30
  instance_type     = "m7i-flex.large"
}

module "k3s_workers_stg" {
  source            = "./modules/k3s-worker-stg"
  ami_id            = data.aws_ami.debian13.id
  ssh_key_name      = aws_key_pair.k3s_key.key_name
  private_stg_subnets   = module.vpc.private_stg_subnets
  security_group_id = aws_security_group.k3s_master_sg.id
  name_prefix       = "k3s-stg-worker"
  root_volume_size  = 30
  instance_type     = "m7i-flex.large"
}

