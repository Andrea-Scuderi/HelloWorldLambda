output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

data "aws_s3_bucket" "terraform_deployment_bucket" {
    bucket = "${var.s3bucket}"

    depends_on = [
      aws_s3_bucket.terraform_deployment_bucket
    ]
}

output "s3_deployment_bucket_domain_name" {
    description = "S3 Deployment bucket"
    value = data.aws_s3_bucket.terraform_deployment_bucket.bucket_domain_name
}