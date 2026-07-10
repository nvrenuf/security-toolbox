# PF-002 - Add Cross-Platform Execution and Bootstrap Strategy

## Objective

Make local and CI execution work beyond macOS while reducing mutable dependency installation risk.

## Context

The current bootstrap script is macOS-oriented and installs mutable upstream dependencies such as latest Codex and Homebrew packages. Phase 1 needs reproducible behavior on macOS, Linux, WSL, Windows where practical, containers, and CI runners.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/repo-boundaries.md`
- `ISSUES_ORDER.md`

## Requirements

- Document supported platforms and unsupported platforms.
- Pin scanner versions or provide a lockable installation strategy.
- Add a container or CI-friendly install path.
- Avoid silently continuing after failed installs.
- Keep target repository writes explicit and documented.

## Implementation Steps

1. Inventory current bootstrap behavior.
2. Add a platform support matrix.
3. Split mutable setup from pinned setup.
4. Add CI/container setup documentation.
5. Add verification commands for installed tools.

## Files Likely Affected

- `bootstrap/`
- `README.md`
- `.github/workflows/` if CI setup starts here

## Acceptance Criteria

- [ ] README states supported platforms.
- [ ] Bootstrap failures are visible.
- [ ] Tool version strategy is documented.
- [ ] CI or container setup path exists.
- [ ] Installer write behavior is documented accurately.

## Tests / Verification Commands

```bash
bash -n bootstrap/bootstrap_security_scanning_macos.sh
bash -n scripts/repo/install_into_repo.sh
```

## Safety / Security Constraints

- Do not install mutable dependencies in CI without a documented reason.
- Do not claim read-only behavior when symlinks or `.gitignore` changes occur.

## Out of Scope

- Full package manager support for every platform.
- Commercial installer.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
