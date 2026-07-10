# Issues Order

## Purpose

This file is the execution queue for turning Security Toolbox into a CCT-grade repository security assessment platform while preserving a future LandmarkSignal product path.

## Execution Rules

- Work top to bottom unless the user changes priority.
- Read `PROJECT_PACKAGE.md`, `AGENTS.md`, and the selected issue before implementation.
- Do not start blocked work until its blocking decision is resolved.
- Keep CCT-specific policy out of the shared core engine.
- Do not commit generated evidence or reports.

## GitHub Issue Mapping

| Project Forge ID | GitHub Issue |
| --- | --- |
| `PF-001` | #2 |
| `PF-002` | #3 |
| `PF-003` | #4 |
| `PF-004` | #5 |
| `PF-005` | #6 |
| `PF-006` | #7 |
| `PF-007` | #8 |
| `PF-008` | #9 |
| `PF-009` | #10 |
| `PF-010` | #11 |
| `PF-011` | #12 |
| `PF-012` | #13 |
| `PF-013` | #14 |
| `PF-014` | #15 |
| `PF-015` | #16 |
| `PF-016` | #17 |
| `PF-017` | #18 |
| `PF-018` | #19 |

## Milestone 1: Trustworthy Scanner Orchestration

1. `PF-001` - Implement scanner status and scan manifests.
2. `PF-002` - Add cross-platform execution and bootstrap strategy.
3. `PF-003` - Add automated test foundation and CI smoke checks.
4. `PF-004` - Add network scanning authorization and scope guardrails.

## Milestone 2: Normalized Findings and Deterministic Reporting

5. `PF-005` - Define normalized finding schema and JSON output.
6. `PF-006` - Build scanner adapters for current tools.
7. `PF-007` - Generate deterministic technical and executive reports.
8. `PF-008` - Add SARIF output and consistent severity model.

## Milestone 3: Ecosystem and IaC Coverage

9. `PF-009` - Add ecosystem detection and native dependency scanner plan.
10. `PF-010` - Add SBOM generation and license policy checks.
11. `PF-011` - Expand IaC, container, Dockerfile, and Kubernetes coverage.

## Milestone 4: GitHub and CI Integration

12. `PF-012` - Add GitHub Actions integration and CI gates.
13. `PF-013` - Add GitHub repository security-control assessment.

## Milestone 5: CCT Policy Profile and Audit Evidence

14. `PF-014` - Add CCT policy profile and audit evidence pack.
15. `PF-015` - Add suppression, exception, baseline, and regression model.

## Milestone 6: Commercial-Readiness Foundation

16. `PF-016` - Add plugin and profile interfaces for future commercial packaging.
17. `PF-017` - Add evidence integrity hardening and signed report path.
18. `PF-018` - Document product claims, limitations, and operator workflow.

## Blocked Decisions

- Runtime choice for the core engine is open and affects `PF-001` through `PF-008`.
- Initial CCT CI gate policy is open and affects `PF-012` and `PF-014`.
- SBOM format priority is open and affects `PF-010`.
- Network scanning ownership is open and affects `PF-004`.
