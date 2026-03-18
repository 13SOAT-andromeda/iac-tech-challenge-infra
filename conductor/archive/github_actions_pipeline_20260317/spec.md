# Specification: GitHub Actions CI/CD Pipeline

## Overview
A streamlined GitHub Actions CI/CD pipeline for a solo developer deploying Terraform to a single AWS student environment. This pipeline will replace the existing `infra-validation.yml` with a single, comprehensive workflow following the project's branching and deployment strategy.

## Functional Requirements

### Phase 1: Code Integration
- **Trigger:** Pull Requests targeting `develop` or `release/*`.
- **Actions:**
  - `terraform fmt -check`
  - `terraform validate`
- **Constraint:** Fast execution; no AWS credentials or `terraform init` (using backend) required.

### Phase 2: The Dry-Run
- **Trigger:** Pull Request opened targeting `main`.
- **Actions:**
  - Configure AWS credentials using GitHub Secrets (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`).
  - `terraform init` (with dynamic backend parameterization).
  - `terraform plan -no-color`.
- **Visibility:** Output the plan directly into the PR comments using `hashicorp/setup-terraform`.

### Phase 3: The Execution
- **Trigger:** Push event (merge) to the `main` branch.
- **Actions:**
  - Configure AWS credentials using GitHub Secrets.
  - `terraform init` (with dynamic backend parameterization).
  - `terraform apply -auto-approve`.

## Non-Functional Requirements
- **Single Workflow File:** Consolidate all phases into `.github/workflows/infra-pipeline.yml`.
- **State Management:** Simple remote state using ONLY an S3 backend (No DynamoDB locking).
- **Branching Strategy:** `feature/*` -> `develop` -> `release/*` -> `main`.
- **Rollback Strategy:** All rollbacks handled via standard `git revert` on the `main` branch. No S3 state file manipulation.
- **Standard Provider:** Standard AWS provider configuration only (no LocalStack switching).

## Acceptance Criteria
1. PRs to `develop` and `release/*` correctly validate Terraform syntax and formatting.
2. PRs to `main` provide a readable `terraform plan` in the PR comments.
3. Merges to `main` automatically apply infrastructure changes to the AWS student account.
4. The pipeline is contained within a single `.github/workflows/infra-pipeline.yml` file and replaces `infra-validation.yml`.

## Out of Scope
- LocalStack-specific CI/CD logic.
- DynamoDB state locking.
- Multi-account or multi-region deployment strategies.
