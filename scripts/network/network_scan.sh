#!/usr/bin/env bash
set -euo pipefail

# Version: 0.1.0

if [ -z "${1:-}" ]; then
  echo "Usage: $0 <hostname|ip|cidr>" >&2
  exit 1
fi

target="$1"
base_dir="${SECURITY_OUT_DIR:-$HOME/SecurityScans/network/$target}"
timestamp="$(date +%Y%m%d_%H%M%S)"
out_dir="$base_dir/$timestamp"

mkdir -p "$out_dir"
ln -sfn "$out_dir" "$base_dir/latest"

if command -v nmap >/dev/null 2>&1; then
  nmap -sV -Pn -T3 --top-ports 1000 "$target" >"$out_dir/NMAP.txt" 2>&1 || echo "nmap command failed." >> "$out_dir/NMAP.txt"
else
  echo "nmap not found. Install it and re-run the scan." > "$out_dir/NMAP.txt"
fi

echo "Network scan outputs written to: $out_dir"
echo "Latest symlink: $base_dir/latest"
