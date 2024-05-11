FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
  apt-get install -y r-base-dev pandoc locales

RUN "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8
RUN Rscript -e 'install.packages(c("tinytest", "jsonlite", "rcmdcheck"), repos="https://cloud.r-project.org", dependencies="Imports")'
