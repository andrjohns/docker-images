FROM ubuntu:22.04

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update
RUN echo "Europe/Prague" > /etc/timezone
RUN env DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata

    # from MXE documentation
RUN apt-get install -y \
      autoconf \
      automake \
      autopoint \
      bash \
      bison \
      bzip2 \
      flex \
      g++ \
      g++-multilib \
      gettext \
      git \
      gperf \
      intltool \
      libc6-dev-i386 \
      libgdk-pixbuf2.0-dev \
      libltdl-dev \
      libgl-dev \
      libpcre3-dev \
      libssl-dev \
      libtool-bin \
      libxml-parser-perl \
      lzip \
      make \
      openssl \
      p7zip-full \
      patch \
      perl \
      python3 \
      python3-distutils \
      python3-mako \
      python3-pkg-resources \
      python3-setuptools \
      python2 \
      python-is-python3 \
      ruby \
      sed \
      unzip \
      wget \
      xz-utils

    # texinfo for binutils
    # sqlite3 for proj
RUN apt-get install -y texinfo sqlite3 zstd
    
    # for gnutls
RUN apt-get install -y gtk-doc-tools
    
    # for qt6-qtbase
RUN apt-get install -y libopengl-dev libglu1-mesa-dev
    
    # for dbus
RUN apt-get install -y autoconf-archive
