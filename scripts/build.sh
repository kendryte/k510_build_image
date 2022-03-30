#!/usr/bin/env bash

set -Eeuo pipefail

export CACHE_ROOT="$HOME/cache/k510_buildroot"
export SYSTEM_COMMON_CACHE="$CACHE_ROOT"
export CONTAINERS_DATA_PATH="$CACHE_ROOT"

# mkdir -p "$CACHE_ROOT/apt" "$CACHE_ROOT/apt-lists" "$CACHE_ROOT/python" "$CACHE_ROOT/tmp"
# chmod 0777 "$CACHE_ROOT/apt" "$CACHE_ROOT/apt-lists" "$CACHE_ROOT/python" "$CACHE_ROOT/tmp" -R

cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")/.."

# shellcheck source=../containers-builder/functions-build.sh
source "containers-builder/functions-build.sh"

STEP="设置系统参数"
BUILDAH_LAST_IMAGE=$(image_get_id "ubuntu")
buildah_config "k510_builder" \
	--env BR2_CCACHE=y \
	--env BR2_CCACHE_DIR=/opt/build-cache \
	--env CCACHE_MAXFILES=0 \
	--env CCACHE_MAXSIZE=50G \
	--env FORCE_UNSAFE_CONFIGURE=1 \
	--env DEBIAN_FRONTEND=noninteractive

STEP="安装系统依赖"
buildah_cache_run "k510_builder" ./steps/2.sh

STEP="安装K510编译依赖"
buildah_cache_run "k510_builder" ./steps/3.sh

STEP="安装python相关包"
buildah_cache_run "k510_builder" ./steps/4.sh \
	--volume="$SYSTEM_COMMON_CACHE/pip:/var/cache/pip" \
	--volume="$CURRENT_DIR/nncase_dist/nncase.whl:/tmp/nncase.whl:ro" --

STEP="清理工作"
buildah_cache_run "k510_builder" ./steps/5.sh

STEP="配置镜像参数"
buildah_config "k510_builder" \
	--volume /opt/k510_buildroot \
	--volume /opt/build-cache \
	--workingdir /opt/k510_buildroot
