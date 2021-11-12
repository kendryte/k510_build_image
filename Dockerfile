FROM ubuntu

RUN mkdir -p /opt/k510_buildroot /opt/build-cache \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y \
		build-essential ccache file wget cpio dosfstools mtools unzip rsync bc ncurses-dev python python-dev python3 python3-pip libc6-i386 libc6-dev-i386 libncurses5:i386 \
	&& rm -rf /var/lib/apt/lists/* /root/.cache \
	&& wget -O- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python \
	&& python -m pip install pycryptodome --no-cache-dir \
	&& pip3 install onnx==1.9.0 onnx-simplifier==0.3.6 onnxoptimizer==0.2.6 onnxruntime==1.8.0 nncase --no-cache-dir 

ENV BR2_CCACHE=y BR2_CCACHE_DIR=/opt/build-cache CCACHE_MAXFILES=0 CCACHE_MAXSIZE=50G FORCE_UNSAFE_CONFIGURE=1

VOLUME /opt/k510_buildroot /opt/build-cache
WORKDIR /opt/k510_buildroot

RUN echo 'PS1="[\[\e[38;5;27m\]CAN\[\e[0m\] \W]$ "' >>/root/.bashrc \
	&& ln -s /opt/k510_buildroot
