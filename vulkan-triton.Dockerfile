FROM debian:sid-slim

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Add non-free repo to install Nvidia OpenCL deps
RUN sed -i -e's/ main/ main contrib non-free non-free-firmware/g' \
              /etc/apt/sources.list.d/debian.sources

RUN apt-get update && apt-get install -y nvidia-tesla-vulkan-icd nvidia-vulkan-common nvidia-tesla-driver
RUN apt-get update && apt-get install -y vulkan-validationlayers-dev libvulkan-dev
RUN apt-get update && apt-get install -y locales locales-all vulkan-tools

RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_AU.UTF-8" >> /etc/environment
RUN echo "en_AU.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_AU.UTF-8" > /etc/locale.conf
RUN locale-gen en_AU.UTF-8

ENV LC_CTYPE="en_AU.UTF-8"
ENV LC_TIME="en_AU.UTF-8"
ENV LC_MESSAGES="en_AU.UTF-8"
ENV LC_MONETARY="en_AU.UTF-8"
ENV LC_PAPER="en_AU.UTF-8"
ENV LC_MEASUREMENT="en_AU.UTF-8"
ENV LC_COLLATE="en_AU.UTF-8"
ENV LC_ALL="en_AU.UTF-8"
