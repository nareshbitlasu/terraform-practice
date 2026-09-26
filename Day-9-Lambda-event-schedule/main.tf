provider "aws" {
  region = "us-east-1"
}
resource aws_lambda_function "example" {
  function_name = "example_lambda"
  handler       = "index.handler"
  runtime       = "python3.9"
  role          = aws_iam_role.lambda_exec.arn
  filename      = "lambda_function_payload.zip"
  timeout       = 900
  memory_size   = 128
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
}

resource "aws_iam_role" "lambda_exec" {
    name = "lambda_exec_role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = {
            Service = "lambda.amazonaws.com"
            }
        },
        ]
    })
}