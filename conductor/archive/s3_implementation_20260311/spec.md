# Specification: S3 Implementation for Terraform State & Artifacts

## Overview
Create a simple, consistent Terraform implementation of S3 designed to store the Terraform `tfstate` for the CI/CD pipeline and an HTML email template. The solution must work seamlessly for both the Localstack environment and AWS, operating within the constraints of the AWS Academy `LabRole`.

## Functional Requirements
- **Module Structure:** Create a reusable Terraform module in the `modules/s3` directory.
- **Single Bucket:** Provision a single S3 bucket that accommodates both Terraform state files and the HTML email template (separated by prefixes/keys).
- **Versioning:** Enable bucket versioning to allow recovery of older state files or HTML templates in case of accidental overwrite or deletion.
- **Encryption:** Enforce default server-side encryption (SSE-S3) on the bucket for security.
- **Privacy:** Enforce private access to the bucket using `aws_s3_bucket_public_access_block`.
- **Environment Support:** The module must be instantiated in both the `aws` and `localstack` root modules.

## Non-Functional Requirements
- **IAM Constraints:** The implementation must comply with `LabRole` permissions.
- **Simplicity:** Keep the configuration as simple and consistent as possible while adhering to AWS/Localstack best practices.

## Acceptance Criteria
1. The `s3` module is created inside `modules/s3`.
2. The module successfully provisions an S3 bucket with versioning and SSE-S3 encryption enabled, and blocks all public access.
3. The module can be successfully deployed via both `aws` and `localstack` environments.
4. The bucket configuration works without IAM permission errors related to the `LabRole`.

## Out of Scope
- Setting up the CI/CD pipeline implementation itself (this track only provisions the storage substrate).
- Generating the actual HTML email template content.