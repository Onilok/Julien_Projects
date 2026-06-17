output "nat_gateway_id" {
  value       = aws_nat_gateway.this.id
  description = "ID de la NAT Gateway"
}

output "nat_eip" {
  value       = aws_eip.this.public_ip
  description = "EIP associée à la NAT Gateway"
}

