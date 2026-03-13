# Implementation Plan - Lambda Module with ECR Integration

## Phase 1: Create Reusable Lambda Module
- [x] Task: Write Terraform tests (`tests/lambda.tftest.hcl`) defining expected variables and module structure. a17b7c1
- [x] Task: Implement `modules/lambda/variables.tf` (including `role_arn` and `reserved_concurrent_executions`) and `modules/lambda/outputs.tf`. 587e6b5
- [x] Task: Implement `modules/lambda/main.tf` for `aws_lambda_function` with `package_type = "Image"`, attaching the passed `LabRole` ARN and applying the concurrency limit. 587e6b5
- [x] Task: Run `terraform fmt` and `terraform validate` within the module directory to ensure correctness. 587e6b5
- [~] Task: Conductor - User Manual Verification 'Create Reusable Lambda Module' (Protocol in workflow.md)

## Phase 2: Provision ECR Repositories
- [ ] Task: Update `aws/main.tf` to call the `ecr` module three times (for `tech-challenge-user-validation-repo`, `tech-challenge-user-authentication-repo`, and `tech-challenge-notification-service-repo`).
- [ ] Task: Update `aws/outputs.tf` to output the URLs of the newly created repositories.
- [ ] Task: Conductor - User Manual Verification 'Provision ECR Repositories' (Protocol in workflow.md)

## Phase 3: Deploy Lambda Functions
- [ ] Task: Update `aws/main.tf` to call the new `lambda` module three times to provision `tech-challenge-user-validation`, `tech-challenge-user-authentication`, and `tech-challenge-notification-service`.
- [ ] Task: Pass the existing `LabRole` ARN to each Lambda module instance.
- [ ] Task: Configure `reserved_concurrent_executions` (e.g., 3 per function) to ensure the total limit of 10 concurrent executions is never breached.
- [ ] Task: Configure necessary environment variables for RDS, DynamoDB, and API Gateway integration within `aws/main.tf` for the respective Lambdas.
- [ ] Task: Conductor - User Manual Verification 'Deploy Lambda Functions' (Protocol in workflow.md)