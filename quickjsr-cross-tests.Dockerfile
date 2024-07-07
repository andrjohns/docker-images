FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install -y clang-18 gcc-14 r-base-core locales pandoc

RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN Rscript -e 'install.packages(c("tinytest", "rmarkdown", "knitr"), \
                  repos="https://cloud.r-project.org", \
                  Ncpus=4, \
                  dependencies="Imports")'

RUN Rscript -e 'install.packages(c("rcmdcheck"), \
                  repos="https://cloud.r-project.org", \
                  Ncpus=4, \
                  dependencies="Imports")'
