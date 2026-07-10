# PF-011 - Expand IaC, Container, Dockerfile, and Kubernetes Coverage

## Objective

Expand scanner coverage for infrastructure-as-code, containers, Dockerfiles, and Kubernetes manifests.

## Context

The current Trivy filesystem scan includes misconfiguration scanning, but the platform needs explicit coverage, status, and reporting for infrastructure and deployment artifacts.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Detect Terraform, CloudFormation, Kubernetes, Dockerfile, and container config where practical.
- Configure scanners for IaC and container-related files.
- Normalize findings into the shared schema.
- Document limitations for image scanning versus file scanning.
- Add fixtures for at least Dockerfile and Kubernetes manifest findings.

## Implementation Steps

1. Define supported artifact detection.
2. Configure scanner commands.
3. Add or update adapters.
4. Add tests and fixtures.
5. Update reports to include coverage status.

## Files Likely Affected

- Scanner orchestration
- Scanner adapters
- Tests and fixtures
- README

## Acceptance Criteria

- [ ] IaC and container file detection exists.
- [ ] Findings normalize into `findings.json`.
- [ ] Reports distinguish scanned, skipped, and not-applicable artifact types.
- [ ] Tests cover at least two artifact types.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not pull or scan remote container images by default.
- Do not require cloud credentials for local file scanning.

## Out of Scope

- Authenticated cloud posture management.
- Runtime cluster scanning.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
