output "api_endpoint" {
  description = "URL base do API Gateway no LocalStack"
  value       = module.api_gateway.api_gateway_endpoint
}

output "api_id" {
  description = "ID do API Gateway"
  value       = module.api_gateway.api_gateway_id
}

output "stage_invoke_url" {
  description = "URL para invocar a API (com stage)"
  value       = module.api_gateway.stage_invoke_url
}
