FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && \
  apt-get install --no-install-recommends -y \
                      clang-18 gcc-14 g++-14 r-base-core locales pandoc \
                      qpdf r-cran-tinytest r-cran-rmarkdown r-cran-knitr \
                      r-cran-rcmdcheck make

RUN echo "en_AU.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_AU.UTF-8
ENV LANG=en_AU.UTF-8
