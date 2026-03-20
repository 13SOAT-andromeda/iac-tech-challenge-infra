output "repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_user_authentication_url" {
  description = "The URL of the ECR user-authentication repository"
  value       = module.ecr_user_authentication.repository_url
}

output "ecr_user_authorizer_url" {
  description = "The URL of the ECR user-authorizer repository"
  value       = module.ecr_user_authorizer.repository_url
}

output "ecr_notification_service_url" {
  description = "The URL of the ECR notification-service repository"
  value       = module.ecr_notification_service.repository_url
}

output "state_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = module.s3.bucket_arn
}

output "api_endpoint" {
  description = "The HTTP API Gateway endpoint"
  value       = module.api_gateway.api_endpoint
}

output "api_vpc_link_id" {
  description = "The ID of the API Gateway VPC Link"
  value       = module.api_gateway.vpc_link_id
}
