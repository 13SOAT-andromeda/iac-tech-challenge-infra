variable "table_name" {
  description = "The name of the DynamoDB table"
  type        = string
}

variable "billing_mode" {
  description = "Controls how you are charged for read and write throughput"
  type        = string
  default     = "PAY_PER_REQUEST"
}

variable "hash_key" {
  description = "The attribute to use as the hash (partition) key"
  type        = string
}

variable "ttl_attribute" {
  description = "The name of the table attribute to store the TTL timestamp in"
  type        = string
  default     = "expiration"
}

variable "ttl_enabled" {
  description = "Indicates whether TTL is enabled"
  type        = bool
  default     = true
}
