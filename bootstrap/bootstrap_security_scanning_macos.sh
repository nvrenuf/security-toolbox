#!/usr/bin/env bash
set -euo pipefail

echo "[*] macOS security scanning + Codex bootstrap"

# --- 0) Homebrew ---
if ! command -v brew >/dev/null 2>&1; then
  echo "[!] Homebrew not found. Install it first: https://brew.sh"
  exit 1
fi

# --- 1) Baseline tools ---
echo "[*] Installing tools via brew (git, gitleaks, semgrep, trivy)"
brew install git gitleaks semgrep trivy || true

# --- 2) Codex CLI (codex) ---
# Official install options: npm i -g @openai/codex OR brew install --cask codex
# We'll prefer npm if available; fall back to brew cask.
echo "[*] Installing Codex CLI"
if command -v npm >/dev/null 2>&1; then
  npm i -g @openai/codex@latest
elif brew list --cask codex >/dev/null 2>&1; then
  echo "[*] Codex cask already installed"
else
  brew install --cask codex
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "[!] codex not found on PATH after install."
  echo "    Try: npm i -g @openai/codex@latest   (recommended)"
  echo "    Or:  brew install --cask codex"
  exit 1
fi

# --- 3) Create base dirs ---
mkdir -p ~/.agents/skills
mkdir -p ~/SecurityScans
mkdir -p ~/Projects

# --- 4) Pull OpenAI skills repo (optional but recommended) ---
skills_root="${HOME}/Projects/openai-skills"
if [ ! -d "${skills_root}/.git" ]; then
  echo "[*] Cloning openai/skills into ${skills_root}"
  git clone https://github.com/openai/skills.git "${skills_root}"
else
  echo "[*] Updating openai/skills in ${skills_root}"
  git -C "${skills_root}" pull --ff-only || true
fi

# Copy curated security skills (best-effort; fine if already present)
echo "[*] Copying curated security skills into ~/.agents/skills"
cp -R "${skills_root}/skills/.curated/security-best-practices" "${HOME}/.agents/skills/" 2>/dev/null || true
cp -R "${skills_root}/skills/.curated/security-threat-model"  "${HOME}/.agents/skills/" 2>/dev/null || true
cp -R "${skills_root}/skills/.curated/security-ownership-map" "${HOME}/.agents/skills/" 2>/dev/null || true

# --- 5) Install YOUR security-pipeline skill (deterministic report creation) ---
echo "[*] Installing global skill: security-pipeline"
mkdir -p "${HOME}/.agents/skills/security-pipeline"

cat > "${HOME}/.agents/skills/security-pipeline/SKILL.md" <<'SKILL'
---
name: security-pipeline
description: Runs a repeatable security scan pipeline (gitleaks, npm audit, semgrep, trivy) for the current repository and writes SECURITY_MASTER_REPORT.md next to scan outputs under ~/SecurityScans/<repo_name>/latest/.
version: 1.0.1
---

# Skill: security-pipeline

## Determinism rule (must follow)
- If `./scripts/security_scan.sh` exists, run it and treat `~/SecurityScans/<repo_name>/latest/` as the source of truth.
- Determine PASS/FAIL strictly from tool output contents (not exit codes).
- Always write the master report to the scan output folder (never to the repo).

## Procedure
1. Confirm repo root.
2. Run `bash ./scripts/security_scan.sh` if present; otherwise instruct user to add it.
3. Read outputs from `~/SecurityScans/<repo_name>/latest/`:
   - `GITLEAKS.txt`
   - `NPM_AUDIT.txt` (if present)
   - `SEMGREP.txt`
   - `TRIVY.txt`
4. **Generate and WRITE** `SECURITY_MASTER_REPORT.md` to:
   - `~/SecurityScans/<repo_name>/latest/SECURITY_MASTER_REPORT.md`
   - The report must include:
     - Date/time of scan (best effort from folder name or file mtimes)
     - Overall status (PASS/FAIL) + rationale
     - Findings grouped by severity (Critical/High/Medium/Low)
     - Tool-by-tool summary
     - Evidence section listing full file paths to outputs
     - Recommended remediation order (top 5)
5. Use `security-best-practices` guidance to enrich the report (web/React guidance, CSP notes, common pitfalls).
6. Print to console:
   - Final PASS/FAIL line
   - Path to written report
   - Evidence directory path
SKILL

# --- 6) Add cx alias (Codex shortcut) ---
# We’ll add to .zshrc (common on macOS). If they use bash, they can copy it to .bash_profile.
shell_rc="${HOME}/.zshrc"
alias_line='alias cx="codex"'
if [ -f "${shell_rc}" ] && grep -q 'alias cx=' "${shell_rc}"; then
  echo "[*] cx alias already present in ${shell_rc}"
else
  echo "[*] Adding cx alias to ${shell_rc}"
  printf "\n# Codex shortcut\n%s\n" "${alias_line}" >> "${shell_rc}"
fi

echo "[*] Done."
echo "Next:"
echo "  1) Restart terminal (or run: source ~/.zshrc)"
echo "  2) Verify: cx --help"
echo "  3) In any repo: add scripts/security_scan.sh"
echo "  4) Run: ./scripts/security_scan.sh"
echo "  5) Run in Codex: Run security-pipeline"
echo "  6) Report: ~/SecurityScans/<repo>/latest/SECURITY_MASTER_REPORT.md"
