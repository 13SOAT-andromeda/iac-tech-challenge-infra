resource "aws_sqs_queue" "dlq" {
  name = "${var.queue_name}-dlq"
  tags = var.tags
}

resource "aws_sqs_queue" "this" {
  name                      = var.queue_name
  message_retention_seconds = var.message_retention_seconds
  visibility_timeout_seconds = var.visibility_timeout_seconds
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.dlq.arn
    maxReceiveCount     = var.max_receive_count
  })

  tags = var.tags
}
