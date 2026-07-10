# Architecture

## Purpose

This document describes the planned architecture for Security Toolbox as it grows from a local scanner scaffold into a CCT-grade repository security assessment platform.

## Architecture Summary

The platform should run scanners through a generic core engine, convert raw scanner outputs into normalized findings, evaluate policy, preserve evidence outside target repositories, and generate deterministic reports. CCT-specific policy and branding belong in a profile or workspace, not in the core engine. `PF-000` must select the runtime and record the ADR before implementation begins; Python is the recommended runtime unless repository evidence strongly contradicts it.

## Major Components

| Component | Responsibility | Notes |
| --- | --- | --- |
| Target repository | The repository being assessed. | Must not receive generated evidence or reports by default. |
| Scanner orchestration | Detects applicable scanners, runs them, records status, and manages timeouts. | Must distinguish failure, unavailable, skipped, not applicable, clean, and findings found. |
| Scanner adapters | Translate each tool's output into normalized findings. | Each adapter should own parsing, version capture, and malformed-output handling. |
| Normalized findings | Official machine-readable finding records. | JSON is the primary source for policy and reports; SARIF is emitted where useful. |
| Policy evaluation | Applies severity, organization, license, suppression, exception, and regression rules. | CCT policy should live in a profile. |
| Evidence storage | Stores raw outputs, normalized outputs, manifests, hashes, and reports outside target repos. | Default remains under `~/SecurityScans`. |
| Report generation | Produces technical and executive reports from normalized data. | Deterministic reports are official. AI narrative is optional enrichment. |
| Report branding | Applies profile-specific naming, wording, and templates. | CCT and future LandmarkSignal branding must be separate from core logic. |
| CI integration | Provides GitHub Actions, exit codes, annotations, and code-scanning upload. | CI gates must be configurable. |
| Network scanning | Runs separately bounded network checks if retained. | Not required for the repository assessment MVP and must not block normalized findings, reports, CI, or CCT policy work. |

## Data Flow / Workflow

1. Load workspace and policy configuration.
2. Detect target repository language ecosystems and applicable scanners.
3. Create an evidence directory outside the target repository.
4. Run scanner adapters with explicit timeouts and status capture.
5. Store raw outputs and record SHA-256 hashes for them in the scan manifest.
6. Normalize scanner outputs into JSON findings.
7. Evaluate findings against policy, suppressions, exceptions, baselines, and regressions.
8. Write a scan manifest and machine-readable outputs.
9. Generate technical and executive reports from normalized data.
10. Return an exit code that represents scanner health and policy result.

## Configuration Model

Configuration should be layered:

1. Core defaults.
2. Workspace profile such as `cct`.
3. Repository-local optional config when allowed.
4. CI or command-line overrides.

The core engine must not hard-code CCT rules. Profiles should define policy thresholds, enabled scanners, report branding, allowed suppressions, and output formats.

## Storage / Persistence Model

Default evidence storage remains outside target repositories:

```text
~/SecurityScans/<repo>/<timestamp>/
  manifest.json
  raw/
  normalized/
  reports/
```

The exact layout can evolve, but the manifest must identify all raw scanner outputs, SHA-256 hashes, scanner versions, commands, timestamps, and statuses. `PF-001` owns foundational raw-evidence hashing in `manifest.json`. `PF-017` owns later verification tooling, mismatch detection, hashes for normalized outputs and reports, and the future signed-manifest or signed-report path.

## Integration Points

| Integration | Direction | Purpose | Constraints |
| --- | --- | --- | --- |
| Gitleaks | outbound process | Secret scanning. | Output should be parsed from JSON when available. |
| Semgrep | outbound process | SAST. | Rules and versions should be pinned. |
| Trivy | outbound process | Vulnerability, IaC, container, and secret scanning. | Severity handling must be consistent across scan and report stages. |
| Ecosystem package managers | outbound process | Native dependency scanning. | Support Node.js, Python, Go, Java, .NET, Rust, Ruby, and PHP over time. |
| SBOM tools | outbound process | CycloneDX or SPDX output. | SBOM artifacts must be tracked in the manifest. |
| GitHub API | outbound API | Repository security-control assessment. | Requires scoped credentials and redacted logging. |
| GitHub Actions | inbound runtime | CI execution, annotations, and SARIF upload. | Gate policy must be configurable. |

## Security and Safety Model

- Preserve generated evidence outside target repositories.
- Never commit generated evidence or customer data.
- Do not claim that a repository is secure.
- Record scanner failures as assessment limitations.
- Require explicit authorization and guardrails for network scanning.
- Prefer pinned tool versions and reproducible scanner rules.
- Redact sensitive values before display, reports, and logs.

## Testing / Verification Model

The test suite should cover scanner status, missing tools, failed commands, malformed outputs, parser behavior, normalization, policy evaluation, report generation, and evidence manifests. CI should run tests and basic linting before any security gate is enforced.

## Operational Notes

Local execution should remain possible. CI execution should have deterministic paths, explicit exit codes, and machine-readable artifacts. Scheduled execution should reuse the same core engine with a different runner.

## Known Gaps

- Scanner failures are currently swallowed.
- Official outputs are unstructured text.
- There is no normalized finding schema.
- There is no scan manifest or foundational raw-evidence hashing.
- There are no automated tests or CI workflows.
- Bootstrap uses mutable upstream dependencies.
- Network scanning lacks required guardrails.

## Future Architecture Considerations

- Scanner plugin discovery.
- Customer workspace isolation.
- Report branding packages.
- License enforcement for commercial distribution.
- Central evidence storage for scheduled scans.
- Signed reports and signed manifests.
