# PF-004 - Add Network Scanning Authorization and Scope Guardrails

## Objective

Prevent unsafe network scanning by requiring explicit authorization, bounded scope, timeouts, rate limits, and input validation.

## Context

The current network scanner accepts one hostname, IP, or CIDR and runs Nmap with minimal validation. Network scanning has different legal and operational risk than repository scanning.

This issue is in the parallel/deferred network track. It is not required for the repository assessment MVP and must not delay normalized findings, deterministic reports, CI integration, or CCT policy work.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/repo-boundaries.md`
- `ISSUES_ORDER.md`

## Dependencies

- Blocked by the network-scanning ownership decision.
- No feature expansion should occur before authorization and scope guardrails are complete.

## Requirements

- Require an explicit authorization flag or authorization file.
- Validate target type and reject invalid input.
- Add CIDR-size limits.
- Add scan timeout and rate controls.
- Record authorization and scope in the network scan manifest.
- Clearly mark network scanning as guarded and non-default.
- Determine whether network scanning remains in this repository as a separately bounded subsystem, moves to another repository, or is deprecated.

## Implementation Steps

1. Record the network-scanning ownership decision.
2. Add input validation.
3. Add required authorization acknowledgement.
4. Add timeout and CIDR-size controls.
5. Update network pipeline docs and tests.

## Files Likely Affected

- `scripts/network/network_scan.sh`
- `skills/network-pipeline/SKILL.md`
- `skills/network-pipeline/README.md`
- New tests

## Acceptance Criteria

- [ ] Network scans refuse to run without explicit authorization.
- [ ] Oversized CIDR ranges are rejected.
- [ ] Invalid targets are rejected.
- [ ] Timeouts are enforced.
- [ ] Documentation states authorization requirements.
- [ ] The ownership decision is recorded before feature expansion.
- [ ] Docs state PF-004 is not part of the repository assessment MVP critical path.

## Tests / Verification Commands

```bash
bash -n scripts/network/network_scan.sh
./scripts/network/network_scan.sh 10.0.0.0/8
```

The second command should fail safely unless an approved guardrail path is provided.

## Safety / Security Constraints

- Do not run real external scans during development or CI.
- Use local or reserved documentation addresses for examples.

## Out of Scope

- Vulnerability exploitation.
- Authenticated network scanning.
- Production scanning scheduler.
- Repository assessment normalized findings, reports, CI, and CCT policy work.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
