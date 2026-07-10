# PF-007 - Generate Deterministic Technical and Executive Reports

## Objective

Generate official technical and executive reports from normalized findings, policy results, scanner statuses, and the scan manifest.

## Context

Current reporting depends on interpreting raw text. Official reports must be deterministic and must state scope, limitations, scanner status, and confidence.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `docs/issues/PF-005-normalized-finding-schema.md`
- `ISSUES_ORDER.md`

## Requirements

- Generate reports from `manifest.json`, `findings.json`, and policy results.
- Include scope, limitations, scanner statuses, and evidence paths.
- Include technical remediation order.
- Include executive summary without unsupported security claims.
- Allow optional AI narrative only as non-authoritative enrichment.

## Implementation Steps

1. Define report input contract.
2. Add deterministic report generator.
3. Update templates if they remain useful.
4. Add tests with fixture manifests and findings.
5. Update skill docs to stop treating raw text as the official source.

## Files Likely Affected

- `templates/reports/`
- `skills/security-pipeline/SKILL.md`
- New report generation code
- New tests

## Acceptance Criteria

- [ ] Reports can be regenerated from the same inputs with stable output.
- [ ] Reports clearly state scanner failures and unavailable scanners.
- [ ] Reports do not claim a repository is secure.
- [ ] Technical and executive report formats exist.
- [ ] Tests cover report generation from fixtures.

## Tests / Verification Commands

```bash
# Replace with selected runtime test command.
git diff --check
```

## Safety / Security Constraints

- Do not include unredacted secrets in reports.
- Do not make unsupported assurance claims.

## Out of Scope

- Branded CCT report styling.
- Signed reports.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
