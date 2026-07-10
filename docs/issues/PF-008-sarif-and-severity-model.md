# PF-008 - Add SARIF Output and Consistent Severity Model

## Objective

Emit SARIF for supported findings and apply one consistent severity model across scanners, reports, and policy.

## Context

The current script restricts Trivy to High and Critical while report expectations include all severities. CI and GitHub code scanning need SARIF where appropriate.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Define platform severity levels and mapping rules.
- Preserve original scanner severity separately.
- Emit SARIF for findings that map cleanly to code-scanning locations.
- Document findings that cannot be represented well in SARIF.
- Align scan collection and report severity handling.

## Implementation Steps

1. Define severity mapping documentation.
2. Add SARIF writer.
3. Add tests for severity mappings.
4. Add tests for SARIF output validity.
5. Update CI issue specs to use SARIF output.

## Files Likely Affected

- New SARIF writer
- Schema docs
- Tests
- README

## Acceptance Criteria

- [ ] Severity model is documented.
- [ ] SARIF output exists where appropriate.
- [ ] Original scanner severity is preserved.
- [ ] Trivy scan severity collection and reporting expectations are consistent.
- [ ] SARIF validates with the selected validation tool or tests.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not include secret values in SARIF messages.
- Do not upload SARIF automatically outside explicit CI workflows.

## Out of Scope

- GitHub Actions upload workflow.
- Policy gate enforcement.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
