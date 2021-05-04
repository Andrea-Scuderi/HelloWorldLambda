resource "aws_s3_bucket" "terraform_deployment_bucket" {
  bucket = "${var.s3bucket}"
  acl    = "private"

  tags = {
    Name        = "terraform_deployment_bucket"
    Environment = "${var.environment}"
  }
}

resource "aws_s3_bucket_policy" "terraform_deployment_bucket_policy" {
  bucket = aws_s3_bucket.terraform_deployment_bucket.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression's result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "terraform_deployment_bucket_policy"
    Statement = [
      {
        Sid       = "IPAllow"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.terraform_deployment_bucket.arn,
          "${aws_s3_bucket.terraform_deployment_bucket.arn}/*",
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = false
          }
        }
      },
    ]
  })

  depends_on = [
    aws_s3_bucket.terraform_deployment_bucket
  ]
}

# Add the Lambda Code to the S3 Bucket for deployment
resource "aws_s3_bucket_object" "code_lambda_zip_lambda_register" {
  for_each      = local.lambda_settings

  bucket = "${var.s3bucket}"
  key    = "v${var.app_version}/${each.value.s3key}"
  source = "${var.swift_build_path}${each.value.s3key}"
  etag   = filemd5("${var.swift_build_path}${each.value.s3key}")
  depends_on = [
    aws_s3_bucket.terraform_deployment_bucket,
    aws_s3_bucket_policy.terraform_deployment_bucket_policy
  ]
}