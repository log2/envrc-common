# envrc-framework — status

## Health: functional, some drift

- GCP and K8s paths are well-tested in production (owncluster)
- AWS paths less exercised recently
- Azure path is the least tested

## Known issues

- `_bootstrap.sh` still references `log2/dep-bootstrap` as the upstream URL — this is the original external dep, not a personal fork. Will break if log2 removes the repo.
- `_bootstrap.sh` also pins `log2/k8s-common:0.2.27` — external dependency. Same risk.
- Long-term goal: replace these external references with `log2/` equivalents

## Tech debt

- `release.sh` cuts tags but doesn't validate that all sha256 hashes in consumer configs are updated
- No automated test for the `source_url` → `local_SNAPSHOT` fallback path
- `.envrc-aws-login-azure.sh` is a niche cross-cloud path with minimal documentation

## Dependencies

- `log2/shell-common` (via dep)
- `log2/k8s-common` (via dep, for cluster switching)
- direnv (built-in `source_url`, `use`, `watch_file`)
- basher / dep-bootstrap (for dep runtime)
