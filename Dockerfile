FROM ubuntu:latest
ENV BR2_CCACHE=y BR2_CCACHE_DIR=/opt/build-cache CCACHE_MAXFILES=0 CCACHE_MAXSIZE=50G FORCE_UNSAFE_CONFIGURE=1 DEBIAN_FRONTEND=noninteractive

RUN rm -f /etc/apt/apt.conf.d/docker-clean \
	&& dpkg --add-architecture i386 \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends \
		build-essential apt software-properties-common ccache file git wget cpio dosfstools mtools unzip rsync bc ncurses-dev

RUN add-apt-repository ppa:deadsnakes/ppa \
	&& apt-get install -y --no-install-recommends \
		python python-dev libc6-i386 libc6-dev-i386 libncurses5:i386 libssl-dev \
		python3.9 python3.9-distutils

RUN wget -O- https://bootstrap.pypa.io/get-pip.py | python3 \
	&& wget -O- https://bootstrap.pypa.io/pip/2.7/get-pip.py | python \
	&& python -m pip install pycryptodome \
	&& pip3 install pycryptodome onnx==1.9.0 onnx-simplifier==0.3.6 onnxoptimizer==0.2.6 onnxruntime==1.8.0 /tmp/build/nncase_*.whl

RUN mkdir -p /opt/k510_buildroot /opt/build-cache \
	&& ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& chmod 0777 /root -R
VOLUME /opt/k510_buildroot /opt/build-cache
WORKDIR /opt/k510_buildroot

RUN echo 'PS1="[\[\e[38;5;27m\]CAN\[\e[0m\] \W]$ "' >>/root/.bashrc \
	&& ln -s /opt/k510_buildroot ~/k510_buildroot
