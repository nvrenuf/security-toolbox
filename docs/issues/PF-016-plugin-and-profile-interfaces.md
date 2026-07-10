# PF-016 - Add Plugin and Profile Interfaces for Future Commercial Packaging

## Objective

Define extension points for scanner plugins, policy profiles, report branding, and output formats without implementing full commercial multi-tenancy.

## Context

Phase 2 should allow a reusable LandmarkSignal offering without rebuilding the core. The first step is clean interfaces, not customer management.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `docs/repo-boundaries.md`
- `ISSUES_ORDER.md`

## Requirements

- Define scanner plugin interface.
- Define policy profile interface.
- Define report branding interface.
- Define output writer interface.
- Document what remains out of scope for Phase 1.

## Implementation Steps

1. Document interface contracts.
2. Refactor core code only as needed to support profiles and adapters.
3. Add example generic and CCT profiles.
4. Add tests for interface loading.
5. Update architecture docs.

## Files Likely Affected

- Architecture docs
- Core interface code
- Profile files
- Tests

## Acceptance Criteria

- [ ] Interfaces are documented.
- [ ] CCT can be added as a profile without core hard-coding.
- [ ] Report branding can vary by profile.
- [ ] Future commercial features are listed as deferred.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not add customer data handling before isolation requirements are defined.
- Do not add licensing or billing stubs that affect core scanning behavior.

## Out of Scope

- Multi-tenant hosted service.
- Customer billing and license enforcement.
- Marketplace packaging.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
