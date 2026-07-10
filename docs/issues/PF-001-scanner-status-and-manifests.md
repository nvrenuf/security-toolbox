# PF-001 - Implement Scanner Status and Scan Manifests

## Objective

Make scanner execution trustworthy by recording explicit scanner status, exit codes, versions, commands, timestamps, and output paths in a machine-readable manifest.

## Context

The current Bash scan script swallows most scanner failures with `|| true`. A clean result, a failed scanner, a missing scanner, and a skipped scanner can look similar to a reviewer. The platform needs a deterministic record of what ran and what happened.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`
- ADR created by `PF-000`

## Dependencies

- Blocked by `PF-000` so the core runtime and packaging approach are recorded first.
- Blocked by `PF-003` so scanner status and manifest behavior can be covered by tests before implementation.

## Requirements

- Define scanner states: `success_clean`, `success_findings`, `failure`, `unavailable`, `skipped`, and `not_applicable`.
- Emit `manifest.json` for every scan.
- Record scanner name, version, command, start time, end time, duration, exit code, status, raw output path, and error summary.
- Record deterministic relative or canonical evidence paths for raw outputs.
- Generate SHA-256 hashes for every raw scanner output written during the scan.
- Record raw output SHA-256 hashes directly in `manifest.json`.
- Clearly record when an expected output file is missing.
- Preserve raw outputs outside the target repository.
- Return a process exit code that distinguishes scanner health failure from policy failure when policy exists.

## Implementation Steps

1. Read the `PF-000` ADR and use the selected core runtime.
2. Add or update tests from `PF-003` for scanner states, manifest fields, raw output hashing, and missing expected outputs.
3. Add a manifest writer.
4. Wrap current Gitleaks, `npm audit`, Semgrep, and Trivy calls with status capture.
5. Keep existing raw output files for compatibility.
6. Add SHA-256 hashing for raw scanner outputs and record hashes in `manifest.json`.

## Files Likely Affected

- `scripts/repo/scripts/security_scan.sh`
- New test files
- `README.md`

## Acceptance Criteria

- [ ] Every scan writes `manifest.json`.
- [ ] Scanner failures are not hidden as successful scans.
- [ ] Missing tools are recorded as `unavailable`.
- [ ] `npm audit` without `package.json` is recorded as `not_applicable`.
- [ ] Every raw scanner output written during the scan has a SHA-256 hash in `manifest.json`.
- [ ] Raw scanner output paths in `manifest.json` are deterministic relative paths or canonical paths.
- [ ] Missing expected output files are recorded clearly.
- [ ] Tests prove raw evidence hashes are generated and recorded.
- [ ] Raw text outputs still exist for current users.

## Tests / Verification Commands

```bash
bash -n scripts/repo/scripts/security_scan.sh
./scripts/repo/scripts/security_scan.sh
test -f "$HOME/SecurityScans/security-toolbox/latest/manifest.json"
grep -q "sha256" "$HOME/SecurityScans/security-toolbox/latest/manifest.json"
```

## Safety / Security Constraints

- Do not commit generated scan evidence.
- Redact secret values in any displayed output.
- Do not change target repositories except where the installer already explicitly does so.

## Out of Scope

- Normalized finding schema.
- SARIF output.
- New scanner coverage.
- Hash verification tooling, mismatch detection, and signing hardening. Those belong to `PF-017`.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
