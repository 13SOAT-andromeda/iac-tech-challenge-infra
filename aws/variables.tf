variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = "LabEksClusterRole"
}

variable "role_name" {
  description = "IAM role name for the EKS cluster"
  type        = string
  default     = "LabRole"
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tech-challenge-repo"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for state and artifacts"
  type        = string
  default     = "tech-challenge-bucket-andromeda-aws"
}

variable "lb_listener_arn" {
  description = "The ARN of the ALB Listener created in EKS"
  type        = string
  default     = "arn:aws:elasticloadbalancing:us-east-1:186319076937:listener/app/placeholder/12345/67890"
}

variable "auth_lambda_arn" {
  description = "The ARN of the Auth Lambda function"
  type        = string
  default     = "arn:aws:lambda:us-east-1:186319076937:function:tech-challenge-user-authentication"
}

variable "authorizer_lambda_arn" {
  description = "The ARN of the Authorizer Lambda function"
  type        = string
  default     = "arn:aws:lambda:us-east-1:186319076937:function:tech-challenge-user-authentication"
}
