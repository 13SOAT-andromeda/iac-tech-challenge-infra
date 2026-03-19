variable "name" {
  description = "Name for the API Gateway"
  type        = string
  default     = "tech-challenge-api"
}

variable "vpc_id" {
  description = "VPC ID where the Load Balancer is located"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the VPC Link"
  type        = list(string)
}

variable "lb_dns_name" {
  description = "DNS name of the EKS Load Balancer"
  type        = string
}

variable "lab_role_arn" {
  description = "ARN of the IAM LabRole"
  type        = string
}

variable "auth_lambda_arn" {
  description = "ARN of the authentication Lambda function"
  type        = string
}

variable "authorizer_lambda_arn" {
  description = "ARN of the authorizer Lambda function"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, dev, localstack)"
  type        = string
  default     = "dev"
}
