FROM ubuntu:lunar

RUN --mount=type=secret,id=mplus_url \
  cat /run/secrets/mplus_url

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update
RUN apt-get install -y apt-utils tzdata locales sudo

RUN if [ $(uname -p) = "aarch64" ]; then \
      apt-get install -y qemu-user binfmt-support && \
      dpkg --add-architecture amd64 && \
      sed 's/^deb http/deb [arch=arm64] http/' -i '/etc/apt/sources.list' && \
      echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ lunar-security  main restricted universe multiverse" >> /etc/apt/sources.list.d/amd64.list && \
      echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ lunar         main restricted universe multiverse" >> /etc/apt/sources.list.d/amd64.list && \
      echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ lunar-updates   main restricted universe multiverse" >> /etc/apt/sources.list.d/amd64.list && \
      echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ lunar-backports main restricted universe multiverse" >> /etc/apt/sources.list.d/amd64.list && \
      apt-get update && apt-get install -y libc6:amd64; \
    fi

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

COPY ./89_ComboLinux64.bin ./

RUN bash -x ./89_ComboLinux64.bin -i silent
RUN rm ./89_ComboLinux64.bin

WORKDIR /mplus

ENTRYPOINT [ "/opt/mplus/8.9/mplus" ]
