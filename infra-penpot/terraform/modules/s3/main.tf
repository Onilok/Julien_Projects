# ----------------------------------------- #
# Random suffix (S3 must be globally unique)
# ----------------------------------------- #
resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
}

# ----------------------------------------- #
# S3 Bucket
# ----------------------------------------- #
resource "aws_s3_bucket" "this" {
  #bucket        = "${var.bucket_name}-${random_string.suffix.result}"
  bucket        = "${var.bucket_name}"
  force_destroy = var.force_destroy

  tags = merge(
    {
      Name = var.bucket_name
    },
    var.tags
  )
}

# ----------------------------------------- #
# Versioning
# ----------------------------------------- #
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = var.versioning ? "Enabled" : "Suspended"
  }
}

# ----------------------------------------- #
# Encryption AES256
# ----------------------------------------- #
resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# ----------------------------------------- #
# Block public access
# ----------------------------------------- #
resource "aws_s3_bucket_public_access_block" "public_block" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# ----------------------------------------- #
# Lifecycle management (optional)
# ----------------------------------------- #
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  count  = var.enable_lifecycle ? 1 : 0
  bucket = aws_s3_bucket.this.id

  rule {
    id     = "transition-and-expire"
    status = "Enabled"

    transition {
      days          = var.transition_to_ia_days
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = var.transition_to_glacier_days
      storage_class = "GLACIER"
    }

    expiration {
      days = var.expiration_days
    }
  }
}

# ------------------ #
# Folder creation S3 
# ------------------ #

resource "aws_s3_object" "folders" {
  for_each = toset(var.folders)
  bucket   = aws_s3_bucket.this.id    # maintenant on utilise `id` au lieu de `bucket`
  key      = "${each.value}/"         # le “/” fait de l’objet un pseudo-dossier
  acl      = "private"
  content  = ""                        # un objet vide
}


