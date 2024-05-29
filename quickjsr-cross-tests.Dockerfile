FROM debian:sid-slim

ENV R_VERSION=4.4.0

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y lsb-release wget software-properties-common gnupg
RUN bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)"

RUN mkdir -p /etc/apt
RUN echo 'deb-src http://deb.debian.org/debian sid main' >> /etc/apt/sources.list

RUN apt-get update && \
  apt-get build-dep -y r-base

RUN apt-get install -y clang llvm flang locales curl

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100
RUN update-alternatives --install /usr/bin/fc fc /usr/bin/flang-new 100
RUN update-alternatives --install /usr/bin/f90 f90 /usr/bin/flang-new 100
RUN update-alternatives --install /usr/bin/f95 f95 /usr/bin/flang-new 100
ENV CC=clang
ENV CXX=clang++
ENV FC=flang-new
ENV F77=flang-new
ENV F90=flang-new
ENV F95=flang-new

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN curl -O https://cran.rstudio.com/src/base/R-4/R-${R_VERSION}.tar.gz && \
      tar -xzvf R-${R_VERSION}.tar.gz

RUN cd R-${R_VERSION} && \
      CC=clang CXX=clang++ FC=flang-new \
      ./configure \
        --prefix=/usr/local \
        --enable-R-shlib \
        --enable-memory-profiling \
        --with-blas \
        --with-lapack && \
      make && \
      make install


RUN Rscript -e 'install.packages(c("tinytest", "jsonlite"), repos="https://cloud.r-project.org", dependencies="Imports")'
