provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  s3_use_path_style           = true

  endpoints {
    apigateway = "http://localhost:4566"
    sts        = "http://localhost:4566"
  }
}

variables {
  name                  = "tftest-api-gateway"
  vpc_id                = "vpc-12345678"
  subnet_ids            = ["subnet-12345", "subnet-67890"]
  lb_dns_name           = "test-lb.example.com"
  lab_role_arn          = "arn:aws:iam::123456789012:role/LabRole"
  auth_lambda_arn       = "arn:aws:lambda:us-east-1:123456789012:function:auth"
  authorizer_lambda_arn = "arn:aws:lambda:us-east-1:123456789012:function:authorizer"
  environment           = "test"
}

run "verify_api_gateway_basic_setup" {
  command = plan

  assert {
    condition     = aws_api_gateway_rest_api.this.name == "tftest-api-gateway"
    error_message = "API Gateway name did not match expected value"
  }

  assert {
    condition     = aws_api_gateway_rest_api.this.endpoint_configuration[0].types[0] == "REGIONAL"
    error_message = "API Gateway endpoint type is not REGIONAL"
  }

  assert {
    condition     = aws_api_gateway_stage.this.stage_name == "test"
    error_message = "API Gateway stage name did not match expected environment"
  }
}

run "verify_login_route_exists" {
  command = plan

  assert {
    condition     = aws_api_gateway_resource.login.path_part == "login"
    error_message = "/login resource path did not match"
  }

  assert {
    condition     = aws_api_gateway_method.login_post.http_method == "POST"
    error_message = "/login method is not POST"
  }

  assert {
    condition     = aws_api_gateway_integration.login_lambda.type == "AWS_PROXY"
    error_message = "/login integration is not AWS_PROXY"
  }
}

run "verify_api_proxy_route_exists" {
  command = plan

  assert {
    condition     = aws_api_gateway_vpc_link.this.name == "tech-challenge-api-vpc-link"
    error_message = "VPC Link name did not match"
  }

  assert {
    condition     = aws_api_gateway_resource.api.path_part == "api"
    error_message = "/api resource path did not match"
  }

  assert {
    condition     = aws_api_gateway_resource.api_proxy.path_part == "{proxy+}"
    error_message = "/api/{proxy+} resource path did not match"
  }

  assert {
    condition     = aws_api_gateway_method.api_proxy_any.http_method == "ANY"
    error_message = "/api/{proxy+} method is not ANY"
  }

  assert {
    condition     = aws_api_gateway_integration.api_proxy_lb.type == "HTTP_PROXY"
    error_message = "/api/{proxy+} integration is not HTTP_PROXY"
  }

  assert {
    condition     = aws_api_gateway_integration.api_proxy_lb.connection_type == "VPC_LINK"
    error_message = "/api/{proxy+} connection type is not VPC_LINK"
  }
}

run "verify_authorizer_config" {
  command = plan

  assert {
    condition     = aws_api_gateway_authorizer.this.name == "tech-challenge-authorizer"
    error_message = "Authorizer name did not match"
  }

  assert {
    condition     = aws_api_gateway_authorizer.this.type == "TOKEN"
    error_message = "Authorizer type is not TOKEN"
  }

  assert {
    condition     = aws_api_gateway_authorizer.this.identity_source == "method.request.header.X-AUTH-TOKEN"
    error_message = "Authorizer identity source did not match expected header"
  }

  assert {
    condition     = aws_api_gateway_method.api_proxy_any.authorization == "CUSTOM"
    error_message = "/api/{proxy+} method does not use CUSTOM authorization"
  }
}
