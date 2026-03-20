resource "aws_lambda_function" "this" {
  function_name = var.function_name
  package_type  = var.package_type
  image_uri     = var.package_type == "Image" ? var.image_uri : null
  filename      = var.package_type == "Zip" ? var.filename : null
  role          = var.role_arn

  handler = var.package_type == "Zip" ? "index.handler" : null
  runtime = var.package_type == "Zip" ? "nodejs18.x" : null

  timeout     = var.timeout
  memory_size = var.memory_size

  reserved_concurrent_executions = var.reserved_concurrent_executions

  dynamic "environment" {
    for_each = length(var.environment_variables) > 0 ? [1] : []
    content {
      variables = var.environment_variables
    }
  }

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "this" {
  name              = "/aws/lambda/${var.function_name}"
  retention_in_days = 14
  tags              = var.tags
}
