output "nlb_arn" {
  value = aws_lb.this.arn
}

output "nlb_dns_name" {
  value = aws_lb.this.dns_name
}

#output "target_group_arn" {
#  value = aws_lb_target_group.this.arn
#}

output "dns_name" {
  description = "Le nom DNS du NLB"
  value       = aws_lb.this.dns_name
}

output "http_target_group_arn" {
  value = aws_lb_target_group.traefik_http.arn
}

output "https_target_group_arn" {
  value = aws_lb_target_group.traefik_https.arn
}

variable "traefik_instance_ids" {
  type = list(string)
}
