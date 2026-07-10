# PF-006 - Build Scanner Adapters for Current Tools

## Objective

Convert current Gitleaks, `npm audit`, Semgrep, and Trivy outputs into normalized findings.

## Context

The repo already runs useful tools, but their outputs are raw text. Scanner adapters should parse machine-readable output formats where available and handle malformed output predictably.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `docs/issues/PF-005-normalized-finding-schema.md`
- `ISSUES_ORDER.md`

## Requirements

- Prefer JSON output from scanners instead of table or text output.
- Add adapters for Gitleaks, `npm audit`, Semgrep, and Trivy.
- Handle scanner failure and malformed output separately from clean results.
- Preserve raw outputs.
- Add parser fixtures and tests.

## Implementation Steps

1. Update scanner commands to request JSON where supported.
2. Add adapter modules or scripts.
3. Map scanner severity to platform severity.
4. Add parser tests for valid, empty, and malformed outputs.
5. Emit normalized findings into `findings.json`.

## Files Likely Affected

- Scanner orchestration files
- New adapter files
- New fixtures and tests

## Acceptance Criteria

- [ ] Current scanner outputs produce normalized findings.
- [ ] Empty scanner outputs produce no findings and a clean scanner status.
- [ ] Malformed scanner output creates an adapter error without claiming clean status.
- [ ] Tests cover at least one fixture per scanner.

## Tests / Verification Commands

```bash
# Replace with selected runtime test command.
bash -n scripts/repo/scripts/security_scan.sh
```

## Safety / Security Constraints

- Redact secret values from normalized findings.
- Do not commit raw scan outputs from real repositories.

## Out of Scope

- New scanner categories.
- License policy.
- GitHub repository control checks.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
