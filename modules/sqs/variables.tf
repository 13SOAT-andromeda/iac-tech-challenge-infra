variable "queue_name" {
  description = "Name of the SQS queue"
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "message_retention_seconds" {
  description = "The number of seconds Amazon SQS retains a message. Integer representing seconds, from 60 (1 minute) to 1209600 (14 days)."
  type        = number
  default     = 345600
}

variable "visibility_timeout_seconds" {
  description = "The visibility timeout for the queue. An integer from 0 to 43200 (12 hours)."
  type        = number
  default     = 30
}

variable "max_receive_count" {
  description = "The maximum number of times a message can be received before being sent to the DLQ."
  type        = number
  default     = 5
}
