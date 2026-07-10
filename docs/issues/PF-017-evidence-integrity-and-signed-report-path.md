# PF-017 - Add Evidence Integrity Hardening and Signed Report Path

## Objective

Add integrity verification tooling, mismatch detection, and a clear path to signed manifests or signed reports after foundational raw-evidence hashing exists.

## Context

CCT-grade assessments need evidence integrity. `PF-001` owns initial SHA-256 hashes for raw scanner outputs and records those hashes in `manifest.json`. This issue builds on that foundation by adding verification, mismatch detection, hashes for later artifacts, and a future signing path.

## Source of Truth

- `PROJECT_PACKAGE.md`
- `docs/architecture.md`
- `ISSUES_ORDER.md`

## Dependencies

- Builds on `PF-001`, which owns initial raw scanner output SHA-256 hashing in `manifest.json`.

## Requirements

- Add hash verification tooling for manifest-listed evidence.
- Detect hash mismatches and missing manifest-listed files.
- Extend integrity coverage to normalized outputs, reports, SBOMs, and later artifacts.
- Add or update manifest verification behavior.
- Add verification command or script.
- Design, but do not necessarily implement, signed manifest or signed report support.
- Document key-management and timestamping limitations.

## Implementation Steps

1. Read the `PF-001` manifest and raw-evidence hashing behavior.
2. Add verification command or script.
3. Add hash mismatch and missing-file detection.
4. Extend artifact hashing to normalized outputs, reports, SBOMs, and later artifacts.
5. Add tests for hash mismatch detection and manifest verification.
6. Document future signing path, key-management limits, and timestamping limits.

## Files Likely Affected

- Manifest code
- Evidence storage code
- Verification tooling
- Tests
- README

## Acceptance Criteria

- [ ] Verification detects changed raw evidence files already hashed by `PF-001`.
- [ ] Verification detects missing manifest-listed files.
- [ ] Normalized outputs, reports, SBOMs, and later artifacts can be hashed and verified.
- [ ] Manifest verification behavior is documented.
- [ ] Reports reference manifest and evidence hashes.
- [ ] Signed manifest or signed report path is documented.
- [ ] Key-management and timestamping limitations are documented.

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
- Initial raw scanner output SHA-256 hashing in `manifest.json`; that belongs to `PF-001`.

## Completion Checklist

- [ ] Requirements implemented.
- [ ] Acceptance criteria met.
- [ ] Tests or verification commands run.
- [ ] Documentation updated if needed.
- [ ] No unrelated changes included.
- [ ] No sensitive or generated artifacts committed.

## Expected Agent Output

Return summary, files changed, tests run, test results, known limitations, commit hash if applicable, and pull request link if applicable.
