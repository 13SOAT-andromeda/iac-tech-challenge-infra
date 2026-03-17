---
name: git-commit
description: >-
  Generates commit messages in Conventional Commits format and guides the commit
  workflow. Use when the user asks to commit, write a commit message, stage and
  commit, or when discussing commits or changelog-friendly messages.
---

# Git Commit

## When to Use

- User asks to "commit", "fazer commit", "commit message", "mensagem de commit"
- User wants to stage and commit changes
- User mentions Conventional Commits or changelog

## Commit Message Format (Conventional Commits)

Use this format:

```
<type>(<scope>): <short description>

[optional body]

[optional footer]
```

### Types

| Type     | Use for |
|----------|--------|
| `feat`   | New feature |
| `fix`    | Bug fix |
| `docs`   | Documentation only |
| `chore`  | Build, tooling, config (e.g. .gitignore, deps) |
| `refactor` | Code change that neither fixes nor adds a feature |
| `style`  | Formatting, no code change |
| `test`   | Adding or updating tests |
| `ci`     | CI/CD changes |

### Scope (optional)

Use a short scope when it helps: module or area (e.g. `vpc`, `eks`, `api-gateway`, `localstack`).

### Rules

- Subject: imperative, lowercase after type, no period at the end, ~50 chars
- Body (optional): wrap at 72 chars, explain what and why
- One logical change per commit; split large changes when possible

## Examples

**Feature (IaC):**
```
feat(eks): add node group with managed scaling

Configure managed node group with desired size 2–4 and instance types.
```

**Fix:**
```
fix(vpc): correct subnet CIDR for private subnets
```

**Docs:**
```
docs: add LocalStack quick start to README
```

**Chore:**
```
chore: add .env.example for LocalStack services
```

## Workflow

1. **Check status**: `git status` (and optionally `git diff` for message context).
2. **Stage**: `git add <paths>` or `git add -p` for partial staging.
3. **Message**: Propose a message following the format above; ask before running `git commit` if the user did not explicitly ask to execute.
4. **Commit**: `git commit -m "type(scope): subject"` or `-m` for subject and second `-m` for body.

Prefer suggesting the message and command; only run `git commit` when the user clearly asked to commit or approved the message.
