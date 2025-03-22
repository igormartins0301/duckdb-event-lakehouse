resource "aws_s3_bucket" "raw_data" {
  bucket = "${var.company_name}-raw-${var.aws_region}-${data.aws_caller_identity.current.account_id}"
  
  tags = {
    Environment = "production"
    DataLayer   = "raw"
  }
}

resource "aws_s3_bucket_versioning" "raw_versioning" {
  bucket = aws_s3_bucket.raw_data.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "raw_encryption" {
  bucket = aws_s3_bucket.raw_data.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "raw_block" {
  bucket                  = aws_s3_bucket.raw_data.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_policy" "raw_policy" {
  bucket = aws_s3_bucket.raw_data.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowSecureUserUploads"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          aws_s3_bucket.raw_data.arn,
          "${aws_s3_bucket.raw_data.arn}/*"
        ]
      }
    ]
  })
}

resource "aws_s3_bucket_logging" "raw_logs" {
  bucket        = aws_s3_bucket.raw_data.id
  target_bucket = aws_s3_bucket.raw_data.id
  target_prefix = "logs/"
}
