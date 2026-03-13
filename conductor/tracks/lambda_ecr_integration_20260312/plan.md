# Implementation Plan - Lambda Module with ECR Integration

## Phase 1: Create Reusable Lambda Module [checkpoint: 125f94f]
- [x] Task: Write Terraform tests (`tests/lambda.tftest.hcl`) defining expected variables and module structure. a17b7c1
- [x] Task: Implement `modules/lambda/variables.tf` (including `role_arn` and `reserved_concurrent_executions`) and `modules/lambda/outputs.tf`. 587e6b5
- [x] Task: Implement `modules/lambda/main.tf` for `aws_lambda_function` with `package_type = "Image"`, attaching the passed `LabRole` ARN and applying the concurrency limit. 587e6b5
- [x] Task: Run `terraform fmt` and `terraform validate` within the module directory to ensure correctness. 587e6b5
- [x] Task: Conductor - User Manual Verification 'Create Reusable Lambda Module' (Protocol in workflow.md) 125f94f

## Phase 2: Provision ECR Repositories [checkpoint: e90624d]
- [x] Task: Update `aws/main.tf` to call the `ecr` module three times (for `tech-challenge-user-validation-repo`, `tech-challenge-user-authentication-repo`, and `tech-challenge-notification-service-repo`). 125f94f
- [x] Task: Update `aws/outputs.tf` to output the URLs of the newly created repositories. 125f94f
- [x] Task: Conductor - User Manual Verification 'Provision ECR Repositories' (Protocol in workflow.md) e90624d

## Phase 3: Deploy Lambda Functions
- [x] Task: Update `aws/main.tf` to call the new `lambda` module three times to provision `tech-challenge-user-validation`, `tech-challenge-user-authentication`, and `tech-challenge-notification-service`. e90624d
- [x] Task: Pass the existing `LabRole` ARN to each Lambda module instance. e90624d
- [x] Task: Configure `reserved_concurrent_executions` (e.g., 3 per function) to ensure the total limit of 10 concurrent executions is never breached. e90624d
- [x] Task: Configure necessary environment variables for RDS, DynamoDB, and API Gateway integration within `aws/main.tf` for the respective Lambdas. e90624d
- [~] Task: Conductor - User Manual Verification 'Deploy Lambda Functions' (Protocol in workflow.md)