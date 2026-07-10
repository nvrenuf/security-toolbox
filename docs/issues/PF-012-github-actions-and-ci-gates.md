# PF-012 - Add GitHub Actions Integration and CI Gates

## Objective

Add GitHub Actions support for pull request scanning, artifacts, annotations, SARIF upload, and configurable security gates.

## Context

The repo has no CI integration. Phase 1 needs local and CI execution modes, but gate behavior must be configurable and must not hide scanner failures.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Add a GitHub Actions workflow or reusable workflow example.
- Upload machine-readable outputs and reports as artifacts.
- Upload SARIF where appropriate.
- Add annotations for key findings where safe.
- Support configurable gate policy.
- Distinguish scanner health failure from policy failure.

## Implementation Steps

1. Confirm initial gate policy.
2. Add workflow using pinned actions.
3. Add artifact upload paths.
4. Add SARIF upload step when SARIF exists.
5. Document CI configuration.

## Files Likely Affected

- `.github/workflows/`
- README
- CI entrypoint scripts
- Policy configuration files

## Acceptance Criteria

- [ ] Pull requests run tests and security scan smoke checks.
- [ ] Scan outputs are uploaded as artifacts.
- [ ] SARIF upload is configured when SARIF exists.
- [ ] Gate policy is configurable.
- [ ] Workflow uses pinned action versions or a documented pinning strategy.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not upload unredacted secrets in annotations.
- Do not run network scans in CI by default.
- Do not make CI destructive or production-impacting.

## Out of Scope

- Scheduled scans.
- GitHub repository security-control assessment.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
