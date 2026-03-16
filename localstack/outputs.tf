output "repository_url" {
  description = "The URL of the ECR repository"
  value       = module.ecr.repository_url
}

output "ecr_user_validation_url" {
  description = "The URL of the ECR repository for user validation"
  value       = module.ecr_user_validation.repository_url
}

output "ecr_user_authentication_url" {
  description = "The URL of the ECR repository for user authentication"
  value       = module.ecr_user_authentication.repository_url
}

output "ecr_notification_service_url" {
  description = "The URL of the ECR repository for notification service"
  value       = module.ecr_notification_service.repository_url
}

output "lambda_user_validation_arn" {
  description = "The ARN of the user validation lambda"
  value       = module.lambda_user_validation.function_arn
}

output "lambda_user_authentication_arn" {
  description = "The ARN of the user authentication lambda"
  value       = module.lambda_user_authentication.function_arn
}

output "lambda_notification_service_arn" {
  description = "The ARN of the notification service lambda"
  value       = module.lambda_notification_service.function_arn
}

output "state_bucket_arn" {
  description = "The ARN of the S3 bucket for state and artifacts"
  value       = module.s3.bucket_arn
}
