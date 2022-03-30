#!/usr/bin/env bash

set -Eeuo pipefail

mkdir -p /opt/k510_buildroot /opt/build-cache
ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

echo '' >>/etc/bashrc
echo 'PS1="[\[\e[38;5;27m\]CAN\[\e[0m\] \W]$ "' >>/etc/bashrc
ln -s /opt/k510_buildroot ~/k510_buildroot

chmod 0777 /root -R

mkdir -p /root/.ssh
chmod 0700 /root/.ssh
