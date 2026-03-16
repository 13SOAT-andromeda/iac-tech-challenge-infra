# DynamoDB Module

This module provisions a DynamoDB table with Time to Live (TTL) and Pay-per-Request billing mode. It is designed to be simple and consistent across both standard AWS and LocalStack environments.

## Features
- **Pay-per-Request Billing:** Cost-effective for unpredictable workloads.
- **TTL Support:** Automatically expire items based on a timestamp attribute.
- **Environment Parity:** Tested and verified on both AWS and LocalStack.

## Usage

```hcl
module "dynamodb" {
  source     = "../modules/dynamodb"
  table_name = "user-authentication-token"
  hash_key   = "token_id"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| table_name | The name of the DynamoDB table | `string` | n/a | yes |
| hash_key | The attribute to use as the hash (partition) key | `string` | n/a | yes |
| billing_mode | Controls how you are charged for read and write throughput | `string` | `"PAY_PER_REQUEST"` | no |
| ttl_attribute | The name of the table attribute to store the TTL timestamp in | `string` | `"expiration"` | no |
| ttl_enabled | Indicates whether TTL is enabled | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| table_arn | The ARN of the DynamoDB table |
| table_name | The name of the DynamoDB table |
