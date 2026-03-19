output "api_gateway_url" {
  description = "The URL of the API Gateway"
  value       = aws_api_gateway_stage.this.invoke_url
}

output "api_gateway_id" {
  description = "The ID of the API Gateway"
  value       = aws_api_gateway_rest_api.this.id
}
