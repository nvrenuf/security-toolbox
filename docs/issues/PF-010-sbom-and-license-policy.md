# PF-010 - Add SBOM Generation and License Policy Checks

## Objective

Generate SBOM artifacts and evaluate license or prohibited-package policy.

## Context

The target platform requires SBOM generation using CycloneDX or SPDX and license-policy analysis. The priority format is still open.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Decide initial SBOM format: CycloneDX, SPDX, or both.
- Generate SBOM artifacts into the evidence directory.
- Add SBOM paths and hashes to the manifest.
- Add license finding normalization.
- Add configurable prohibited-license and prohibited-package rules.

## Implementation Steps

1. Confirm initial SBOM format.
2. Select SBOM tool or tools.
3. Add generation workflow.
4. Add license policy model.
5. Add tests for allowed and prohibited licenses.

## Files Likely Affected

- New SBOM integration code
- Policy configuration files
- Tests
- README

## Acceptance Criteria

- [ ] SBOM artifact is generated for supported repositories.
- [ ] SBOM artifact is listed and hashed in the manifest.
- [ ] License policy findings are normalized.
- [ ] Prohibited package checks are configurable.
- [ ] Unsupported ecosystems are reported clearly.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not publish SBOM artifacts outside the configured evidence store by default.
- Treat dependency names and versions as potentially sensitive in customer contexts.

## Out of Scope

- Commercial customer policy UI.
- Central SBOM inventory service.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
