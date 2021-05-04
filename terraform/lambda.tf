# Add Lambda
resource "aws_lambda_function" "lambda_function_map" {
  for_each      = local.lambda_settings
    
  function_name = "${var.environment}-${var.project}-${each.key}"
  s3_bucket = "${var.s3bucket}"
  s3_key  = "v${var.app_version}/${each.value.s3key}"

  role          = aws_iam_role.terraform_iam_for_lambda_role.arn
  handler       = each.value.handler
  memory_size   = 128
  timeout       = 6

  runtime = "provided"

  source_code_hash = "${base64sha256("${var.swift_build_path}${each.value.s3key}")}"

  depends_on = [
    aws_iam_role.terraform_iam_for_lambda_role,
    aws_iam_role_policy_attachment.terraform_cloudwatch_lambda_policy_attachment,
    aws_cloudwatch_log_group.lambda_log_cloudwatch_map,
    aws_s3_bucket.terraform_deployment_bucket,
    aws_s3_bucket_object.code_lambda_zip_lambda_register
  ]
}
