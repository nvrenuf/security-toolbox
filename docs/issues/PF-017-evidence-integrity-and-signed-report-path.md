# PF-017 - Add Evidence Integrity Hardening and Signed Report Path

## Objective

Add evidence integrity controls with hashes now and a clear path to signed manifests or signed reports later.

## Context

CCT-grade assessments need evidence integrity. Reports should point to raw and normalized evidence with hashes so reviewers can detect accidental changes.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Requirements

- Hash raw outputs, normalized outputs, reports, and SBOM files.
- Include hashes in the scan manifest.
- Add verification command or script.
- Design, but do not necessarily implement, signed report support.
- Document limitations of unsigned evidence.

## Implementation Steps

1. Add hashing strategy.
2. Add manifest fields for hashes.
3. Add verification command.
4. Add tests for hash mismatch detection.
5. Document future signing path.

## Files Likely Affected

- Manifest code
- Evidence storage code
- Tests
- README

## Acceptance Criteria

- [ ] Manifest includes hashes for generated artifacts.
- [ ] Verification detects changed artifacts.
- [ ] Reports reference manifest and evidence hashes.
- [ ] Signing path is documented.

## Tests / Verification Commands

```bash
git diff --check
```

## Safety / Security Constraints

- Do not include secret material in signing examples.
- Do not imply unsigned evidence is tamper-proof.

## Out of Scope

- Production key management.
- Third-party timestamp authority integration.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
