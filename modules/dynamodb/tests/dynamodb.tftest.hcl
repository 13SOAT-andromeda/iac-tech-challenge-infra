# Test configuration for DynamoDB module
variables {
  table_name   = "user-authentication-token"
  hash_key     = "token_id"
  billing_mode = "PAY_PER_REQUEST"
}

provider "aws" {
  region                      = "us-east-1"
  access_key                  = "test"
  secret_key                  = "test"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    dynamodb = "http://localhost:4566"
  }
}

run "valid_dynamodb_config" {
  command = plan

  assert {
    condition     = aws_dynamodb_table.this.name == "user-authentication-token"
    error_message = "DynamoDB table name does not match expected value"
  }

  assert {
    condition     = aws_dynamodb_table.this.hash_key == "token_id"
    error_message = "DynamoDB hash key does not match expected value"
  }

  assert {
    condition     = aws_dynamodb_table.this.billing_mode == "PAY_PER_REQUEST"
    error_message = "DynamoDB billing mode should be 'PAY_PER_REQUEST'"
  }

  assert {
    condition     = aws_dynamodb_table.this.ttl[0].enabled == true
    error_message = "DynamoDB TTL should be enabled"
  }

  assert {
    condition     = aws_dynamodb_table.this.ttl[0].attribute_name == "expiration"
    error_message = "DynamoDB TTL attribute name should be 'expiration'"
  }

  assert {
    condition     = length(aws_dynamodb_table.this.global_secondary_index) == 1
    error_message = "DynamoDB should have exactly one GSI"
  }

  assert {
    condition     = anytrue([for gsi in aws_dynamodb_table.this.global_secondary_index : gsi.name == "UserIdIndex"])
    error_message = "GSI 'UserIdIndex' should exist"
  }

  assert {
    condition     = anytrue([for gsi in aws_dynamodb_table.this.global_secondary_index : gsi.hash_key == "user_id" if gsi.name == "UserIdIndex"])
    error_message = "GSI 'UserIdIndex' should have 'user_id' as hash key"
  }
}
