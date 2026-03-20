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
