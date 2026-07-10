# PF-013 - Add GitHub Repository Security-Control Assessment

## Objective

Assess repository security controls such as branch protection, secret scanning, push protection, Dependabot, Actions permissions, CODEOWNERS, and required reviews.

## Context

Scanner results do not cover repository governance. CCT needs a repository configuration assessment alongside code and dependency findings.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Define control checks and expected evidence.
- Use GitHub API only with explicitly provided scoped credentials.
- Redact token values and sensitive API details.
- Normalize control gaps as findings or policy results.
- Include control status in reports.

## Implementation Steps

1. Define initial GitHub control checklist.
2. Add API client or CLI integration.
3. Add unauthenticated fallback where possible.
4. Add fixtures for API responses.
5. Add report sections for repository controls.

## Files Likely Affected

- New GitHub assessment code
- Policy config
- Tests and fixtures
- README

## Acceptance Criteria

- [ ] Branch protection or ruleset status is checked when permissions allow.
- [ ] Secret scanning and push protection status is checked when permissions allow.
- [ ] Dependabot and Actions permissions are checked when permissions allow.
- [ ] Missing permissions are reported as limitations, not clean controls.
- [ ] Tests use fixtures, not live credentials.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not commit GitHub tokens.
- Do not print full API response bodies if they may contain sensitive data.
- Do not modify repository settings in assessment mode.

## Out of Scope

- Auto-remediation of GitHub settings.
- Organization-wide scanning scheduler.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
