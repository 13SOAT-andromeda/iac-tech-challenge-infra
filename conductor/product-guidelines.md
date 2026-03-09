# Product Guidelines

## Tooling & Context (MCP Integration)
- **Leverage MCPs:** Always use the `localstack` and `aws` MCP tools to validate the current state, confirm service availability, and ensure that the infrastructure implementation is perfectly aligned with the actual environment context.

## Prose Style
- **Professional & Technical:** Use clear, concise language suitable for engineering documentation.
- **Action-Oriented:** Focus on what the infrastructure *does* and how to *use* it.
- **Consistent Terminology:** Adhere to AWS and Terraform standard naming conventions.

## Branding & Visuals
- **Terminal-Centric:** Use code blocks and ASCII diagrams for technical explanations.
- **Terraform Best Practices:** Follow HCL styling for all infrastructure code (e.g., snake_case for resources).
- **Environment Tags:** Use a consistent tagging strategy (e.g., `Terraform = "true"`, `Project = "tech-challenge"`) to identify resources.

## UX Principles (Infrastructure)
- **Predictability:** Ensure LocalStack and AWS behaviors are as similar as possible.
- **Safety First:** Prioritize least-privilege IAM roles and private networking.
- **Maintainability:** Use modular designs and clear variable descriptions to simplify future updates.
- **Fail-Fast:** Implement validation in Terraform to catch configuration errors early.
