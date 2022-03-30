#!/usr/bin/env bash

set -Eeuo pipefail

rm -rf nncase_dist

tar xf nncase_v1.4.0.tgz

mv nncase_v1.4.0/x86_64 ./nncase_dist

rm -rf nncase_v1.4.0

if [[ $(find nncase_dist -type f | wc -l) != 1 ]]; then
	echo "nncase 压缩包结构错误，应只有一个whl文件" >&2
	exit 1
fi

find nncase_dist -type f -exec mv '{}' nncase_dist/nncase.whl \;
