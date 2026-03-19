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
      # Add more resources here as they are created to trigger redeployment
    ]))
  }

  lifecycle {
    create_before_destroy = true
  }

  # Ensure deployment happens after all resources are created
  depends_on = [
    aws_api_gateway_rest_api.this,
  ]
}

resource "aws_api_gateway_stage" "this" {
  deployment_id = aws_api_gateway_deployment.this.id
  rest_api_id   = aws_api_gateway_rest_api.this.id
  stage_name    = var.environment
}

