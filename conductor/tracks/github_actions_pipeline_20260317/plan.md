# Implementation Plan: GitHub Actions CI/CD Pipeline

## Phase 1: Preparation & Base Structure [checkpoint: ef716ac]
- [x] Task: Create a skeletal `.github/workflows/infra-pipeline.yml` file 3b91913
- [x] Task: Remove the legacy `.github/workflows/infra-validation.yml` file 8e6c87f
- [x] Task: Conductor - User Manual Verification 'Phase 1' (Protocol in workflow.md) ef716ac

## Phase 2: CI - Code Integration [checkpoint: 6187cf0]
- [x] Task: Implement the `terraform-ci` job in `infra-pipeline.yml` d11122e
- [x] Task: Add triggers for `develop` and `release/*` branches (PR) d11122e
- [x] Task: Add steps for `checkout`, `setup-terraform`, `fmt`, and `validate` d11122e
- [x] Task: Conductor - User Manual Verification 'Phase 2' (Protocol in workflow.md) 6187cf0

## Phase 3: The Dry-Run (Planning) [checkpoint: 78b15f8]
- [x] Task: Implement `The Dry-Run` job in `infra-pipeline.yml` 08585e7
- [x] Task: Add triggers for `main` branch (PR) 08585e7
- [x] Task: Add steps for `checkout`, `setup-terraform`, `init` (S3 backend), and `plan` 08585e7
- [x] Task: Add step to post plan output to PR comments with the approved template: 08585e7
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
- [x] Task: Conductor - User Manual Verification 'Phase 3' (Protocol in workflow.md) 78b15f8

## Phase 4: The Execution (CD) [checkpoint: 1bdbeff]
- [x] Task: Implement `The Execution` job in `infra-pipeline.yml` 802e5bb
- [x] Task: Add push (merge) trigger for `main` branch 802e5bb
- [x] Task: Add steps for `checkout`, `setup-terraform`, `init` (S3 backend), and `apply -auto-approve` 802e5bb
- [x] Task: Conductor - User Manual Verification 'Phase 4' (Protocol in workflow.md) 1bdbeff
