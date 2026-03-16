# Specification: EKS and ECR Integration for Pod Deployments

## Overview
This track focuses on integrating the newly created ECR repository with the existing EKS cluster to enable the deployment of application Pods. The primary goal is to establish a seamless workflow where the EKS cluster can pull and run the 'latest' version of a Docker image stored in the ECR repository using standard Kubernetes manifests.

## Functional Requirements
- **ECR Access:** Ensure the EKS Node Group has the necessary IAM permissions to pull images from the ECR repository (leveraging the `AmazonEC2ContainerRegistryReadOnly` policy).
- **Latest Image Strategy:** Configure the integration to support pulling images tagged with `latest`.
- **Root Module Outputs:** Export the ECR repository URL from the `aws/` and `localstack/` root modules to facilitate external CI/CD or manual `kubectl` operations.

## Non-Functional Requirements
- **Environment Parity:** The integration must work identically in both standard AWS and LocalStack environments.
- **Simplicity:** Use standard `kubectl` and Kubernetes manifests for deployment, avoiding complex CI/CD tooling for this phase.
- **LabRole Compliance:** Ensure all IAM configurations are compatible with the AWS Academy `LabRole`.

## Acceptance Criteria
- ECR repository URL is correctly outputted after `terraform apply`.
- Pods in the EKS cluster can successfully pull the `latest` image from ECR (verified in LocalStack).

## Out of Scope
- Automated CI/CD pipeline implementation (GitHub Actions, Jenkins, etc.).
- Helm chart development.
- Advanced image tagging strategies (Semantic Versioning, Git SHAs).
