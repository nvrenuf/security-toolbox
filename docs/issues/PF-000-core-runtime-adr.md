# PF-000 - Select Core Engine Runtime and Record Architecture Decision

## Objective

Select the core engine runtime before implementation begins and record the decision in an architecture decision record, or ADR. An ADR is a short document that records an important technical choice, the alternatives considered, and the consequences for future work.

## Context

The current repository is mostly Bash. Bash is useful for launch wrappers and compatibility scripts, but the planned platform needs parser tests, normalized JSON, schema validation, policy evaluation, cross-platform behavior, and deterministic reporting. Those needs point toward a general-purpose language for the core engine.

Python is the recommended core runtime unless repository evidence strongly contradicts it. Python fits the expected work because it has mature testing tools, strong JSON and filesystem support, broad security-tool ecosystem compatibility, and practical cross-platform packaging options. Go is a strong alternative for single-binary distribution, but it adds more upfront migration cost. Continuing with Bash would preserve the current scaffold, but it is a poor fit for parser-heavy normalized findings, policy logic, and cross-platform tests.

Bash should remain only as thin compatibility, installation, or launch wrappers.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Dependencies

- None. This issue blocks implementation issues that depend on runtime, packaging, or test framework decisions.

## Requirements

- Compare Python, Go, and continuing with Bash.
- Recommend Python for the core engine unless repository evidence strongly contradicts that choice.
- State that Bash remains only for thin compatibility, installation, or launch wrappers.
- Add an ADR that records:
  - selected runtime
  - rejected alternatives
  - packaging approach
  - test framework
  - supported operating systems
  - migration strategy from current Bash scripts
- Update issue drafts that depend on the runtime decision so they consume the ADR instead of reopening the runtime question.

## Implementation Steps

1. Inspect the current scripts and docs for runtime constraints.
2. Create an ADR under `docs/adr/`.
3. Compare Python, Go, and Bash in the ADR.
4. Record the selected runtime, packaging approach, test framework, supported operating systems, and migration strategy.
5. Update `PROJECT_PACKAGE.md`, `docs/architecture.md`, and dependent issue drafts to point to the ADR.

## Files Likely Affected

- `docs/adr/`
- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`
- Relevant issue drafts under `docs/issues/`

## Acceptance Criteria

- [ ] An ADR exists for the core engine runtime decision.
- [ ] The ADR compares Python, Go, and Bash.
- [ ] The ADR recommends or selects Python unless repository evidence strongly contradicts it.
- [ ] Bash is limited to thin wrappers, installation, or launch compatibility.
- [ ] Packaging approach, test framework, supported operating systems, and migration strategy are recorded.
- [ ] PF-003, PF-001, and PF-002 clearly depend on the ADR.

## Tests / Verification Commands

```bash
git diff --check
test -f docs/adr/0001-core-engine-runtime.md
grep -R "PF-000" PROJECT_PACKAGE.md ISSUES_ORDER.md docs/issues
```

## Safety / Security Constraints

- Do not implement platform functionality in this issue.
- Do not remove the existing Bash scripts.
- Do not add generated scan evidence or reports.

## Out of Scope

- Migrating scanner execution to the selected runtime.
- Adding scanner adapters.
- Adding normalized findings.
- Adding CI gates.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
