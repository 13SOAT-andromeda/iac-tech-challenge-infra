variable "function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "image_uri" {
  description = "The URI of the container image in ECR (required if package_type is Image)"
  type        = string
  default     = null
}

variable "package_type" {
  description = "The package type for the Lambda function (Image or Zip)"
  type        = string
  default     = "Image"
}

variable "filename" {
  description = "The path to the function's deployment package within the local filesystem (required if package_type is Zip)"
  type        = string
  default     = null
}

variable "role_arn" {
  description = "The ARN of the IAM role for the Lambda function"
  type        = string
}

variable "timeout" {
  description = "The amount of time your Lambda Function has to run in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Amount of memory in MB your Lambda Function can use at runtime"
  type        = number
  default     = 128
}

variable "reserved_concurrent_executions" {
  description = "Amount of reserved concurrent executions for this lambda function"
  type        = number
  default     = -1
}

variable "environment_variables" {
  description = "A map that defines environment variables for the Lambda function"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}
