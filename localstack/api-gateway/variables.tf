variable "api_name" {
  description = "Nome do API Gateway"
  type        = string
  default     = "tech-challenge-api-local"
}

variable "api_description" {
  description = "Descrição do API Gateway"
  type        = string
  default     = "Tech Challenge API (LocalStack)"
}

variable "tags" {
  description = "Tags adicionais"
  type        = map(string)
  default     = {}
}
