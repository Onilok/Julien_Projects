output "penpot_aws_access_key_id" {
  value     = aws_iam_access_key.penpot_access.id
  sensitive = true
}

output "penpot_aws_secret_access_key" {
  value     = aws_iam_access_key.penpot_access.secret
  sensitive = true
}

output "penpot_user_name" {
  value = aws_iam_user.penpot_user.name
}

