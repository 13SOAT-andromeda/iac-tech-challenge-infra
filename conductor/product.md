# Initial Concept

# Product Definition

## Vision
To build a robust, simple, and consistent Infrastructure as Code (IaC) substrate for storing and managing build artifacts (ECR) across both standard AWS and LocalStack environments. This infrastructure will support a senior software engineer's workflow by providing high-fidelity, yet developer-optimized, container registries for an existing EKS cluster and future serverless (Lambda) expansion.

## Core Features
- **ECR Repository Module:** A reusable Terraform module to create and manage container registries for storing EKS and future Lambda application images.
- **Reusable Lambda Module:** A container-based Lambda deployment module supporting microservices like user validation, authentication, and notifications.
- **S3 Storage Module:** A modular S3 implementation for securely storing Terraform state files and application artifacts (e.g., HTML templates) with versioning and encryption.
- **Environment Parity (Developer Optimized):** A streamlined approach to LocalStack integration that mirrors core AWS ECR functionality while maintaining a fast developer inner-loop.
- **Traceable EKS & ECR Integration:** Deep integration between EKS and ECR, including automated IAM permissioning and metadata tagging for seamless image deployments and infrastructure traceability.

## Microservices Substrate
- **tech-challenge-user-validation:** Handles JWT generation and validation via RDS and DynamoDB.
- **tech-challenge-user-authentication:** Provides authorizer logic for API Gateway.
- **tech-challenge-notification-service:** Asynchronous service for handling system notifications.

## Target User (Persona)
- **Senior Software Engineer:** Focused on building scalable, maintainable, and portable infrastructure using professional-grade tools (Terraform, AWS, LocalStack).

## Goals & Success Criteria
- **Simplicity & Consistency:** High modularity in Terraform while keeping implementation direct and easy to reason about.
- **Build Support:** Seamlessly supporting the latest build versions of applications to run in the existing EKS cluster.
- **LabRole & Concurrency Compliance:** Successfully utilizing the existing `LabRole` and managing account-level concurrency limits (10 instances) for serverless deployments.
