---
name: github-pr
description: >-
  Guides creation of Pull Requests on GitHub with title, description template,
  and checklist. Use when the user asks to create a PR, open a PR, pull request,
  or to draft or format a PR description for GitHub.
---

# GitHub Pull Request

## When to Use

- User asks to "create PR", "abrir PR", "pull request", "criar PR no GitHub"
- User wants a PR description or title
- User mentions merging branches or opening a PR

## PR Title

- Same style as commits: **Conventional Commits** when possible.
- Examples: `feat(eks): add managed node group`, `fix(vpc): subnet CIDR`, `docs: update README`.

## PR Description Template

Use this structure (adapt sections as needed):

```markdown
## Descrição
Breve resumo do que o PR faz (1–2 frases).

## Motivação / contexto
Por que essa mudança é necessária (issue, requisito, etc.).

## Alterações
- Item 1
- Item 2
- Item 3

## Tipo de mudança
- [ ] Bug fix
- [ ] Nova feature
- [ ] Breaking change
- [ ] Documentação
- [ ] Refatoração / chore

## Checklist
- [ ] Código segue o padrão do projeto (ex.: `terraform fmt`)
- [ ] Comentários adicionados em trechos não óbvios
- [ ] Documentação atualizada se necessário
- [ ] Sem mudanças desnecessárias (apenas o escopo do PR)
```

For **IaC/Terraform** projects, include:

```markdown
## Checklist (IaC)
- [ ] `terraform fmt` (ou `tflocal fmt`) executado
- [ ] `terraform plan` (ou `tflocal plan`) revisado
- [ ] Variáveis sensíveis não commitadas
- [ ] Outputs/README atualizados se houver novos recursos
```

## Workflow

1. **Branch**: Confirm branch name and that changes are committed (e.g. `git status`, `git log -1`).
2. **Push**: Remind or run `git push -u origin <branch>` if the branch is not pushed yet.
3. **Title**: Propose a PR title in Conventional Commits style.
4. **Description**: Fill the template above with the user’s context; leave placeholders only where the user must fill (e.g. link to issue).
5. **Create PR**: User creates the PR in the GitHub UI (or via `gh pr create` if they use GitHub CLI). Provide the exact title and body so they can paste.

If the user has **GitHub CLI** (`gh`):

- **Interactive**: `gh pr create` — then paste title and body when prompted.
- **With file**: save the description to a temp file (e.g. `pr-body.md`) and run:
  `gh pr create --title "type(scope): short title" --body-file pr-body.md`

## Notes

- Do not run `gh pr create` unless the user explicitly asked to open the PR and the repo/remotes are clear.
- Prefer providing copy-paste ready title and description; let the user create the PR in the UI or via `gh` as they prefer.
