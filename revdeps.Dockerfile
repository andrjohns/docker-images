FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y tzdata locales
RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

RUN apt-get install -y r-base-dev libcurl4-openssl-dev libssh-dev \
                        libssl-dev libgit2-dev libxml2-dev git \
                        default-jre default-jdk libfftw3-dev \
                        libgdal-dev libudunits2-dev libmagick++-dev \
                        libboost-all-dev libtbb2-dev cmake jags

RUN apt-get install -y libharfbuzz-dev libfribidi-dev
RUN apt-get install -y libgsl-dev libzmq3-dev libgmp-dev
RUN apt-get install -y libmpfr-dev
RUN apt-get install -y cargo
RUN apt-get install -y wget curl
RUN apt-get install -y gcc-multilib

RUN wget https://www.mrc-bsu.cam.ac.uk/wp-content/uploads/2018/04/OpenBUGS-3.2.3.tar.gz
RUN tar zxf OpenBUGS-3.2.3.tar.gz && \
    cd OpenBUGS-3.2.3 && \
    ./configure && \
    make && \
    make install

ENV LC_CTYPE="en_US.UTF-8"
ENV CRANCACHE_DIR "/scratch/work/johnsoa2/crancache"
