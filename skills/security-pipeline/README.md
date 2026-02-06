# Security Pipeline Skill

Version: 0.1.0

This skill runs the repository security scan and writes a deterministic master report to
`~/SecurityScans/<repo_name>/latest/SECURITY_MASTER_REPORT.md`.

The report aggregates tool outputs (gitleaks, npm audit, semgrep, trivy), groups findings
by severity, and lists remediation priorities with evidence paths.
