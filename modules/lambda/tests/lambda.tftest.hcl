# Test configuration for Lambda module
variables {
  function_name = "test-lambda"
  image_uri     = "123456789012.dkr.ecr.us-east-1.amazonaws.com/test-repo:latest"
  role_arn      = "arn:aws:iam::123456789012:role/LabRole"
  reserved_concurrent_executions = 5
  environment_variables = {
    TEST_VAR = "test-value"
  }
}

run "valid_lambda_config" {
  command = plan

  assert {
    condition     = aws_lambda_function.this.function_name == "test-lambda"
    error_message = "Lambda function name does not match expected value"
  }

  assert {
    condition     = aws_lambda_function.this.package_type == "Image"
    error_message = "Lambda package type should be 'Image'"
  }

  assert {
    condition     = aws_lambda_function.this.role == "arn:aws:iam::123456789012:role/LabRole"
    error_message = "Lambda role ARN does not match expected value"
  }

  assert {
    condition     = aws_lambda_function.this.reserved_concurrent_executions == 5
    error_message = "Lambda concurrency limit does not match expected value"
  }
}
