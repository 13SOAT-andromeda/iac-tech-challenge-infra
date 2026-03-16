# Track Specification: User Authentication Token Storage (DynamoDB)

## Overview
Implement a DynamoDB table for tracking JWT user authentication tokens (valid/invalid), supporting both standard AWS (student account) and LocalStack for local development.

## Functional Requirements
- **Table Name:** `user-authentication-token`.
- **Primary Key:** `token_id` (Partition Key, String) - this will store the unique `jti` (JWT ID).
- **Attributes:**
  - `user_id` (String)
  - `expiration` (Number) - Unix timestamp when the token naturally expires.
- **Time to Live (TTL):** Enabled on the `expiration` attribute to automatically remove expired tokens.
- **Billing Mode:** `PAY_PER_REQUEST`.

## Non-Functional Requirements
- **Environment Parity:** The Terraform configuration must work seamlessly in both AWS and LocalStack.
- **IAM Compliance:** Ensure compatibility with the `LabRole` provided in AWS Academy (student role).
- **Simplicity:** Minimize configuration complexity.

## Acceptance Criteria
- **Infrastructure Creation:** Terraform correctly provisions the table with the specified schema and settings.
- **LocalStack Validation:** Table is successfully created and verified in LocalStack using MCP tools.
- **AWS Validation:** Table is successfully created and verified in AWS using `terraform apply`.
- **TDD:** Terraform unit tests pass for the new DynamoDB module.

## Out of Scope
- Integration with API Gateway (handled separately).
- Storing the raw JWT string in this table.
