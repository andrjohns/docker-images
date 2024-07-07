FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && \
  apt-get install -y clang-18 gcc-14 locales pandoc r-base-core \
                        r-cran-knitr r-cran-rmarkdown r-cran-tinytest

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN echo "CPPFLAGS += -w" >> /etc/R/Makeconf
