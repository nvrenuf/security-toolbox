# Project Package

## Package Status

**Project:** security-toolbox  
**Package Status:** Repo-Synced  
**Current Mode:** Sync and Issue Generation  
**Current Source of Truth:** Repository, then this package after review  
**Last Updated:** 2026-07-10  
**Last Checkpoint:** CP-0001  
**Current Focus:** Define the CCT-grade repository security assessment platform and create an executable backlog.  
**Next Question:** Complete `PF-000` to select the core engine runtime and record the ADR before implementation begins.
**Blocking Questions:** Implementation cannot begin until `PF-000` is complete. Open planning decisions remain: initial CCT CI gate policy, GitHub permission scope, SBOM format priority, and network-scanning ownership.

## Source of Truth

### Current Rule

This is an existing repository. The repository is the temporary source of truth for current behavior. This package records the synchronized plan and should become the planning source of truth after review.

### Authority Chain

```text
PROJECT_PACKAGE.md
  -> AGENTS.md
  -> ISSUES_ORDER.md
  -> docs/issues/
  -> implementation
```

## Project Summary

Security Toolbox is planned as an internal repository security assessment and reporting platform for CCT. It should run multiple scanners, normalize their outputs into deterministic findings, evaluate policy, preserve evidence outside target repositories, and produce clear technical and executive reports.

The long-term direction is a reusable LandmarkSignal commercial offering. That future product path is an architecture constraint, not a Phase 1 feature. Phase 1 should not build full commercial multi-tenancy, billing, customer administration, or hosted isolation.

## Users

- CCT security reviewers who need repeatable repository assessments.
- CCT engineering leads who need practical remediation reports.
- CI maintainers who need security gates and machine-readable results.
- Future LandmarkSignal operators who may package the core engine for customer workspaces.

## Repo Reality Snapshot

### Confirmed from Repository

- The repo contains Bash scripts for local repository and network scanning.
- `scripts/repo/scripts/security_scan.sh` runs Gitleaks, `npm audit`, Semgrep `p/ci`, and Trivy filesystem scans.
- Evidence is written outside the target repo under `~/SecurityScans/<repo>/<timestamp>/`.
- A `latest` symlink points to the latest evidence directory.
- Scanner command failures are mostly swallowed with `|| true`.
- The repository scan writes unstructured text files: `GITLEAKS.txt`, `NPM_AUDIT.txt`, `SEMGREP.txt`, and `TRIVY.txt`.
- `npm audit` only runs when `package.json` exists.
- Trivy is restricted to `HIGH,CRITICAL` severity in the current script.
- The report skills describe deterministic reports, but the current workflow still depends on reading raw text outputs.
- `scripts/network/network_scan.sh` wraps Nmap with minimal target validation and no authorization guardrails.
- `bootstrap/bootstrap_security_scanning_macos.sh` is macOS-oriented and installs mutable upstream dependencies.
- There are no automated tests, no CI workflow, no package metadata, and no machine-readable normalized finding model.

### Inferred from Repository

- The current implementation is an early scaffold meant for local, manual use.
- The scripts favor convenience over reproducibility, scanner status accuracy, and CI behavior.
- The network scanner is experimental and should not be promoted until scope and authorization controls exist.

### Repo / Intent Mismatches

- The README says the toolkit is read-only, but installation creates a symlink and may modify `.gitignore`.
- The intended platform needs deterministic machine-readable outputs, but current outputs are unstructured text.
- The intended platform needs broad ecosystem coverage, but current dependency scanning is mostly Node.js plus generic Trivy filesystem scanning.
- The intended platform needs CI and GitHub controls, but the repo has no GitHub Actions workflow or repository configuration assessment.

## Product / Repo Boundaries

### In Scope

- Scanner orchestration and scanner adapters.
- Normalized findings, scan manifests, deterministic report generation, and evidence integrity.
- Policy evaluation, suppression, exception, baseline, and regression models.
- CCT policy profile and report branding kept outside the generic core.
- Local, CI, and scheduled execution modes.
- GitHub repository security-control assessment.
- Machine-readable JSON and SARIF outputs.
- Safe network-scanning guardrails before expanding network features.

### Out of Scope

- Full commercial multi-tenancy in Phase 1.
- Hosted customer portal, billing, user administration, or license enforcement in Phase 1.
- Claims that a repository is secure or risk-free.
- Intrusive, destructive, or production-impacting testing by default.
- Storing generated evidence or reports inside target repositories.

### Related Repositories, Overlays, or Deployments

- `nvrenuf/security-toolbox`: current repository and future shared core.
- Future `cct` workspace or policy profile: CCT-specific policy, branding, and reporting requirements.
- Future LandmarkSignal commercial overlay: customer-facing packaging, branding, licensing, and isolation.

## Required Security Claims

Reports may say:

- "No findings were reported by the enabled scanners for the configured scope."
- "Scanner X was unavailable, failed, skipped, or not applicable."
- "Confidence is limited by scanner coverage, configuration, ignored paths, and available credentials."

Reports must not say:

- "This repository is secure."
- "This scan proves there are no secrets, vulnerabilities, or misconfigurations."
- "All risks were found."
- "Network targets are authorized" unless authorization was explicitly recorded.

## Evidence and Reporting Requirements

- Preserve evidence outside target repositories by default.
- Emit a scan manifest that lists target, scope, start time, end time, scanner versions, commands, exit codes, output paths, hashes, and status.
- `PF-001` owns foundational SHA-256 hashing for raw scanner outputs written during the scan.
- `PF-017` owns later hash verification, mismatch detection, integrity hardening for normalized outputs and reports, and the future signing path.
- Distinguish scanner success, clean result, findings found, scanner failure, scanner unavailable, scanner skipped, and scanner not applicable.
- Emit normalized JSON findings as the official source for policy and reports.
- Emit SARIF where appropriate for code scanning and CI integrations.
- Generate technical and executive reports deterministically from normalized data.
- Treat AI-generated narrative as optional enrichment, never as the source of truth.

## Short-Term Plan

1. Complete `PF-000` to select the core engine runtime and record the ADR.
2. Add automated tests and CI smoke checks.
3. Build trustworthy scanner orchestration with explicit status handling and raw-evidence hashing.
4. Add a normalized finding schema and deterministic JSON output.
5. Replace report dependence on raw text interpretation with deterministic report generation.

## Medium-Term Plan

1. Add ecosystem-native dependency scanning for Python, Go, Java, .NET, Rust, Ruby, and PHP.
2. Add SBOM generation and license-policy checks.
3. Add GitHub Actions integration, SARIF upload, annotations, and security gates.
4. Add repository configuration assessment for GitHub controls.

## Long-Term Plan

1. Add CCT policy profile, audit evidence packs, and branded reports.
2. Add customer-workspace-ready configuration boundaries for future LandmarkSignal packaging.
3. Add plugin interfaces for scanners, policy packs, report brands, and output formats.
4. Add scheduled execution and baseline/regression comparison workflows.

## Architecture Notes

The intended architecture separates target repositories, scanner orchestration, scanner adapters, normalized findings, policy evaluation, evidence storage, report generation, and report branding. See `docs/architecture.md`.

## Security and Safety Rules

- Do not commit secrets, credentials, tokens, cookies, HAR files, customer data, generated evidence, generated reports, or local workspace artifacts.
- Do not enable active, intrusive, destructive, or production-impacting behavior by default.
- Require explicit authorization and operator approval for authenticated testing, destructive testing, external scans, production changes, or scope changes.
- Redact sensitive values in examples, logs, summaries, reports, and issue drafts.
- Network scanning must require explicit scope, authorization, timeouts, rate limits, and CIDR-size guardrails before it is treated as supported.

## Non-Goals

- Do not rewrite the whole repository before stabilizing scanner status and outputs.
- Do not hard-code CCT policy into the shared core engine.
- Do not make AI output the official finding source.
- Do not store scan evidence in target repositories.
- Do not claim complete security assurance.

## Decision Checkpoints

### CP-0001 - Establish Platform Direction

**Plain Summary:** The project will evolve from a local scanner scaffold into a CCT-grade repository security assessment platform with a reusable commercial path.  
**Date:** 2026-07-10  
**Status:** Accepted  
**Checkpoint Type:** Major Decision  
**Question or Trigger:** User requested Project Forge sync and backlog generation for `nvrenuf/security-toolbox`.  
**User Answer:** Phase 1 must serve CCT internally; Phase 2 must preserve a LandmarkSignal commercial path.  
**Assistant Recommendation:** Preserve useful scanner scripts but introduce a separated core engine, normalized findings, deterministic reporting, policy profiles, and evidence integrity.  
**Decision:** Plan the work as phased milestones instead of a full rewrite in this pass.  
**Rationale:** The current repo is useful as a scaffold, but scanner status, output, tests, CI, and reporting need foundations before broader coverage.  
**Implementation Impact:** Adds Project Forge docs, architecture boundaries, and issue drafts. Implementation should start with `PF-000`, then tests, scanner orchestration, and normalized findings.
**Affected Files/Areas:** `PROJECT_PACKAGE.md`, `AGENTS.md`, `ISSUES_ORDER.md`, `docs/architecture.md`, `docs/repo-boundaries.md`, `docs/issues/`.  
**Follow-up Issues Needed:** All issues listed in `ISSUES_ORDER.md`.  
**Supersedes:** None

## Open Questions

| Priority | Question | Why It Matters | Status |
| --- | --- | --- | --- |
| High | What is the minimum CCT policy gate for Phase 1: report-only, fail-on-critical, fail-on-policy-violation, or configurable by repo? | CI behavior and reviewer expectations depend on this. | Open |
| High | Which GitHub organization and repository permissions will the tool be allowed to inspect? | Repository control assessment may need authenticated GitHub API access. | Open |
| Medium | Which SBOM format is required first: CycloneDX, SPDX, or both? | This affects tool choice and downstream integrations. | Open |
| Medium | Should network scanning remain in this repository or move behind a separate guarded workflow? | Network scanning has different authorization and safety requirements than repository scanning. | Open |

## Issue Readiness

### Readiness Checklist

- [x] Project purpose is clear.
- [x] Current source of truth is clear.
- [x] Repo/product/user boundaries are clear.
- [x] Short-term plan exists.
- [x] Medium-term plan exists.
- [x] Long-term plan exists.
- [x] Non-goals are documented.
- [x] Security and safety constraints are documented.
- [x] Architecture direction is documented.
- [x] Open questions are prioritized.
- [x] Next issues are sequenced.
- [x] Acceptance criteria are defined.
- [x] Test or verification commands are known.

## Next Recommended Action

Start with `PF-000` in `ISSUES_ORDER.md`: select the core engine runtime and record the ADR before implementation begins.
