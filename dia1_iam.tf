resource "aws_iam_user" "s3_uploader" {
  name = "s3_uploader"
}

resource "aws_iam_policy" "s3_uploader_policy" {
  name        = "s3_uploader_policy"
  description = "Permite upload de arquivos a um bucket específico"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:PutObject",
          "s3:ListObject"
        ]
        Effect   = "Allow"
        Resource = ["arn:aws:s3:::meu-bucket", "arn:aws:s3:::bucket_dia1_uploads/*"]
      },
    ]
  })
}

resource "aws_iam_user_policy_attachment" "attach_s3_policy"{
    user       = aws_iam_user.s3_uploader
    policy_arn = aws_iam_policy.s3_uploader_policy
}

resource "aws_iam_access_key" "s3_uploader_key" {
  user = aws_iam_user.s3_uploader.name
}