#!/usr/bin/env bash

export _DEP_VERBOSENESS_LEVEL=0

# shellcheck disable=SC1090,SC1091 # dynamic URL source via fetchurl, path not statically resolvable
. "$(fetchurl "https://raw.githubusercontent.com/log2/dep-common/v0.1.0/dep-bootstrap.sh" "sha256-Mw+nhqI4qwBBwfNv3d9AdMLNhwWhwgiKx4rygEeqE1E=")" v0.1.0

if [ -z "${local_SNAPSHOT}" ]; then
    dep define "log2/shell-common:v0.1.0"
    dep define "log2/k8s-common:v0.1.0"
else
    dep define "log2/shell-common:local-SNAPSHOT"
    dep define "log2/k8s-common:local-SNAPSHOT"
fi

dep include log2/shell-common strings
dep include log2/shell-common log
dep include log2/shell-common req
dep include log2/shell-common files
dep include log2/shell-common calc
