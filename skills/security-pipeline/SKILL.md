# Security Pipeline Skill

Version: 0.1.0

## Purpose
Run the repository security scan and generate a deterministic master report outside the repo.

## Rules
- Always run `./scripts/security_scan.sh` from the target repository root.
- If `./scripts/security_scan.sh` is missing, instruct the user to run `scripts/repo/install_into_repo.sh` from the security-toolbox repo.
- Never write report files inside the target repository.
- Always write `SECURITY_MASTER_REPORT.md` into `~/SecurityScans/<repo_name>/latest/`.
- Read scan outputs from `~/SecurityScans/<repo_name>/latest/`.
- Include skill and script versions in the report.
- Enrich findings with guidance from `security-best-practices` if available.

## Workflow
1. Run the scan:
   - `bash ./scripts/security_scan.sh`
2. Determine `repo_name`:
   - Use `git remote get-url origin` if available; otherwise use the current directory name.
3. Read outputs from:
   - `~/SecurityScans/<repo_name>/latest/`
4. Generate the report:
   - Write `~/SecurityScans/<repo_name>/latest/SECURITY_MASTER_REPORT.md`

## Report Requirements
Include the following sections:
- Scan timestamp
- Repo name
- Tool-by-tool status (gitleaks, npm audit, semgrep, trivy)
- Findings grouped by severity: Critical, High, Medium, Low
- Top remediation order (top 5)
- Evidence paths (full paths to output files)
- Versions used (skill version + `scripts/repo/security_scan.sh` version)
- Best-practices guidance when available

