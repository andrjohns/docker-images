FROM rocker/r-devel:latest

RUN apt-get update && apt-get install -y qpdf pandoc
