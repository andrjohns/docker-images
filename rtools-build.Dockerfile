FROM debian:sid-slim

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y locales locales-all tzdata

RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_AU.UTF-8" >> /etc/environment
RUN echo "en_AU.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_AU.UTF-8" > /etc/locale.conf
RUN locale-gen en_AU.UTF-8

ENV LC_CTYPE="en_AU.UTF-8"
ENV LC_TIME="en_AU.UTF-8"
ENV LC_MESSAGES="en_AU.UTF-8"
ENV LC_MONETARY="en_AU.UTF-8"
ENV LC_PAPER="en_AU.UTF-8"
ENV LC_MEASUREMENT="en_AU.UTF-8"
ENV LC_COLLATE="en_AU.UTF-8"
ENV LC_ALL="en_AU.UTF-8"


RUN apt-get install -y \
  autoconf automake autopoint bash bison bzip2 flex g++ \
  g++-multilib-x86-64-linux-gnu gettext git gperf intltool \
  libgdk-pixbuf2.0-dev libltdl-dev libgl-dev libpcre3-dev libssl-dev \
  libtool-bin libxml-parser-perl lzip make openssl p7zip-full patch \
  perl python3 python3-distutils python3-mako python3-pkg-resources \
  python3-setuptools dh-python python-is-python3 ruby sed unzip wget \
  xz-utils texinfo sqlite3 zstd gtk-doc-tools libopengl-dev \
  libglu1-mesa-dev autoconf-archive
