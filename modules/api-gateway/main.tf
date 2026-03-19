resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = "API Gateway for tech-challenge services"

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_deployment" "this" {
  rest_api_id = aws_api_gateway_rest_api.this.id

  # Force deployment on any change to the REST API
  triggers = {
    redeployment = sha1(jsonencode([
      aws_api_gateway_rest_api.this.id,
      aws_api_gateway_resource.login.id,
      aws_api_gateway_method.login_post.id,
      aws_api_gateway_integration.login_lambda.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  # Ensure deployment happens after all resources are created
  depends_on = [
    aws_api_gateway_integration.login_lambda,
  ]
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.environment
}

# --- Public Route: /login ---

resource "aws_api_gateway_resource" "login" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "login"
}

resource "aws_api_gateway_method" "login_post" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.login.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "login_lambda" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.login.id
  http_method             = aws_api_gateway_method.login_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.auth_lambda_arn}/invocations"
}

