#!/usr/bin/env bash

set -Eeuo pipefail

wget -O- https://bootstrap.pypa.io/get-pip.py | python3
wget -O- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python
python -m pip install pycryptodome
pip3 install --cache-dir /var/cache/pip --no-input \
	pycryptodome \
	onnx==1.9.0 \
	onnx-simplifier==0.3.6 \
	onnxoptimizer==0.2.6 \
	onnxruntime==1.8.0 \
	/tmp/nncase.whl
