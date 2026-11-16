# envrc-common — status

## Health: functional, some drift

- GCP and K8s paths are well-tested in production (owncluster)
- AWS paths less exercised recently
- Azure path is the least tested

## Known issues

- `_bootstrap.sh` pins only `log2/` repos: `dep-common v0.1.0`, `shell-common:v0.1.1`, `k8s-common:v0.1.0` (no external dependencies left)
- Each `.envrc-*.sh` hard-codes the release tag (currently `v0.1.1`) and a sha256 per `source_url`: bump them together on release

## Tech debt

- `release.sh` cuts tags but doesn't validate that all sha256 hashes in consumer configs are updated
- No automated test for the `source_url` → `local_SNAPSHOT` fallback path
- `.envrc-aws-login-azure.sh` is a niche cross-cloud path with minimal documentation

## Dependencies

- `log2/shell-common` (via dep)
- `log2/k8s-common` (via dep, for cluster switching)
- direnv (built-in `source_url`, `use`, `watch_file`)
- basher / dep-bootstrap (for dep runtime)
