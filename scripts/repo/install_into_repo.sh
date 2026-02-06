#!/usr/bin/env bash
set -euo pipefail

# Version: 0.1.0

usage() {
  cat <<'USAGE'
Usage: ./scripts/repo/install_into_repo.sh [--no-gitignore]

Installs a repo-local symlink to the security scan script without committing artifacts.
Options:
  --no-gitignore   Skip updating .gitignore
USAGE
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

update_gitignore=true
if [ "${1:-}" = "--no-gitignore" ]; then
  update_gitignore=false
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -n "${SECURITY_TOOLBOX_DIR:-}" ]; then
  TOOLBOX_DIR="$SECURITY_TOOLBOX_DIR"
else
  TOOLBOX_DIR="$SCRIPT_DIR"
  while [ "$TOOLBOX_DIR" != "/" ] && [ ! -d "$TOOLBOX_DIR/scripts/repo" ]; do
    TOOLBOX_DIR="$(dirname "$TOOLBOX_DIR")"
  done
fi

if [ ! -f "$TOOLBOX_DIR/scripts/repo/security_scan.sh" ]; then
  echo "Unable to locate security_scan.sh. Set SECURITY_TOOLBOX_DIR to this repo root." >&2
  exit 1
fi

mkdir -p ./scripts
ln -sfn "$TOOLBOX_DIR/scripts/repo/security_scan.sh" ./scripts/security_scan.sh

echo "Linked ./scripts/security_scan.sh -> $TOOLBOX_DIR/scripts/repo/security_scan.sh"

if $update_gitignore; then
  if [ ! -f .gitignore ]; then
    touch .gitignore
  fi
  if ! grep -q '^scripts/security_scan.sh$' .gitignore; then
    echo 'scripts/security_scan.sh' >> .gitignore
    echo "Added scripts/security_scan.sh to .gitignore"
  fi
fi

usage
