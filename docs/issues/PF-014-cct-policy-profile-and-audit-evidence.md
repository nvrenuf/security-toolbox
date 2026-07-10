# PF-014 - Add CCT Policy Profile and Audit Evidence Pack

## Objective

Add a CCT-specific policy profile and audit evidence pack while keeping the shared core generic.

## Context

Phase 1 must serve CCT, but commercial readiness requires CCT policy not to be hard-coded into the core engine.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/repo-boundaries.md`
- `ISSUES_ORDER.md`

## Requirements

- Add a `cct` profile or equivalent workspace.
- Define CCT severity thresholds, required checks, report wording, and evidence pack contents.
- Keep core defaults separate from CCT policy.
- Add tests proving CCT policy can be loaded without changing core behavior.
- Document how to run with the CCT profile.

## Implementation Steps

1. Decide profile directory layout.
2. Add CCT policy configuration.
3. Add CCT report branding or wording configuration.
4. Add audit evidence pack generator.
5. Add tests for profile loading.

## Files Likely Affected

- New `profiles/cct/` or equivalent
- Policy evaluation code
- Report generation code
- Tests
- README

## Acceptance Criteria

- [ ] CCT policy is outside the core engine.
- [ ] Running with CCT profile changes policy and reporting configuration.
- [ ] Audit evidence pack includes manifest, hashes, reports, and machine-readable outputs.
- [ ] Tests cover profile loading.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not include real CCT secrets, customer names, or internal evidence in examples.
- Keep examples generic unless explicitly approved.

## Out of Scope

- LandmarkSignal customer profile system.
- Hosted audit archive.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
