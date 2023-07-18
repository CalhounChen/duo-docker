FROM ubuntu:latest

LABEL org.opencontainers.image.title = "milkv-duo"
LABEL org.opencontainers.image.version = "0.1.16"
LABEL org.opencontainers.image.authors = "1137682506@qq.com"
LABEL org.opencontainers.image.source = "https://github.com/CalhounChen/duo-docker"
LABEL org.opencontainers.image.licenses = "BSD"
LABEL org.opencontainers.image.description DESCRIPTION = "MilkV Duo burn image build environment on Ubuntu 22.04"


WORKDIR /root/

RUN apt update && \
	apt upgrade -y && \
	apt install -y wget curl git \
	gcc autoconf automake make cmake ninja-build \
	python-is-python3 python3 python3-pip python3-dev \
	dialog bc flex bison libssl-dev libconfuse-dev libncurses-dev libtool slib rsync pkg-config \
	device-tree-compiler squashfs-tools parted dosfstools texinfo genext2fs \
	mtools cpio zip unzip sudo fdisk udev vim 
RUN echo "deb http://security.ubuntu.com/ubuntu focal-security main" | sudo tee /etc/apt/sources.list.d/focal-security.list
RUN apt update && apt upgrade -y &&apt install libssl1.1 -y && \
	apt-get clean -y
# RUN wget https://www.openssl.org/source/old/1.1.1/openssl-1.1.1k.tar.gz && \
# 	tar xf openssl-1.1.1k.tar.gz && \
# 	cd /root/openssl-1.1.1k/ && \
# 	./config --prefix=/usr/local/ && \
# 	make && \
# 	make install && \
# 	echo "export LD_LIBRARY_PATH=/usr/local/lib/" >> /root/.bashrc && \
# 	echo "export MILKV_BOARD=milkv-duo" >> /root/.bashrc && \
# 	/bin/bash -c "source /root/.bashrc" && \
# 	rm -rf /root/openssl-1.1.1k.tar.gz && \
# 	rm -rf /root/openssl-1.1.1k/

RUN wget http://sophon-file.sophon.cn/sophon-prod-s3/drive/23/03/07/16/host-tools.tar.gz -q  && \
	tar xf host-tools.tar.gz && \
	rm -rf host-tools.tar.gz

RUN git clone --branch v16 --depth 1 http://github.com/pengutronix/genimage.git && \
	cd /root/genimage && \
	./autogen.sh && \
	./configure --prefix=/usr/local/ && \
	make && \
	make install && \
	rm -rf /root/genimage/

RUN git clone --branch develop --depth 1 http://github.com/milkv-duo/duo-buildroot-sdk.git && \
	cd /root/duo-buildroot-sdk/ && \
	ln -s ../host-tools/ ./ 
