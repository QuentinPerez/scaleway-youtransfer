## -*- docker-image-name: "scaleway/youtransfer:latest" -*-
FROM scaleway/ubuntu:vivid
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
 && apt-get install -y nodejs

RUN mkdir -p /opt/youtransfer/config
RUN mkdir -p /opt/youtransfer/uploads
WORKDIR /opt/youtransfer/
RUN npm install youtransfer -g
RUN /usr/lib/node_modules/youtransfer/bin/youtransfer init
RUN npm install

ADD ./patches/config.json /opt/youtransfer/
ADD ./patches/etc /etc

RUN systemctl enable youtransfer

# Clean APT cache for a lighter image.
RUN apt-get clean \
 && rm -fr /var/lib/{apt,dpkg,cache,log}


# Clean rootfs from image-builder
RUN /usr/local/sbin/builder-leave
