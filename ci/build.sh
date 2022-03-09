#!/usr/bin/env bash

set -Eeuo pipefail

CACHE_ROOT="$HOME/cache/k510_buildroot"

mkdir -p "$CACHE_ROOT/apt" "$CACHE_ROOT/apt-lists" "$CACHE_ROOT/python" "$CACHE_ROOT/tmp"
chmod 0777 "$CACHE_ROOT/apt" "$CACHE_ROOT/apt-lists" "$CACHE_ROOT/python" "$CACHE_ROOT/tmp" -R

podman pull ubuntu:latest
podman build \
	-t ghcr.io/kendryte/k510_env:latest \
	--volume "$CACHE_ROOT/apt:/var/cache/apt" \
	--volume "$CACHE_ROOT/apt-lists:/var/lib/apt" \
	--volume "$CACHE_ROOT/python:/root/.cache" \
	--volume "$CACHE_ROOT/tmp:/tmp" \
	--volume "$(pwd):/tmp/build" \
	-f ./Dockerfile \
	.
