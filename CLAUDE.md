# envrc-framework — development guide

## Purpose

Collection of `.envrc-*.sh` snippets that are `source_url`-fetched by consumer `.envrc` files. Provides per-cloud-provider cluster context switching, AWS/GCP/Azure auth, and asdf version alignment for kubectl/talosctl.

## File map

| File | Loaded by |
|------|-----------|
| `_bootstrap.sh` | All `.envrc-*.sh` files (via dep) |
| `.envrc-clusters.sh` | `.envrc` files that use `use_cp <provider>` |
| `.envrc-gcp.sh` | `.envrc` files for GCP clusters |
| `.envrc-aws.sh` | `.envrc` files for AWS clusters |
| `.envrc-aws-common.sh` | `.envrc-aws.sh` and `.envrc-aws-sso.sh` |
| `.envrc-aws-sso.sh` | `.envrc` files using AWS SSO |
| `.envrc-aws-sso-access.sh` | `.envrc-aws-sso.sh` |
| `.envrc-aws-login-azure.sh` | `.envrc` files using Azure-backed AWS login |
| `.envrc-azure.sh` | `.envrc` files for Azure clusters |
| `.envrc-k8s.sh` | All cluster envrc files |
| `create-hash.sh` | Manual utility: generate sha256 for source_url |
| `release.sh` | Cuts a new release tag |

## Loading mechanism

Consumer `.envrc` files use `source_url` (direnv built-in) with a pinned sha256:
```bash
source_url "https://raw.githubusercontent.com/log2/envrc-common/v0.x.y/.envrc-clusters.sh" "sha256-..."
```

For local development, set `local_SNAPSHOT` to bypass the URL:
```bash
export local_SNAPSHOT="/path/to/local/envrc-framework"
```
Each `.sh` file checks `${local_SNAPSHOT}` and sources the local copy instead.

## Shellcheck notes

- `source_url` and `fetchurl` are direnv built-ins, invisible to shellcheck → SC2148 disabled per file
- `source "${local_SNAPSHOT}/..."` uses a variable path → SC1091 disabled (expected)
- `. <(direnv stdlib)` is a process substitution → SC1090 disabled (expected)

## Adding a cloud provider

1. Create `.envrc-<provider>.sh` following the pattern of `.envrc-gcp.sh`
2. Export in `_bootstrap.sh`: add `dep include log2/k8s-common kube-config-<provider>`
3. Update `release.sh` if needed
4. Update `create-hash.sh` usage docs

## Releasing

```bash
./release.sh <new-version>   # tags and pushes
./create-hash.sh             # regenerates sha256 table for docs
```

## Pre-commit

- `shfmt -i 4 -bn -ci -fn`
- `shellcheck --severity=warning`
