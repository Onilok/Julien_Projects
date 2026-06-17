locals {
  master_count = 2
}

resource "aws_instance" "master" {
  count         = local.master_count
  ami           = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.ssh_key_name
  subnet_id     = var.private_stg_subnets[count.index % length(var.private_stg_subnets)]

  # Pas d'IP publique
  associate_public_ip_address = false

  root_block_device {
  volume_size = var.root_volume_size
  volume_type = "gp3"
  }

    tags = {
    Name = "${var.name_prefix}-${count.index + 1}"
    Role = "k3s-master"
  }
}

