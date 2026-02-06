# Network Pipeline Skill

Version: 0.1.0

## Purpose
Run the network scan and generate a deterministic master report outside the repo.

## Rules
- Always run `./scripts/network/network_scan.sh <target>` from the security-toolbox repo.
- Never write report files inside any target repository.
- Always write `NETWORK_MASTER_REPORT.md` into `~/SecurityScans/network/<target>/latest/`.
- Read scan outputs from `~/SecurityScans/network/<target>/latest/`.
- Include skill and script versions in the report.
- Provide non-intrusive recommendations only.

## Workflow
1. Run the scan:
   - `bash ./scripts/network/network_scan.sh <target>`
2. Read outputs from:
   - `~/SecurityScans/network/<target>/latest/`
3. Generate the report:
   - Write `~/SecurityScans/network/<target>/latest/NETWORK_MASTER_REPORT.md`

## Report Requirements
Include the following sections:
- Scan timestamp
- Target
- Tool status (nmap)
- Findings summary
- Non-intrusive recommendations
- Evidence paths (full paths to output files)
- Versions used (skill version + `scripts/network/network_scan.sh` version)

