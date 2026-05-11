#!/usr/bin/env bash

if [ -z "${local_SNAPSHOT}" ]; then
    # shellcheck source=/_bootstrap.sh
    source_url "https://raw.githubusercontent.com/log2/envrc-common/v0.1.0/_bootstrap.sh" "sha256-7x_VIGdOBxrdC9VAVITQk_abUTb0JE5JSN1t_2rCFG4="
else
    # shellcheck disable=SC1091
    source "${local_SNAPSHOT}"/_bootstrap.sh
fi

req_ver k9s 0.50.18
req_ver kustomize 5.3.0
req_ver sops 3.11.0

work_on()
{
    local release_name="$1"
    local namespace_name="${2:-${release_name}}"
    export NAMESPACE="$namespace_name"
    export RELEASE_NAME="$release_name"

    prepare_and_check_k8s_context "$namespace_name"

    BASE_RELEASE="$(pwd)"
    export BASE_RELEASE

    enable_scripts
}
