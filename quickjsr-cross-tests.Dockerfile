FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN mkdir -p /etc/apt
RUN apt-get update && apt-get install -y clang-18 r-base-core locales pandoc

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang-18 100
RUN update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-18 100
ENV CC=clang-18
ENV CXX=clang++-18

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN echo "CPPFLAGS += -w" >> /etc/R/Makeconf

RUN Rscript -e 'install.packages(c("tinytest","knitr","rmarkdown"), repos="https://cloud.r-project.org", dependencies="Imports")'

RUN apt-get update && apt-get install -y qpdf
