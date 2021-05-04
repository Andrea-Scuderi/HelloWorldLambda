resource "aws_iam_policy" "terraform_cloudwatch_lambda_logging_policy" {
  name        = "terraform_cloudwatch_lambda_logging_policy-${var.environment}-${var.project}"
  path        = "/"
  description = "IAM policy for logging from a lambda"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "arn:${data.aws_partition.current.partition}:logs:${var.region}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/*:*",
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "terraform_cloudwatch_lambda_policy_attachment" {
  role       = aws_iam_role.terraform_iam_for_lambda_role.name
  policy_arn = aws_iam_policy.terraform_cloudwatch_lambda_logging_policy.arn
}

resource "aws_iam_role" "terraform_iam_for_lambda_role" {
  name = "terraform_iam_for_lambda_role-${var.environment}-${var.project}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
