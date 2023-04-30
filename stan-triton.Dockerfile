FROM debian:sid-slim

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Add non-free repo to install Intel MKL
RUN sed -i -e's/ main/ main contrib non-free non-free-firmware/g' \
              /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y locales locales-all intel-mkl-full
RUN apt-get update && apt-get install -y r-base-dev nvidia-tesla-510-driver
RUN apt-get update && apt-get install -y sudo tzdata libcurl4-openssl-dev
RUN apt-get update && apt-get install -y libssh-dev libssl-dev libgit2-dev
RUN apt-get update && apt-get install -y libv8-dev git cmake qpdf pandoc
RUN apt-get update && apt-get install -y libxml2-dev clinfo nvidia-cuda-toolkit
RUN apt-get update && apt-get install -y nvidia-cuda-toolkit-gcc libfontconfig1-dev

# Specify that the MKL should provide the Matrix algebra libraries for the system
RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/libblas.so.3 \
                                  libblas.so.3-x86_64-linux-gnu \
                                  /usr/lib/x86_64-linux-gnu/libmkl_rt.so 150

RUN update-alternatives --install /usr/lib/x86_64-linux-gnu/liblapack.so.3 \
                                  liblapack.so.3-x86_64-linux-gnu \
                                  /usr/lib/x86_64-linux-gnu/libmkl_rt.so 150

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

ENV MKL_INTERFACE_LAYER GNU,LP64
ENV MKL_THREADING_LAYER GNU
ENV R_MAKEVARS_USER /home/stan-triton/.R/Makevars
ENV R_ENVIRON_USER /home/stan-triton/.Renviron
ENV CMDSTAN /scratch/cs/bayes_ave/.cmdstan-triton/

RUN useradd -ms /bin/bash stan-triton

USER stan-triton
WORKDIR /home/stan-triton

RUN mkdir .R

# Add flags to suppress annoying compiler warnings in build
RUN echo " \
  CXXFLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
  CXX14FLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
  CXX17FLAGS += -Wno-enum-compare -Wno-ignored-attributes -Wno-unused-local-typedef \
              -Wno-unneeded-internal-declaration -Wno-unused-function -Wno-unused-but-set-variable \
              -Wno-unused-variable -Wno-infinite-recursion -Wno-unknown-pragmas -Wno-unused-lambda-capture \
              -Wno-deprecated-declarations -Wno-deprecated-builtins -Wno-unused-but-set-variables \n \
" >> .R/Makevars

RUN echo "R_LIBS_USER=/scratch/cs/bayes_ave/R/library" >> .Renviron

USER root

# Make directory accessible and executable by all users
RUN chmod -R 777 /home/stan-triton

USER stan-triton
