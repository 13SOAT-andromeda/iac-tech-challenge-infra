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
      aws_api_gateway_vpc_link.this.id,
      aws_api_gateway_resource.api.id,
      aws_api_gateway_resource.api_proxy.id,
      aws_api_gateway_method.api_proxy_any.id,
      aws_api_gateway_integration.api_proxy_lb.id,
      aws_api_gateway_authorizer.this.id,
      aws_api_gateway_gateway_response.unauthorized.id,
      aws_api_gateway_gateway_response.forbidden.id,
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  # Ensure deployment happens after all resources are created
  depends_on = [
    aws_api_gateway_integration.login_lambda,
    aws_api_gateway_integration.api_proxy_lb,
    aws_api_gateway_gateway_response.unauthorized,
    aws_api_gateway_gateway_response.forbidden,
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

# --- Private Route: /api/* (Proxy to EKS LB via VPC Link) ---

resource "aws_api_gateway_vpc_link" "this" {
  name        = "tech-challenge-api-vpc-link"
  description = "VPC Link for tech-challenge API Gateway"
  target_arns = [var.lb_dns_name]
}

resource "aws_api_gateway_resource" "api" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "api"
}

resource "aws_api_gateway_resource" "api_proxy" {
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.api.id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "api_proxy_any" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.api_proxy.id
  http_method   = "ANY"
  authorization = "CUSTOM"
  authorizer_id = aws_api_gateway_authorizer.this.id

  request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "api_proxy_lb" {
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.api_proxy.id
  http_method             = aws_api_gateway_method.api_proxy_any.http_method
  integration_http_method = "ANY"
  type                    = "HTTP_PROXY"
  uri                     = "http://${var.lb_dns_name}/{proxy}"
  connection_type         = "VPC_LINK"
  connection_id           = aws_api_gateway_vpc_link.this.id

  cache_key_parameters = ["method.request.path.proxy"]

  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

# --- Authorization: Token Authorizer ---

resource "aws_api_gateway_authorizer" "this" {
  name                   = "tech-challenge-authorizer"
  rest_api_id            = aws_api_gateway_rest_api.this.id
  authorizer_uri         = "arn:aws:apigateway:us-east-1:lambda:path/2015-03-31/functions/${var.authorizer_lambda_arn}/invocations"
  authorizer_credentials = var.lab_role_arn
  type                   = "TOKEN"
  identity_source        = "method.request.header.X-AUTH-TOKEN"
}

# --- Gateway Responses: 401 & 403 ---

resource "aws_api_gateway_gateway_response" "unauthorized" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  response_type = "UNAUTHORIZED"
  status_code   = "401"

  response_templates = {
    "application/json" = "{\"message\":\"$context.error.messageString\"}"
  }
}

resource "aws_api_gateway_gateway_response" "forbidden" {
  rest_api_id   = aws_api_gateway_rest_api.this.id
  response_type = "ACCESS_DENIED"
  status_code   = "403"

  response_templates = {
    "application/json" = "{\"message\":\"$context.error.messageString\"}"
  }
}
