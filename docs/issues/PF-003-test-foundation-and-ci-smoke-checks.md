# PF-003 - Add Automated Test Foundation and CI Smoke Checks

## Objective

Add a test foundation that can verify scanner status handling, output handling, malformed inputs, report generation, and shell script quality.

## Context

The repository has no meaningful automated tests or CI. Without tests, later parser and reporting work will be difficult to review safely.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Add a minimal test runner appropriate for the chosen runtime.
- Add shell syntax checks for existing scripts.
- Add fixture-based tests for scanner output handling.
- Add CI smoke checks that run without real scanner network access.
- Document how to run tests locally.

## Implementation Steps

1. Choose the test stack after the runtime decision.
2. Add fixtures for current scanner outputs and failure cases.
3. Add unit or integration tests for status classification.
4. Add a GitHub Actions workflow for tests.
5. Update README with test commands.

## Files Likely Affected

- New `tests/`
- `.github/workflows/`
- `README.md`
- Scanner wrapper files

## Acceptance Criteria

- [ ] Tests can run on a clean checkout.
- [ ] CI runs tests on pull requests.
- [ ] Missing scanner behavior is covered.
- [ ] Malformed output behavior is covered.
- [ ] Report-generation tests can be added without real scanner execution.

## Tests / Verification Commands

```bash
bash -n scripts/repo/scripts/security_scan.sh
bash -n scripts/network/network_scan.sh
```

Replace or extend these commands with the selected test runner.

## Safety / Security Constraints

- Test fixtures must not contain real secrets.
- CI must not run intrusive network scans.

## Out of Scope

- Full scanner adapter implementation.
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
