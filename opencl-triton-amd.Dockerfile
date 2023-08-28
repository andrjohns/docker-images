FROM ubuntu:22.04

# Defined only while building
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

# Add non-free repo to install Nvidia OpenCL deps
RUN apt-get update && apt-get install -y wget curl build-essential gdebi-core
RUN wget https://repo.radeon.com/amdgpu-install/23.10.3/ubuntu/jammy/amdgpu-install_5.5.50503-1_all.deb
RUN gdebi -n amdgpu-install_5.5.50503-1_all.deb
RUN amdgpu-install -y --usecase=workstation --vulkan=pro --accept-eula --no-32

RUN apt-get update && apt-get install -y locales locales-all
RUN apt-get update && apt-get install -y clinfo vulkan-tools vulkan-validationlayers-dev
RUN apt-get update && apt-get install -y ocl-icd-opencl-dev
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
