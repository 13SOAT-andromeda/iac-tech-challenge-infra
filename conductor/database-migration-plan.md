# Migration Plan: Database Infrastructure to Specialized Repository

## Objective
Extract the database-related Terraform code (RDS and DynamoDB) from `iac-tech-challenge-infra` and migrate it to the new `iac-tech-challenge-data` repository. This will ensure independent lifecycle management for the data layer while maintaining consistency with the original infrastructure and pipeline patterns.

## Repository Structure: `iac-tech-challenge-data`
```text
iac-tech-challenge-data/
├── .github/workflows/data-pipeline.yml
├── aws/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── data.tf             # New: Using Data Sources to find VPC/EKS
├── modules/
│   ├── rds/
│   └── dynamodb/
└── README.md
```

## Phase 1: Preparation in `iac-tech-challenge-data`

### 1.1 Core Modules Migration
- [ ] Copy the contents of `modules/rds/` and `modules/dynamodb/` to the new repository.

### 1.2 Data Discovery Strategy (`aws/data.tf`)
Since this is a separate repo, we will use **AWS Data Sources** instead of hardcoding ARNs or IDs. This ensures that the data repo can automatically "find" the network created by the infra repo.
- [ ] Implement `data "aws_vpc"` to find the VPC by its "Project" tag.
- [ ] Implement `data "aws_subnets"` to find the private subnets.
- [ ] Implement `data "aws_security_group"` to find the EKS cluster security group.

### 1.3 Main Configuration (`aws/main.tf`)
- [ ] Configure the S3 backend for state storage (e.g., using a different key like `data/terraform.tfstate`).
- [ ] Instantiate the `rds` and `dynamodb` modules, passing the IDs discovered in `data.tf`.

### 1.4 Variables & Outputs (`aws/variables.tf`, `aws/outputs.tf`)
- [ ] Move the `db_password` and other database-specific variables.
- [ ] Add outputs for the database endpoints and ARNs for use by applications.

## Phase 2: Specialized Pipeline (`.github/workflows/data-pipeline.yml`)

### 2.1 Workflow Adaptation
- [ ] Copy the existing `infra-pipeline.yml`.
- [ ] Remove the **Bootstrap S3 Backend** step (assuming the bucket already exists from the infra repo).
- [ ] Update the `working-directory` to focus on the `aws` folder in the data repo.
- [ ] Rename the pipeline to **"Data Layer Pipeline"**.

## Phase 3: Cleanup in `iac-tech-challenge-infra`

### 3.1 Resource Removal
- [ ] Remove the `module "rds"` and `module "dynamodb"` blocks from `aws/main.tf`.
- [ ] Remove the database-specific variables from `aws/variables.tf`.
- [ ] Delete the `modules/rds/` and `modules/dynamodb/` folders.

## Phase 4: State Migration (Optional)
*Note: For a tech challenge, starting with a fresh state in the new repo is recommended unless preserving the existing database is required.*
- [ ] If preservation is needed: Use `terraform state pull` from the old repo and `terraform state push` to the new one, or manually use `terraform import`.

## Verification & Testing
- [ ] Run `terraform plan` in the new repo to ensure it correctly discovers the existing VPC and EKS resources.
- [ ] Verify that the database security group still correctly allows traffic from the EKS security group.
- [ ] Test the pipeline in the new repository.
