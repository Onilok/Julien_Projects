# ----------------------------------------- #
# IAM User pour Penpot
# ----------------------------------------- #
resource "aws_iam_user" "penpot_user" {
  name = var.user_name
}

# ----------------------------------------- #
# Access Key pour Penpot
# ----------------------------------------- #
resource "aws_iam_access_key" "penpot_access" {
  user = aws_iam_user.penpot_user.name
}

# ----------------------------------------- #
# Politique limitée au bucket S3 existant
# ----------------------------------------- #
resource "aws_iam_policy" "penpot_s3_app_policy" {
  name        = "${var.user_name}-s3-asset-policy"
  description = "Accès S3 pour Penpot"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = [
          "s3:ListBucket"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}"
      },
      {
        Effect   = "Allow",
        Action   = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject"
        ],
        Resource = "arn:aws:s3:::${var.bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_user_policy_attachment" "penpot_attach" {
  user       = aws_iam_user.penpot_user.name
  policy_arn = aws_iam_policy.penpot_s3_app_policy.arn
}

