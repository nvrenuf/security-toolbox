# PF-018 - Document Product Claims, Limitations, and Operator Workflow

## Objective

Document the allowed product claims, prohibited claims, limitations, and operator workflow for local, CI, and scheduled execution.

## Context

Security reports can create false confidence if they overstate coverage. The project must clearly state scope, limitations, scanner status, and confidence.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/repo-boundaries.md`
- `ISSUES_ORDER.md`

## Requirements

- Document allowed and prohibited claims.
- Document local, CI, and scheduled execution workflows.
- Document evidence retention and handling expectations.
- Document scanner limitations and confidence language.
- Document operator approval requirements for risky workflows.

## Implementation Steps

1. Add operator guide.
2. Update README with quick paths and links.
3. Add report-language guardrails.
4. Add scheduled execution notes without building the scheduler.
5. Add review checklist for report approval.

## Files Likely Affected

- `README.md`
- New `docs/operator-guide.md`
- Report templates
- `AGENTS.md` if agent behavior changes

## Acceptance Criteria

- [ ] Allowed and prohibited claims are documented.
- [ ] Operators can follow local and CI workflows.
- [ ] Risky workflows require approval.
- [ ] Report limitations are plain and visible.
- [ ] Evidence handling rules are documented.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not encourage scanning systems without authorization.
- Do not claim complete security assurance.
- Do not include real customer evidence in docs.

## Out of Scope

- Scheduled execution implementation.
- Commercial customer documentation.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
