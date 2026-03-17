# IaC Tech Challenge - Infrastructure

Infrastructure as Code (IaC) for setting up a VPC and EKS cluster, supporting both standard AWS environments and local development via LocalStack.

## Project Structure

- `modules/`: Reusable Terraform modules.
  - `vpc/`: Custom VPC wrapper with EKS-specific subnet tagging.
  - `eks/`: EKS cluster configuration using the official AWS EKS module.
- `aws/`: Root configuration for deploying to a real AWS environment (configured for AWS Academy/Lab roles).
- `localstack/`: Root configuration for local testing using LocalStack.

## Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) (v1.0+)
- [LocalStack](https://localstack.cloud/) (for local development)
- [AWS CLI](https://aws.amazon.com/cli/)

## Getting Started

### Local Development (LocalStack)

1. Start LocalStack (choose one):
   - **Docker Compose** (recommended):
     ```bash
     docker compose up -d
     ```
   - Or using the LocalStack CLI: `localstack start -d`

2. Optional: copy `.env.example` to `.env` and set `DEBUG=1` or `PERSISTENCE=1` if needed. Por padrão sobe **só API Gateway** (`SERVICES=apigateway`). Para o stack completo use `SERVICES=ec2,ecr,eks,rds,iam,sts,apigateway` no `.env`.

3. **Só API Gateway (teste rápido):**
   ```bash
   docker compose up -d
   cd localstack/apigateway-only
   tflocal init
   tflocal apply
   ```
   Os outputs mostram a URL do API no LocalStack.

4. **Stack completo (VPC, EKS, RDS, ECR, etc.):** defina `SERVICES=ec2,ecr,eks,rds,iam,sts,apigateway` no `.env`, reinicie o container e:
   ```bash
   cd localstack
   tflocal init
   tflocal apply
   ```

### AWS Deployment

1. Ensure your AWS credentials are configured.
2. Initialize and apply:
   ```bash
   cd aws
   terraform init
   terraform apply
   ```

## Configuration

The EKS cluster uses a pre-existing IAM role defined by the `cluster_role_arn` variable:
- **AWS Default:** `LabEksClusterRole` (standard for AWS Academy Labs).
- **LocalStack Default:** `arn:aws:iam::000000000000:role/eks-local-role`.
