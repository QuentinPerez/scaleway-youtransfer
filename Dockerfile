## -*- docker-image-name: "scaleway/youtransfer:latest" -*-
FROM scaleway/ubuntu:trusty
MAINTAINER Scaleway <opensource@scaleway.com> (@scaleway)

# Prepare rootfs for image-builder
RUN /usr/local/sbin/builder-enter


RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y software-properties-common \
 && echo "" | add-apt-repository ppa:ubuntu-toolchain-r/test \
 && apt-get install -y \
      build-essential \
      git \
 && curl -sL https://deb.nodesource.com/setup_0.12 | bash - \
 && apt-get install -y nodejs \
 && apt-get clean

RUN mkdir -p /opt/youtransfer/config /opt/youtransfer/uploads
WORKDIR /opt/youtransfer/
RUN npm install youtransfer -g \
 && /usr/lib/node_modules/youtransfer/bin/youtransfer init \
 && npm install

ADD ./patches/etc /etc
ADD ./patches/opt /opt

RUN update-rc.d youtransfer defaults


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
