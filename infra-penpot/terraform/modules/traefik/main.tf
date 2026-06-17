# modules/traefik/main.tf
resource "aws_instance" "this" {
  count         = length(var.public_subnets)
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.public_subnets[count.index]
  key_name      = var.ssh_key_name
  vpc_security_group_ids = var.security_group_ids
  associate_public_ip_address = true

  tags = {
    Name = "${var.name_prefix}-az${count.index + 1}"
  }
}

