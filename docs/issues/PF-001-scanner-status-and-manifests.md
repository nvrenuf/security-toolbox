# PF-001 - Implement Scanner Status and Scan Manifests

## Objective

Make scanner execution trustworthy by recording explicit scanner status, exit codes, versions, commands, timestamps, and output paths in a machine-readable manifest.

## Context

The current Bash scan script swallows most scanner failures with `|| true`. A clean result, a failed scanner, a missing scanner, and a skipped scanner can look similar to a reviewer. The platform needs a deterministic record of what ran and what happened.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Define scanner states: `success_clean`, `success_findings`, `failure`, `unavailable`, `skipped`, and `not_applicable`.
- Emit `manifest.json` for every scan.
- Record scanner name, version, command, start time, end time, duration, exit code, status, raw output path, and error summary.
- Preserve raw outputs outside the target repository.
- Return a process exit code that distinguishes scanner health failure from policy failure when policy exists.

## Implementation Steps

1. Choose the smallest implementation path that supports tests.
2. Add a manifest writer.
3. Wrap current Gitleaks, `npm audit`, Semgrep, and Trivy calls with status capture.
4. Keep existing raw output files for compatibility.
5. Add tests for missing tool, failed command, skipped scanner, and successful scanner cases.

## Files Likely Affected

- `scripts/repo/scripts/security_scan.sh`
- New test files
- `README.md`

## Acceptance Criteria

- [ ] Every scan writes `manifest.json`.
- [ ] Scanner failures are not hidden as successful scans.
- [ ] Missing tools are recorded as `unavailable`.
- [ ] `npm audit` without `package.json` is recorded as `not_applicable`.
- [ ] Raw text outputs still exist for current users.

## Tests / Verification Commands

```bash
bash -n scripts/repo/scripts/security_scan.sh
./scripts/repo/scripts/security_scan.sh
test -f "$HOME/SecurityScans/security-toolbox/latest/manifest.json"
```

## Safety / Security Constraints

- Do not commit generated scan evidence.
- Redact secret values in any displayed output.
- Do not change target repositories except where the installer already explicitly does so.

## Out of Scope

- Normalized finding schema.
- SARIF output.
- New scanner coverage.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
