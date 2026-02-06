# Security Toolbox

Security Toolbox is a portable, read-only security scanning toolkit. It runs scans and writes evidence
outside target repositories to avoid contaminating source trees with artifacts.

## Philosophy
- Scanning only: no auto-fixes.
- Evidence lives in `~/SecurityScans/<repo_name>/<timestamp>/` with a `latest` symlink.
- Outputs never default to the target repository.

## Quickstart
1. Install dependencies and skills:
   - `./bootstrap/mac_install.sh`
2. Load the Codex alias:
   - `source ~/.zshrc`
3. In a target repo, install the scan script:
   - `<path-to-security-toolbox>/scripts/repo/install_into_repo.sh`
4. Run the scan:
   - `./scripts/security_scan.sh`
5. Generate the master report:
   - `cx run security-pipeline`

Reports and evidence are written to:
`~/SecurityScans/<repo_name>/latest/SECURITY_MASTER_REPORT.md`

## Environment Variables
- `SECURITY_OUT_DIR`: Override the base output directory (defaults to `~/SecurityScans/<repo_name>` or `~/SecurityScans/network/<target>`).
- `SECURITY_TOOLBOX_DIR`: Explicit path to this repo root for `install_into_repo.sh`.

## Troubleshooting
- **codex not found**: Ensure Node.js + npm are installed, then run `npm i -g @openai/codex@latest`. Alternatively, use `brew install --cask codex`.
- **semgrep registry access / CA issues**: Ensure your network permits access to the Semgrep registry and that your CA certificates are up to date.
- **npm audit registry access**: Ensure your npm registry is reachable and configured.
- **trivy DB updates**: The first run may download the vulnerability DB; ensure network access is available.
