# Specification - Lambda Module with ECR Integration

## Overview
This track involves the implementation of a reusable Terraform module for deploying AWS Lambda functions from container images. The module will be used to deploy three specific services: `tech-challenge-user-validation`, `tech-challenge-user-authentication`, and `tech-challenge-notification-service`, each with its own dedicated ECR repository.

## Functional Requirements
- **Reusable Lambda Module:**
    - Support for `package_type = "Image"`.
    - Uses the existing AWS Academy `LabRole` for execution instead of creating custom roles.
    - Configures `reserved_concurrent_executions` to strictly adhere to the 10 concurrent running instances account limit.
    - Support for environment variables and external service integration (RDS, DynamoDB, API Gateway).
    - Architecture: `x86_64`.
    - Runtime: `Go 1.x` (containerized).
- **ECR Management:**
    - Separate ECR repositories will be created for each function (`tech-challenge-user-validation-repo`, `tech-challenge-user-authentication-repo`, `tech-challenge-notification-service-repo`).
    - Immutable tags and scan-on-push enabled.
- **Service-Specific Logic:**
    - **`tech-challenge-user-validation`:**
        - Triggered via AWS SDK.
        - Interfaces with RDS (PostgreSQL) and DynamoDB.
        - Generates JWT and stores it in DynamoDB.
    - **`tech-challenge-user-authentication`:**
        - Configured as a Lambda Authorizer for API Gateway.
        - Validates requests for private API endpoints.
    - **`tech-challenge-notification-service`:**
        - Triggered by an SNS/SQS topic (under discussion).

- **LocalStack Parity:**
    - Mirror the Lambda and ECR configuration in the `localstack/` environment.
    - Ensure `reserved_concurrent_executions` is supported or gracefully handled in the local environment.

## Non-Functional Requirements
- **Simplicity & Modularity:** Reusable module structure to minimize duplication.
- **Compliance:** Strict adherence to AWS Academy constraints (`LabRole` and Concurrency limits).
- **Observability:** Basic CloudWatch logging and metrics.

## Acceptance Criteria
- [ ] Terraform module `modules/lambda` is created and functional.
- [ ] Three separate ECR repositories are provisioned.
- [ ] Three Lambda functions are deployed with the specified names and configurations.
- [ ] Functions are attached to the `LabRole` and have concurrency limits applied.
- [ ] CloudWatch Log Groups are created for each function with a 14-day retention policy.

## Out of Scope
- Implementation of the Monolith API or the actual Go code for the Lambdas (Terraform infrastructure only).
- API Gateway resource creation (infrastructure for the Authorizer only).
- SNS/SQS resource creation for `tech-challenge-notification-service` (until finalized).