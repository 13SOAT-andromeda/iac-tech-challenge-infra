variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster in LocalStack"
  type        = string
  default     = "arn:aws:iam::000000000000:role/eks-local-role"
}

variable "node_role_arn" {
  description = "IAM role ARN for the EKS nodes in LocalStack"
  type        = string
  default     = "arn:aws:iam::000000000000:role/eks-local-node-role"
}

variable "access_role_arn" {
  description = "IAM role ARN to grant cluster access in LocalStack"
  type        = string
  default     = "arn:aws:iam::000000000000:role/eks-local-access-role"
}
