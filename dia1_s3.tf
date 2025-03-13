resource "aws_s3_bucket" "bucket_dia1_uploads" {
  bucket = "bucket_dia1_uploads"
  force_destroy = true
}

resource "aws_s3_bucket_public_access_block" "bucket_dia1_uploads_blocks" {
  bucket = aws_s3_bucket.bucket_dia1_uploads.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_dia1_uploads_encryption" {
  bucket = aws_s3_bucket.bucket_dia1_uploads.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "bucket_dia1_uploads_versioning" {
  bucket = aws_s3_bucket.bucket_dia1_uploads.id
  versioning_configuration {
    status = "Enabled"
  }
}