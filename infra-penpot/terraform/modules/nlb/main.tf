########################################
# Security Group pour les instances backend
########################################
resource "aws_security_group" "nlb_sg" {
  name        = "${var.nlb_name}-sg"
  description = "Security group for NLB backend instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.nlb_name}-sg"
  }
}

########################################
# NLB
########################################
resource "aws_lb" "this" {
  name               = var.nlb_name
  internal           = false
  load_balancer_type = "network"

  subnets = var.subnets

  enable_deletion_protection = false
  idle_timeout               = 60

  tags = {
    Name = var.nlb_name
  }
}

########################################
# Target Group TCP vers instances backend traefik
########################################

resource "aws_lb_target_group" "traefik_http" {
  name        = "${var.nlb_name}-traefik-http"
  port        = 80
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol = "TCP"
    port     = "80"
  }
}

resource "aws_lb_target_group" "traefik_https" {
  name        = "${var.nlb_name}-traefik-https"
  port        = 443
  protocol    = "TCP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    protocol = "TCP"
    port     = "443"
  }
}

########################################
# Listener TCP sur le NLB
########################################
#resource "aws_lb_listener" "tcp" {
#  load_balancer_arn = aws_lb.this.arn
#  port              = 443
#  protocol          = "TCP"

#  default_action {
#    type             = "forward"
#    target_group_arn = aws_lb_target_group.this.arn
#  }
#}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.traefik_http.arn
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.this.arn
  port              = 443
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.traefik_https.arn
  }
}

# Attachment traefik node to nlb

resource "aws_lb_target_group_attachment" "http" {
  count = length(var.traefik_instance_ids)

  target_group_arn = aws_lb_target_group.traefik_http.arn
  target_id        = var.traefik_instance_ids[count.index]
  port             = 80
}

resource "aws_lb_target_group_attachment" "https" {
  count = length(var.traefik_instance_ids)

  target_group_arn = aws_lb_target_group.traefik_https.arn
  target_id        = var.traefik_instance_ids[count.index]
  port             = 443
}
