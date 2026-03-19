# Specification: Decouple Lambda Compute Pattern

## Overview
This track implements the "Decoupled Compute Pattern" for AWS Lambda functions. By separating the infrastructure foundation (ECR) from the compute lifecycle (Lambda creation/deployment), we resolve circular dependencies and align with enterprise microservice best practices.

## Functional Requirements

### 1. Main Infrastructure Repository (iac-tech-challenge-infra)
- **Refactor:** Remove `module.lambda_*` calls from `aws/main.tf`.
- **Registry Foundation:** Continue to manage ECR repositories (`module.ecr_*`).
- **Data Sharing:** Ensure consistent naming conventions for ECR repositories and IAM roles (`LabRole`).

### 2. Microservice Repositories
For each service (`tech-challenge-user-validation`, `tech-challenge-user-authentication`, `tech-challenge-notification-service`):
- **Terraform Directory:** Create a `terraform/` folder containing the service's specific Lambda configuration.
- **Dependency Resolution:** Use `data` sources to fetch ECR repository URIs and IAM roles from the main infra repo.
- **CI/CD Integration:** Implement a GitHub Actions workflow that:
  - Builds and pushes the Docker image to its ECR repository.
  - Runs `terraform apply` to create or update the Lambda function.

## Non-Functional Requirements
- **Consistency:** Use the existing `module "lambda"` (from the infra repo) as a remote source.
- **Security:** Maintain the same IAM role (`LabRole`) and environment variable mappings.
- **UX:** Clear separation between infra-level foundations and app-level compute.

## Acceptance Criteria
1. `iac-tech-challenge-infra` successfully applies without errors and only manages ECR.
2. Each microservice repository can successfully build, push, and deploy its own Lambda function.
3. Lambda functions correctly reference the Docker image `:latest` tag in their respective ECR repositories.
4. No "Source image does not exist" errors during deployment.

## Out of Scope
- Migrating RDS or DynamoDB resources (remain in infra repo).
- Changes to LocalStack provider logic.
- API Gateway integration (to be handled in future tracks).
