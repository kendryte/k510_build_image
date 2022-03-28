#!/usr/bin/env bash

set -Eeuo pipefail

add-apt-repository ppa:deadsnakes/ppa

apt-get install -y --no-install-recommends \
	dosfstools mtools mtd-utils \
	libc6-i386 libc6-dev-i386 libncurses5:i386 libssl-dev
