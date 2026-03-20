variable "repository_name" {
  description = "ECR repository name"
  type        = string
  default     = "tech-challenge-repo"
}

variable "bucket_name" {
  description = "The name of the S3 bucket for state and artifacts"
  type        = string
  default     = "tech-challenge-bucket-andromeda-local"
}
