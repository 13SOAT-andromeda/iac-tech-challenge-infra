# Implementation Plan: API Gateway Module

## Overview
Implement a reusable Terraform module for AWS API Gateway (REST) that handles public and private routes with authentication/authorization and VPC integration.

## Phase 1: Module Scaffolding & Core Setup [checkpoint: bb86944]
- [x] Task: Create `modules/api-gateway/` directory structure and initial files (`main.tf`, `variables.tf`, `outputs.tf`). (b42db05)
- [x] Task: Define input variables (`vpc_id`, `subnet_ids`, `lb_dns_name`, `lab_role_arn`, `auth_lambda_arn`, `authorizer_lambda_arn`). (7b5fd1e)
- [x] Task: Set up basic REST API resource and its deployment. (7853c35)
- [x] Task: Conductor - User Manual Verification 'Phase 1: Module Scaffolding & Core Setup' (Protocol in workflow.md) (bb86944)

## Phase 2: Public Routes & Lambda Integration [checkpoint: 378039d]
- [x] Task: Write failing tests for `/login` endpoint (Red Phase). (6847271)
- [x] Task: Implement `/login` resource and POST method (Green Phase). (2014cdb)
- [x] Task: Configure Lambda proxy integration for `/login`. (2014cdb)
- [x] Task: Verify functionality and commit changes. (2014cdb)
- [x] Task: Conductor - User Manual Verification 'Phase 2: Public Routes & Lambda Integration' (Protocol in workflow.md) (378039d)

## Phase 3: VPC Link & Private Proxy Integration
- [ ] Task: Write failing tests for `/api/*` proxying (Red Phase).
- [ ] Task: Implement `aws_api_gateway_vpc_link` for connection to the internal VPC.
- [ ] Task: Implement `/api` resource and greedy child proxy (`{proxy+}`).
- [ ] Task: Configure HTTP Proxy integration to the EKS Load Balancer DNS via the VPC Link (Green Phase).
- [ ] Task: Verify proxy functionality and commit changes.
- [ ] Task: Conductor - User Manual Verification 'Phase 3: VPC Link & Private Proxy Integration' (Protocol in workflow.md)

## Phase 4: Token Authorization Implementation
- [ ] Task: Write failing tests for authorized routes (Red Phase).
- [ ] Task: Implement `aws_api_gateway_authorizer` (Token type) using the `X-AUTH-TOKEN` header.
- [ ] Task: Attach the authorizer to all methods under the `/api/*` path (Green Phase).
- [ ] Task: Configure default Gateway Responses for 401/403 errors.
- [ ] Task: Verify authorization enforcement and commit changes.
- [ ] Task: Conductor - User Manual Verification 'Phase 4: Token Authorization Implementation' (Protocol in workflow.md)

## Phase 5: Environment Parity & Final Validation
- [ ] Task: Validate the complete module in the `aws/` environment (Plan only).
- [ ] Task: Implement specific LocalStack configurations/overrides if necessary in `localstack/` (Plan/Apply).
- [ ] Task: Conduct final end-to-end verification of all routes.
- [ ] Task: Conductor - User Manual Verification 'Phase 5: Environment Parity & Final Validation' (Protocol in workflow.md)
