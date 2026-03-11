# Specification: Implement ECR Module and Integrate with EKS

## Overview
Implement a reusable ECR (Elastic Container Registry) module to store application images for an existing EKS cluster and future Lambda functions. Integrate the ECR repository with the current EKS module to ensure seamless image pull access.

## Functional Requirements
- **ECR Module:**
  - Create a private ECR repository in both AWS and LocalStack.
  - Support image scanning on push and tag immutability.
  - Implement a lifecycle policy to retain only the latest 10 images.
- **EKS Integration:**
  - Update the EKS cluster's IAM role (within LabRole constraints) to allow pulling images from the new ECR repository.
  - Ensure the EKS cluster can authenticate with the ECR repository.
- **Environment Parity:**
  - Use `tflocal` for LocalStack testing and `terraform` for AWS deployment.

## Non-Functional Requirements
- **Simplicity:** Keep the module design direct and consistent with existing `modules/vpc` and `modules/eks`.
- **Security:** Use least-privilege IAM roles and private networking where possible.

## Acceptance Criteria
- ECR repository created and accessible in both AWS and LocalStack.
- EKS cluster can pull a test image from the new ECR repository.
- Lifecycle policies correctly applied to the ECR repository.

## Out of Scope
- Implementation of ECS services.
- Implementation of Lambda functions (reserved for future tracks).
