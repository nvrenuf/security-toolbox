# PF-015 - Add Suppression, Exception, Baseline, and Regression Model

## Objective

Add deterministic handling for accepted risk, false positives, baselines, and new regressions.

## Context

The platform needs to distinguish known accepted findings from new or worsened findings. This is required for meaningful CI gates and audit reporting.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Define suppression and exception record formats.
- Require reason, owner, expiration, and scope for exceptions.
- Define baseline comparison behavior.
- Mark new, unchanged, fixed, and regressed findings.
- Include exception and baseline status in reports.

## Implementation Steps

1. Define data formats.
2. Add fingerprint matching.
3. Add policy handling for suppressions and exceptions.
4. Add baseline comparison.
5. Add tests for expiry, owner, and regression behavior.

## Files Likely Affected

- Policy evaluation code
- Schema docs
- Tests
- README

## Acceptance Criteria

- [ ] Suppressions require a scoped reason.
- [ ] Exceptions require owner and expiration.
- [ ] Expired exceptions fail policy.
- [ ] Baseline comparison identifies new and fixed findings.
- [ ] Reports include exception and regression status.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not allow broad permanent suppressions by default.
- Do not hide suppressed findings from audit outputs.

## Out of Scope

- Web UI for exception approval.
- External ticketing integration.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
