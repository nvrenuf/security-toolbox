# PF-009 - Add Ecosystem Detection and Native Dependency Scanner Plan

## Objective

Add ecosystem detection and a staged plan for native dependency scanning across Node.js, Python, Go, Java, .NET, Rust, Ruby, and PHP.

## Context

Current dependency scanning is primarily `npm audit` when `package.json` exists. A CCT-grade platform needs language-aware coverage.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Detect ecosystems from lockfiles and project files.
- Record not-applicable scanners in the manifest.
- Add native scanner selection for initial ecosystems.
- Define fallback behavior when native tools are unavailable.
- Add fixtures for ecosystem detection.

## Implementation Steps

1. Define detection rules.
2. Add detector implementation and tests.
3. Select initial scanners per ecosystem.
4. Add manifest output for detected ecosystems.
5. Document unsupported or deferred ecosystems.

## Files Likely Affected

- New detection code
- New tests and fixtures
- README
- Architecture docs if scanner choices change

## Acceptance Criteria

- [ ] Node.js, Python, Go, Java, .NET, Rust, Ruby, and PHP detection rules are documented.
- [ ] Detection tests exist.
- [ ] Not-applicable scanner states are recorded.
- [ ] Scanner selection is configurable.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not execute untrusted project code during detection.
- Do not require package installation to detect ecosystems.

## Out of Scope

- Full adapter implementation for every ecosystem.
- SBOM generation.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
