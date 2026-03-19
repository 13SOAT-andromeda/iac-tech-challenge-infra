# Initial Concept

# Product Definition

## Vision
To build a robust, simple, and consistent Infrastructure as Code (IaC) substrate for storing and managing build artifacts (ECR) across both standard AWS and LocalStack environments. This infrastructure will support a senior software engineer's workflow by providing high-fidelity, yet developer-optimized, container registries for an existing EKS cluster and future serverless (Lambda) expansion.

## Core Features
- **ECR Repository Module:** A reusable Terraform module to create and manage container registries for storing EKS and future Lambda application images.
- **Decoupled Lambda Compute Pattern:** A scalable architectural pattern where Lambda functions are managed in their respective microservice repositories, while the ECR foundations remain in the central infrastructure repository.
- **S3 Storage Module:** A modular S3 implementation for securely storing Terraform state files and application artifacts (e.g., HTML templates) with versioning and encryption.
- **DynamoDB Storage Module:** A consistent NoSQL implementation for managing session tokens and authentication metadata with TTL and pay-per-request billing.
- **Environment Parity (Developer Optimized):** A streamlined approach to LocalStack integration that mirrors core AWS ECR functionality while maintaining a fast developer inner-loop.
- **Traceable EKS & ECR Integration:** Deep integration between EKS and ECR, including automated IAM permissioning and metadata tagging for seamless image deployments and infrastructure traceability.
- **Automated CI/CD Pipeline:** A streamlined GitHub Actions pipeline for automated Terraform formatting, validation, planning (with PR comments), and deployment to AWS.

## Microservices Substrate
- **tech-challenge-user-validation:** Handles JWT generation and validation via RDS and DynamoDB.
- **tech-challenge-user-authentication:** Provides authorizer logic for API Gateway.
- **tech-challenge-notification-service:** Asynchronous service for handling system notifications.

## Target User (Persona)
- **Senior Software Engineer:** Focused on building scalable, maintainable, and portable infrastructure using professional-grade tools (Terraform, AWS, LocalStack).

## Goals & Success Criteria
- **Simplicity & Consistency:** High modularity in Terraform while keeping implementation direct and easy to reason about.
- **Build Support:** Seamlessly supporting the latest build versions of applications to run in the existing EKS cluster.
- **LabRole & Concurrency Compliance:** Successfully utilizing the existing `LabRole` and managing account-level concurrency limits (10 instances) for serverless deployments across both AWS and LocalStack environments.
