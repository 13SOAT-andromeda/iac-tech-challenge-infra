# Tech Stack

## Infrastructure
- **Terraform (v1.0+):** Primary Infrastructure as Code (IaC) tool for defining and managing all AWS resources.
- **AWS Provider:** Used to manage standard cloud resources in the `us-east-1` region.
- **LocalStack Provider:** Enables local development and testing by emulating AWS services (ECR, VPC, EKS, RDS).

## Cloud Services (AWS - Infrastructure Layer)
- **VPC (Virtual Private Cloud):** Networking foundation with public and private subnets, internet gateways, and EKS-specific tagging.
- **EKS (Elastic Kubernetes Service):** Container orchestration for running stateless web services and microservices.
- **Lambda (Serverless):** Container-based serverless functions for asynchronous and auth tasks, managed via a decoupled compute pattern.
- **ECR (Elastic Container Registry):** Storage and management of Docker images for EKS and future Lambda functions.
- **S3 (Simple Storage Service):** Secure object storage for Terraform state and CI/CD artifacts.

## External Services (Managed in specialized repositories)
- **API Gateway (HTTP v2):** Secure entry point for all services, providing authentication, authorization, and VPC Link integration. Managed in `iac-tech-challenge-gateway`.
- **RDS (PostgreSQL):** Managed relational database service for application data persistence. Managed in `iac-tech-challenge-data`.
- **DynamoDB:** NoSQL database for session management and token storage. Managed in `iac-tech-challenge-data`.

## Development & Operations
- **LocalStack:** Local environment emulation for testing infrastructure changes without incurring AWS costs.
- **AWS CLI / tflocal:** Command-line interfaces for interacting with AWS and LocalStack environments.
- **LabRole & Concurrency Management:** Compliance with `LabRole` permissions and strict enforcement of the 10-instance concurrency limit for Lambda, mirrored in the LocalStack environment.
