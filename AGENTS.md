# AI Agent Instructions

This repository uses Project Forge for durable planning, checkpointing, and implementation-ready issues.

## Required Reading Order

Before planning, reviewing, or editing this repository, read:

1. `PROJECT_PACKAGE.md`
2. `AGENTS.md`
3. `ISSUES_ORDER.md`
4. The relevant issue draft under `docs/issues/`
5. `docs/architecture.md` and `docs/repo-boundaries.md` when work touches architecture, security claims, policy, or output behavior

## Source of Truth

`PROJECT_PACKAGE.md` is repo-synced planning state. The repository remains the current implementation source until the package is reviewed and marked `User-Confirmed` or `Authoritative`.

If repository behavior and planning docs disagree, stop and report the mismatch before implementing.

## Work Discipline

- Work one issue at a time.
- Keep changes scoped to the selected issue.
- Preserve useful existing behavior unless the selected issue explicitly changes it.
- Add or update tests with behavior changes.
- Run the issue's validation commands, or explain why they could not be run.
- Do not implement blocked, deferred, or commercial Phase 2 work unless explicitly instructed.

## Architecture Rules

- Keep the core scanning engine generic.
- Keep CCT-specific requirements in a `cct` workspace or policy profile.
- Do not hard-code CCT policy, CCT branding, or LandmarkSignal commercial assumptions into the core engine.
- Separate scanner orchestration, scanner adapters, normalized findings, policy evaluation, evidence storage, report generation, and report branding.
- Use deterministic logic for official findings and reports.
- Treat AI-generated narrative as optional enrichment only.

## Safety and Data Handling

- Do not commit secrets, credentials, tokens, cookies, HAR files, customer data, generated evidence, generated reports, or local workspace artifacts.
- Do not print or store full secret values.
- Redact sensitive values in examples, logs, summaries, reports, and issue drafts.
- Do not enable active, intrusive, destructive, or production-impacting behavior by default.
- Require explicit authorization and operator approval for authenticated testing, destructive testing, external scans, production changes, or scope changes.
- Network scanning must require authorization, scope, timeout, rate, input-validation, and CIDR-size guardrails before it is treated as supported.

## Reporting Claims

Reports may describe enabled scanner results, scope, limitations, status, and confidence. Reports must not claim a repository is secure, risk-free, or completely assessed.

## Branch and Pull Request Rules

- Never write directly to the default branch.
- Use a feature branch for changes.
- Open a pull request for review when changes are ready.
- Do not merge without explicit user approval.

## Expected Output After Work

Return:

- summary
- files changed
- tests run
- test results
- known limitations
- commit hash if applicable
- pull request link if applicable
