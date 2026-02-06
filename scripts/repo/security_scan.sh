#!/usr/bin/env bash
set -euo pipefail

# Version: 0.1.0

repo_name=""
if git remote get-url origin >/dev/null 2>&1; then
  remote_url="$(git remote get-url origin)"
  repo_name="$(basename "${remote_url%.git}")"
else
  repo_name="$(basename "$(pwd)")"
fi

base_dir="${SECURITY_OUT_DIR:-$HOME/SecurityScans/$repo_name}"
timestamp="$(date +%Y%m%d_%H%M%S)"
out_dir="$base_dir/$timestamp"

mkdir -p "$out_dir"
ln -sfn "$out_dir" "$base_dir/latest"

write_missing() {
  local file="$1"
  local tool="$2"
  echo "$tool not found. Install it and re-run the scan." > "$file"
}

run_command() {
  local file="$1"
  shift
  if "$@" >"$file" 2>&1; then
    return 0
  fi
  echo "Command failed: $*" >> "$file"
  return 0
}

if command -v gitleaks >/dev/null 2>&1; then
  run_command "$out_dir/GITLEAKS.txt" gitleaks detect -v --redact --source .
else
  write_missing "$out_dir/GITLEAKS.txt" "gitleaks"
fi

if [ -f package.json ]; then
  if command -v npm >/dev/null 2>&1; then
    run_command "$out_dir/NPM_AUDIT.txt" npm audit --audit-level=moderate
  else
    write_missing "$out_dir/NPM_AUDIT.txt" "npm"
  fi
else
  echo "package.json not found; skipping npm audit." > "$out_dir/NPM_AUDIT.txt"
fi

if command -v semgrep >/dev/null 2>&1; then
  if ! semgrep scan --config p/ci --error . >"$out_dir/SEMGREP.txt" 2>&1; then
    semgrep scan --config p/ci . >"$out_dir/SEMGREP.txt" 2>&1 || echo "Semgrep command failed." >> "$out_dir/SEMGREP.txt"
  fi
else
  write_missing "$out_dir/SEMGREP.txt" "semgrep"
fi

if command -v trivy >/dev/null 2>&1; then
  trivy fs --scanners vuln,misconfig,secret --severity HIGH,CRITICAL --format table --output "$out_dir/TRIVY.txt" . 2>&1 || echo "Trivy command failed." >> "$out_dir/TRIVY.txt"
else
  write_missing "$out_dir/TRIVY.txt" "trivy"
fi

echo "Security scan outputs written to: $out_dir"
echo "Latest symlink: $base_dir/latest"
