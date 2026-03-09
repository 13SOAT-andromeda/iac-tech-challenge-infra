variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster in LocalStack"
  type        = string
  default     = "arn:aws:iam::000000000000:role/eks-local-role"
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
  default     = "postgreslocal"
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tech-challenge-repo"
}
