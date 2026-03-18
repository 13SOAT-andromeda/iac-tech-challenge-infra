# Implementation Plan: GitHub Actions CI/CD Pipeline

## Phase 1: Preparation & Base Structure
- [ ] Task: Create a skeletal `.github/workflows/infra-pipeline.yml` file
- [ ] Task: Remove the legacy `.github/workflows/infra-validation.yml` file
- [ ] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md)

## Phase 2: CI - Code Integration
- [ ] Task: Implement the `terraform-ci` job in `infra-pipeline.yml`
- [ ] Task: Add triggers for `develop` and `release/*` branches (PR)
- [ ] Task: Add steps for `checkout`, `setup-terraform`, `fmt`, and `validate`
- [ ] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md)

## Phase 3: The Dry-Run (Planning)
- [ ] Task: Implement `The Dry-Run` job in `infra-pipeline.yml`
- [ ] Task: Add triggers for `main` branch (PR)
- [ ] Task: Add steps for `checkout`, `setup-terraform`, `init` (S3 backend), and `plan`
- [ ] Task: Add step to post plan output to PR comments with the approved template:
  ```markdown
  #### Terraform Format and Style 🖌 `{{ steps.fmt.outcome }}`
  #### Terraform Initialization ⚙️ `{{ steps.init.outcome }}`
  #### Terraform Validation 🤖 `{{ steps.validate.outcome }}`
  #### Terraform Plan 📖 `{{ steps.plan.outcome }}`

  <details><summary>Show Plan Summary</summary>

  ```terraform
  {{ steps.plan.outputs.stdout }}
  ```

  </details>

  *Pushed by: @{{ github.actor }}, Action: `{{ github.event_name }}`*
  ```
- [ ] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md)

## Phase 4: The Execution (CD)
- [ ] Task: Implement `The Execution` job in `infra-pipeline.yml`
- [ ] Task: Add push (merge) trigger for `main` branch
- [ ] Task: Add steps for `checkout`, `setup-terraform`, `init` (S3 backend), and `apply -auto-approve`
- [ ] Task: Conductor - User Manual Verification 'Phase 4' (Protocol in workflow.md)
