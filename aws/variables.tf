variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
  default     = "arn:aws:iam::186319076937:role/c194537a4993920l13448970t1w186319-LabEksClusterRole-7d9nqwvglvqv"
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS nodes"
  type        = string
  default     = "arn:aws:iam::186319076937:role/c194537a4993920l13448970t1w186319076-LabEksNodeRole-b8jvkyLQqLct"
}

variable "access_role_arn" {
  description = "IAM role ARN to grant cluster access"
  type        = string
  default     = "arn:aws:iam::186319076937:role/LabRole"
}
