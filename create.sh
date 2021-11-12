#!/usr/bin/env bash

set -Eeuo pipefail

ENGINE=$(command -v podman &>/dev/null && echo podman || echo docker)
echo "create container with $ENGINE"

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")"

"$ENGINE" build -t canaan/k510_env:latest - <./Dockerfile
"$ENGINE" save canaan/k510_env:latest | xz >k510_docker_env.tar.xz
