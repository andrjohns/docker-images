FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y tzdata locales
RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

ENV LC_CTYPE="en_US.UTF-8"
ENV LC_TIME="en_US.UTF-8"
ENV LC_MESSAGES="en_US.UTF-8"
ENV LC_MONETARY="en_US.UTF-8"
ENV LC_PAPER="en_US.UTF-8"
ENV LC_MEASUREMENT="en_US.UTF-8"
ENV LC_COLLATE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

RUN apt-get update &&  apt-get install -y r-base-dev libcurl4-openssl-dev libssh-dev \
                        libssl-dev libgit2-dev libxml2-dev git \
                        default-jre default-jdk libfftw3-dev \
                        libgdal-dev libudunits2-dev libmagick++-dev \
                        libboost-all-dev libtbb-dev cmake jags \
                        libharfbuzz-dev libfribidi-dev \
                        libgsl-dev libzmq3-dev libgmp-dev \
                        libmpfr-dev cargo wget curl p7zip-full gettext \
                        autopoint bison flex gperf intltool lzip \
                        python3-mako ruby libtool-bin python-is-python3 \
                        automake perl libtool gettext gcc-i686-linux-gnu \
                        flex bison binfmt-support qemu-user-static

RUN wget https://www.mrc-bsu.cam.ac.uk/wp-content/uploads/2018/04/OpenBUGS-3.2.3.tar.gz
RUN tar zxf OpenBUGS-3.2.3.tar.gz && \
    cd OpenBUGS-3.2.3 && \
    ./configure --host=i686-linux-gnu && \
    make && \
    make install

RUN apt-get install -y qpdf pandoc
RUN apt-get install -y libnode-dev
