FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
  apt-get install -y r-base-dev pandoc locales clang llvm

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++ 100

ENV CC=clang
ENV CXX=clang++

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN mkdir -p /root/.R
RUN echo "CC=clang" >> /root/.R/Makevars
RUN echo "CXX=clang++" >> /root/.R/Makevars

RUN Rscript -e 'install.packages(c("tinytest", "jsonlite"), repos="https://cloud.r-project.org", dependencies="Imports")'
