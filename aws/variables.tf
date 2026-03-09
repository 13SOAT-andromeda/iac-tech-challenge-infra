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

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tech-challenge-repo"
}
