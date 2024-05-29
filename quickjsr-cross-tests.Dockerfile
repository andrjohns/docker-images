FROM debian:sid-slim

ENV R_VERSION=4.4.0

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN mkdir -p /etc/apt
RUN apt-get update && apt-get install -y clang-18 flang-18 locales curl
RUN echo 'deb-src http://deb.debian.org/debian sid main' >> /etc/apt/sources.list
RUN apt-get update && apt-get build-dep -y r-base

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-18 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-18 100
RUN update-alternatives --install /usr/bin/fc fc /usr/bin/flang-new-18 100
RUN update-alternatives --install /usr/bin/f90 f90 /usr/bin/flang-new-18 100
RUN update-alternatives --install /usr/bin/f95 f95 /usr/bin/flang-new-18 100
ENV CC=clang-18
ENV CXX=clang++-18
ENV FC=flang-new-18
ENV F77=flang-new-18
ENV F90=flang-new-18
ENV F95=flang-new-18

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN curl -O https://cran.rstudio.com/src/base/R-4/R-${R_VERSION}.tar.gz && \
      tar -xzvf R-${R_VERSION}.tar.gz

RUN cd R-${R_VERSION} && \
      CC=clang-18 CXX=clang++-18 \
      FC=flang-new-18 F77=flang-new-18 \
      F90=flang-new-18 F95=flang-new-18 \
      ./configure \
        --prefix=/usr/local \
        --enable-R-shlib \
        --enable-memory-profiling \
        --with-blas \
        --with-lapack && \
      make && \
      make install

RUN mkdir -p /root/.R
RUN echo "CC=clang-18" >> /root/.R/Makevars
RUN echo "CXX=clang++-18" >> /root/.R/Makevars
RUN echo "FC=flang-new-18" >> /root/.R/Makevars
RUN echo "F77=flang-new-18" >> /root/.R/Makevars
RUN echo "F90=flang-new-18" >> /root/.R/Makevars
RUN echo "F95=flang-new-18" >> /root/.R/Makevars

RUN Rscript -e 'install.packages(c("tinytest", "jsonlite"), repos="https://cloud.r-project.org", dependencies="Imports")'
