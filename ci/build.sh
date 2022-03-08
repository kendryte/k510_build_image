#!/usr/bin/env bash

set -Eeuo pipefail

mkdir -p "$HOME/cache/k510_buildroot/apt" \
	"$HOME/cache/k510_buildroot/apt-lists" \
	"$HOME/cache/k510_buildroot/python" \
	"$HOME/cache/k510_buildroot/tmp"

podman build \
	-t kendryte/k510_env:latest \
	--volume "$HOME/cache/k510_buildroot/apt:/var/cache/apt" \
	--volume "$HOME/cache/k510_buildroot/apt-lists:/var/lib/apt" \
	--volume "$HOME/cache/k510_buildroot/python:/root/.cache" \
	--volume "$HOME/cache/k510_buildroot/tmp:/tmp" \
	--volume "$(pwd):/tmp/build" \
	-f ./Dockerfile \
	.
