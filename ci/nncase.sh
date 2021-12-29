#!/usr/bin/env bash

set -Eeuo pipefail

tar xf nncase_v1.1.0.tgz

mv nncase_v1.1.0/x86_64/* ./

rm -rf nncase_v1.1.0 nncase_v1.1.0.tgz

