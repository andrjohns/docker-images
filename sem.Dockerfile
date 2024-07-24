FROM debian:sid-slim

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

COPY ./ComboLinux64.bin ./
RUN bash -x ./ComboLinux64.bin -i silent && rm ./ComboLinux64.bin
RUN ln -s /opt/mplus/*/mplus /usr/bin/mplus

ENTRYPOINT [ "mplus" ]
