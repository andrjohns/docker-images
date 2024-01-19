FROM rocker/r-devel:latest

RUN apt-get update && apt-get install -y qpdf pandoc
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssh-dev libssl-dev libgit2-dev libxml2-dev git
