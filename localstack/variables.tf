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
