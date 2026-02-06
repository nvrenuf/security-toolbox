#!/usr/bin/env bash
set -euo pipefail

# Version: 0.1.0

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew is required. Install from https://brew.sh and re-run this script." >&2
  exit 1
fi

echo "Installing required tools with Homebrew..."
brew list git >/dev/null 2>&1 || brew install git
brew list gitleaks >/dev/null 2>&1 || brew install gitleaks
brew list semgrep >/dev/null 2>&1 || brew install semgrep
brew list trivy >/dev/null 2>&1 || brew install trivy

if ! command -v codex >/dev/null 2>&1; then
  if command -v npm >/dev/null 2>&1; then
    echo "Installing Codex CLI via npm..."
    npm i -g @openai/codex@latest
  else
    echo "npm not found. Trying Homebrew cask for Codex..."
    brew install --cask codex || true
  fi
fi

if ! command -v codex >/dev/null 2>&1; then
  echo "Codex CLI not found on PATH after installation attempts." >&2
  echo "Next steps: install Node.js + npm, then run: npm i -g @openai/codex@latest" >&2
  echo "Or install via Homebrew cask: brew install --cask codex" >&2
  exit 1
fi

AGENTS_DIR="$HOME/.agents/skills"
SECURITY_SCANS_DIR="$HOME/SecurityScans"
SKILLS_REPO_DIR="$HOME/Projects/openai-skills"

mkdir -p "$AGENTS_DIR" "$SECURITY_SCANS_DIR" "$HOME/Projects"

if [ -d "$SKILLS_REPO_DIR/.git" ]; then
  echo "Updating skills repository..."
  git -C "$SKILLS_REPO_DIR" pull --ff-only
else
  echo "Cloning skills repository..."
  git clone https://github.com/openai/skills.git "$SKILLS_REPO_DIR"
fi

for skill in security-best-practices security-threat-model security-ownership-map; do
  if [ -d "$SKILLS_REPO_DIR/$skill" ]; then
    mkdir -p "$AGENTS_DIR/$skill"
    cp "$SKILLS_REPO_DIR/$skill/SKILL.md" "$AGENTS_DIR/$skill/SKILL.md"
    echo "Installed skill: $skill"
  else
    echo "Warning: skill $skill not found in $SKILLS_REPO_DIR" >&2
  fi
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

mkdir -p "$AGENTS_DIR/security-pipeline" "$AGENTS_DIR/network-pipeline"
cp "$REPO_ROOT/skills/security-pipeline/SKILL.md" "$AGENTS_DIR/security-pipeline/SKILL.md"
cp "$REPO_ROOT/skills/network-pipeline/SKILL.md" "$AGENTS_DIR/network-pipeline/SKILL.md"

if [ -f "$HOME/.zshrc" ]; then
  if ! grep -q 'alias cx="codex"' "$HOME/.zshrc"; then
    echo 'alias cx="codex"' >> "$HOME/.zshrc"
    echo "Added cx alias to ~/.zshrc"
  fi
else
  echo 'alias cx="codex"' >> "$HOME/.zshrc"
  echo "Created ~/.zshrc and added cx alias"
fi

echo "Verification commands:"
cat <<'VERIFY'
  codex --version
  gitleaks version
  semgrep --version
  trivy --version
VERIFY
