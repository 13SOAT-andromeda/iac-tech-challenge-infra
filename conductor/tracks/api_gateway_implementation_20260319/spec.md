# Track: Implement API Gateway Module

## Overview
Implement a new, simple, and clean API Gateway module for the tech-challenge services. It will handle authentication for public routes and authorization for private routes, proxying requests to an EKS Load Balancer.

## Functional Requirements
- **REST API:** Create an AWS API Gateway (REST).
- **Public Route (`/login`):**
    - Method: `POST`
    - Body: `{ "document": "...", "password": "..." }`
    - Integration: AWS Lambda `tech-challenge-user-authentication`.
    - Response: Direct pass-through from Lambda.
- **Private Route Prefix (`/api/*`):**
    - Prefix: `/api`
    - Authorization: Lambda Token Authorizer using `tech-challenge-user-authorizer`.
    - **Header for Auth:** `X-AUTH-TOKEN` (Note: Token authorizers are limited to a single header).
    - **Integration:** Proxy to EKS Load Balancer via **VPC Link**.
- **Lambda Naming:**
    - Authentication: `tech-challenge-user-authentication`
    - Authorization: `tech-challenge-user-authorizer`
- **Error Handling:**
    - **Default Responses:** API Gateway will return its default 401 Unauthorized or 403 Forbidden responses when authorization fails.
- **Environment Support:** Full support for both standard AWS and LocalStack environments.

## Technical Details
- **Provider:** Use standard AWS and LocalStack providers.
- **LabRole:** Support for `LabRole` ARN as a module variable.
- **VPC Integration:** Utilize `VPC Link` for private integration between API Gateway and the EKS Load Balancer.
- **Infrastructure:**
    - Load Balancer DNS passed as a module variable.
    - Clean, modular Terraform structure following project standards.

## Non-Functional Requirements
- **Consistency:** Align with the existing infrastructure patterns (S3, ECR, VPC).
- **Simplicity:** Minimize complexity in the Terraform configuration.
- **Maintainability:** Ensure code is well-documented and easy to update.

## Acceptance Criteria
- [ ] Terraform module created in `modules/api-gateway/`.
- [ ] Module successfully deployed/planned in both AWS and LocalStack.
- [ ] `/login` route correctly routes to the authentication Lambda.
- [ ] `/api/*` route correctly enforces authorization via the authorizer Lambda.
- [ ] Private routes successfully proxy traffic to the backend Load Balancer via VPC Link.
- [ ] Compliance with `LabRole` permission rules.
- [ ] All code passes `terraform validate`.

## Out of Scope
- Implementation of the Lambda function code itself.
- Implementation of the EKS Load Balancer (assumed to exist).
