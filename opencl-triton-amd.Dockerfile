FROM debian:sid-slim

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Add non-free repo to install Nvidia OpenCL deps
RUN sed -i -e's/ main/ main contrib non-free non-free-firmware/g' \
              /etc/apt/sources.list.d/debian.sources
RUN apt-get update && apt-get install -y firmware-amd-graphics libgl1-mesa-dri libglx-mesa0 mesa-vulkan-drivers xserver-xorg-video-all
RUN apt-get update && apt-get install -y ocl-icd-libopencl1 mesa-opencl-icd
RUN apt-get update && apt-get install -y locales locales-all clinfo ocl-icd-opencl-dev
RUN apt-get update && apt-get install -y python-is-python3 git build-essential

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
