# Repository Boundaries

## Purpose

This document defines what belongs in this repository, what belongs in CCT-specific policy, and what should wait for a future LandmarkSignal commercial offering.

## Boundary Summary

This repository should own the reusable scanning engine, adapters, normalized output model, evidence handling, policy interfaces, and report-generation framework. CCT-specific rules and branding should live in a profile or workspace. Commercial customer features should be designed for but not built in Phase 1.

## This Repository Owns

- Generic scanner orchestration.
- Scanner adapters and parser tests.
- Normalized finding schema and machine-readable outputs.
- Evidence manifests, evidence hashing, and report generation.
- Policy evaluation framework.
- CI integration patterns.
- Safe network scanner guardrail framework if network scanning remains here.
- Documentation and issue specs for the platform roadmap.

## This Repository Does Not Own

- Customer billing.
- Hosted multi-tenant portal behavior.
- LandmarkSignal sales, licensing, or customer administration.
- CCT-only policy embedded in core code.
- Generated scan evidence from target repositories.
- Generated reports from target repositories.
- Unapproved active network testing against external targets.

## Related Repositories / Overlays

| Name | Purpose | Relationship | Promotion / Sync Rule |
| --- | --- | --- | --- |
| `cct` profile or workspace | CCT-specific policy, thresholds, report wording, and evidence pack requirements. | Consumes the shared core engine. | Generic improvements may move into core; CCT-specific rules stay in the profile. |
| Future LandmarkSignal offering | Commercial packaging, customer profiles, branding, isolation, licensing, and distribution. | Future product layer over the same core ideas. | Do not add commercial-only assumptions to Phase 1 core code. |

## Shared Core Rules

- Shared core code should remain generic and reusable.
- Environment-specific assumptions should not be hard-coded into shared core code.
- Distribution-specific behavior should not leak across repositories or overlays unless intentionally promoted.
- Project-specific shortcuts should not pollute reusable shared code.

## Data and Secrets Rules

- Do not commit secrets, credentials, tokens, cookies, HAR files, customer data, generated evidence, generated reports, or local workspace artifacts.
- Keep examples generic unless the project package explicitly allows project-specific examples.
- Redact sensitive values in docs, logs, reports, summaries, and issue drafts.

## Promotion Rules

- Start new behavior in the smallest layer that needs it.
- Promote reusable behavior from a profile into core only when it is policy-neutral.
- Keep report branding configurable.
- Keep policy thresholds configurable.
- Keep scanner adapters independent from report wording.

## Open Boundary Questions

| Priority | Question | Why It Matters | Status |
| --- | --- | --- | --- |
| High | Should the first engine implementation remain shell-based or move to a general-purpose language? | This controls packaging, test structure, and adapter design. | Open |
| High | Should network scanning remain part of the repository assessment platform? | Network scanning has different authorization and safety boundaries. | Open |
| Medium | Where should future CCT profile files live in the tree? | The location affects how clearly the core and CCT policy stay separated. | Open |
