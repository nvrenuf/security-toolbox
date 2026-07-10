# PF-005 - Define Normalized Finding Schema and JSON Output

## Objective

Define the official normalized finding schema and emit JSON findings as the source for policy and reports.

## Context

Current reports depend on unstructured scanner text. The platform needs deterministic findings that can be tested, deduplicated, suppressed, compared, and exported.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Define required finding fields.
- Include scanner identity, rule ID, severity, confidence, location, evidence reference, remediation, fingerprint, and raw source reference.
- Define valid severity and status values.
- Emit `findings.json` for every scan.
- Version the schema.

## Implementation Steps

1. Draft schema documentation.
2. Add a JSON schema file if the chosen runtime supports validation.
3. Add sample findings from current scanners.
4. Add schema validation tests.
5. Update report requirements to use normalized findings.

## Files Likely Affected

- New `docs/schemas/`
- New normalized output code
- New tests
- `README.md`

## Acceptance Criteria

- [ ] `findings.json` is schema-versioned.
- [ ] Findings have deterministic fingerprints.
- [ ] Scanner raw evidence paths are referenced without copying raw output into findings.
- [ ] Severity values are consistent across scanners.
- [ ] Invalid findings fail validation.

## Tests / Verification Commands

```bash
# Replace with selected runtime command.
find docs -name '*schema*' -type f
```

## Safety / Security Constraints

- Do not store full secrets in finding bodies.
- Store redacted evidence and references to raw evidence.

## Out of Scope

- Full parser coverage for all future scanners.
- SARIF export.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
