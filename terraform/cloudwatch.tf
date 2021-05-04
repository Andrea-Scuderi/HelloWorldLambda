# This is to optionally manage the CloudWatch Log Group for the Lambda Function.
# If skipping this resource configuration, also add "logs:CreateLogGroup" to the IAM policy below.
resource "aws_cloudwatch_log_group" "lambda_log_cloudwatch_map" {
  for_each = local.lambda_settings

  name              = "/aws/lambda/${var.environment}-${var.project}-${each.key}"
  retention_in_days = 14
}
