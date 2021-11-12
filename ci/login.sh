#!/usr/bin/env bash

set -Eeuo pipefail
cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

export TMPDIR="${RUNNER_TEMP:-$SYSTEM_COMMON_CACHE/tmp}"
mkdir -p "$TMPDIR"

if [[ "${CI:-}" ]]; then
	sudo apt install jq curl podman buildah
elif [[ ! ${GITHUB_ENV:-} ]]; then
	GITHUB_ENV="$TMPDIR/github-env-fake"
fi

mkdir -p "$HOME/secrets"
chmod 0700 "$HOME/secrets"

export REGISTRY_AUTH_FILE="$HOME/secrets/auth.json"
echo "REGISTRY_AUTH_FILE=${REGISTRY_AUTH_FILE}" >>"$GITHUB_ENV"

podman login "--username=$GITHUB_ACTOR" "--password=$GITHUB_TOKEN" ghcr.io
