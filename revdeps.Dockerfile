FROM debian:13

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
RUN apt-get update && apt-get install -y apt-utils
RUN apt-get install -y tzdata locales
RUN dpkg-reconfigure locales
RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
RUN echo "LANG=en_US.UTF-8" > /etc/locale.conf
RUN locale-gen en_US.UTF-8

ENV LC_CTYPE="en_US.UTF-8"
ENV LC_TIME="en_US.UTF-8"
ENV LC_MESSAGES="en_US.UTF-8"
ENV LC_MONETARY="en_US.UTF-8"
ENV LC_PAPER="en_US.UTF-8"
ENV LC_MEASUREMENT="en_US.UTF-8"
ENV LC_COLLATE="en_US.UTF-8"
ENV LC_ALL="en_US.UTF-8"

ENV _R_CHECK_FORCE_SUGGESTS_=false
ENV _R_CHECK_CRAN_INCOMING_=false
ENV _R_CHECK_CRAN_INCOMING_REMOTE_=false

RUN apt-get update && apt-get install -y gdb \
    r-base-dev libcurl4-openssl-dev libssh-dev \
    make pandoc libssl-dev zlib1g-dev pari-gp cmake \
    libxml2-dev texlive libfftw3-dev libx11-dev default-jdk \
    libpng-dev libfontconfig1-dev libfreetype6-dev \
    libfribidi-dev libharfbuzz-dev libicu-dev git libglpk-dev \
    jags libjpeg-dev libabsl-dev libudunits2-dev libgdal-dev \
    gdal-bin libgeos-dev libproj-dev libsqlite3-dev libmagick++-dev \
    gsfonts ocl-icd-opencl-dev libgsl0-dev libtiff-dev libwebp-dev \
    libgmp3-dev libmpfr-dev libgit2-dev poppler-data \
    libpoppler-cpp-dev libzmq3-dev libuv1-dev unixodbc-dev \
    libnode-dev chromium libcairo2-dev devscripts qpdf

RUN R CMD javareconf
RUN mkdir -p ~/.R
RUN echo "CXXFLAGS += -w" >> ~/.R/Makevars && \
    echo "CXX17FLAGS += -w" >> ~/.R/Makevars

RUN echo "options(repos = c(CRAN = sprintf('https://packagemanager.posit.co/cran/latest/bin/linux/trixie-%s/%s', R.version['arch'], substr(getRversion(), 1, 3))))" >> ~/.Rprofile
RUN echo "options(repos = c(getOption('repos'), INLA='https://inla.r-inla-download.org/R/stable'))" >> ~/.Rprofile

RUN Rscript -e "                                \
    install.packages('pak');                    \
    pak::pak(c(                                 \
        'INLA',                                 \
        'DESeq2',                               \
        'github::stan-dev/cmdstanr',            \
        'github::ecmerkle/blavsam',             \
        'github::CraigWangStat/eggCountsExtra'  \
    ));                                         \
"
