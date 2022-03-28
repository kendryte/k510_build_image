#!/usr/bin/env bash

set -Eeuo pipefail

rm -f /etc/apt/apt.conf.d/docker-clean

dpkg --add-architecture i386
apt-get update

apt-get install -y --no-install-recommends \
	build-essential ccache file cpio ncurses-dev \
	apt software-properties-common \
	git git-lfs openssh-client rsync wget unzip bc \
	python python-dev python3.9 python3.9-distutils
