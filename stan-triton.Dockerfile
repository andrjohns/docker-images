FROM debian:sid-slim

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Add non-free repo to install Nvidia OpenCL deps
RUN sed -i -e's/ main/ main contrib non-free non-free-firmware/g' \
              /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y locales locales-all
RUN apt-get update && apt-get install -y libopenblas-pthread-dev liblapacke-dev libopenblas64-pthread-dev liblapacke64-dev
RUN apt-get update && apt-get install -y r-base-dev nvidia-opencl-dev nvidia-opencl-common
RUN apt-get update && apt-get install -y nvidia-libopencl1 nvidia-opencl-icd
RUN apt-get update && apt-get install -y sudo tzdata libcurl4-openssl-dev
RUN apt-get update && apt-get install -y libssh-dev libssl-dev libgit2-dev
RUN apt-get update && apt-get install -y libv8-dev git cmake qpdf pandoc
RUN apt-get update && apt-get install -y libxml2-dev clinfo libfontconfig1-dev
RUN apt-get update && apt-get install -y default-jre default-jdk libfftw3-dev
RUN apt-get update && apt-get install -y libgdal-dev libudunits2-dev libmagick++-dev
RUN apt-get update && apt-get install -y libboost-all-dev libtbb-dev jags
RUN apt-get update && apt-get install -y libharfbuzz-dev libfribidi-dev
RUN apt-get update && apt-get install -y libgsl-dev libzmq3-dev libgmp-dev
RUN apt-get update && apt-get install -y libmpfr-dev cargo wget curl p7zip-full
RUN apt-get update && apt-get install -y autopoint bison flex gperf intltool lzip
RUN apt-get update && apt-get install -y python3-mako ruby libtool-bin python-is-python3
RUN apt-get update && apt-get install -y automake perl libtool gettext gcc-i686-linux-gnu
RUN apt-get update && apt-get install -y nvidia-cuda-toolkit

RUN wget https://www.mrc-bsu.cam.ac.uk/wp-content/uploads/2018/04/OpenBUGS-3.2.3.tar.gz
RUN tar zxf OpenBUGS-3.2.3.tar.gz && \
    cd OpenBUGS-3.2.3 && \
    ./configure --host=i686-linux-gnu && \
    make && \
    make install

RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_GB.UTF-8" >> /etc/environment
RUN echo "en_GB.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_GB.UTF-8" > /etc/locale.conf
RUN locale-gen en_GB.UTF-8

ENV LC_CTYPE="en_GB.UTF-8"
ENV LC_TIME="en_GB.UTF-8"
ENV LC_MESSAGES="en_GB.UTF-8"
ENV LC_MONETARY="en_GB.UTF-8"
ENV LC_PAPER="en_GB.UTF-8"
ENV LC_MEASUREMENT="en_GB.UTF-8"
ENV LC_COLLATE="en_GB.UTF-8"
ENV LC_ALL="en_GB.UTF-8"

ENV R_MAKEVARS_USER /home/stan-triton/.R/Makevars
ENV R_ENVIRON_USER /home/stan-triton/.Renviron
ENV CMDSTAN /scratch/cs/bayes_ave/.cmdstan-triton/

RUN useradd -ms /bin/bash stan-triton

USER stan-triton
WORKDIR /home/stan-triton

RUN mkdir .R

# Add flags to suppress annoying compiler warnings in build
RUN echo " \
  CXXFLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef -Wno-nonnull \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
  CXX14FLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef -Wno-nonnull \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
  CXX17FLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef -Wno-nonnull \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
" >> .R/Makevars

RUN echo "R_LIBS_USER=/scratch/work/\${USER}/stan-triton/R/library" >> .Renviron

USER root

# Make directory accessible and executable by all users
RUN chmod -R 777 /home/stan-triton

USER stan-triton
