# modules/prometheus/main.tf
resource "aws_instance" "this" {
  count         = length(var.private_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.private_subnets[count.index]
  key_name      = var.ssh_key_name
  vpc_security_group_ids = [var.security_group_id]
  # No public IP
  associate_public_ip_address = false

  root_block_device {
  volume_size = var.root_volume_size
  volume_type = "gp3"
  }

  tags = {
    Name = "${var.name_prefix}-az${count.index + 1}"
  }
}

