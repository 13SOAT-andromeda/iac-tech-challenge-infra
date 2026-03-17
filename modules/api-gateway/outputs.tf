output "api_gateway_id" {
  description = "ID of the API Gateway HTTP API"
  value       = module.api_gateway.apigatewayv2_api_id
}

output "api_gateway_arn" {
  description = "ARN of the API Gateway HTTP API"
  value       = module.api_gateway.apigatewayv2_api_arn
}

output "api_gateway_endpoint" {
  description = "URI of the API (execute-api endpoint)"
  value       = module.api_gateway.apigatewayv2_api_api_endpoint
}

output "stage_invoke_url" {
  description = "URL to invoke the API pointing to the stage"
  value       = module.api_gateway.default_apigatewayv2_stage_invoke_url
}