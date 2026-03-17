variable "name" {
  description = "Name of the API Gateway resource"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway resource"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to API Gateway resources"
  type        = map(string)
  default     = {}
}