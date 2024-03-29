FROM andrjohns/revdeps

RUN apt-get update -qq \
  && apt-get install -t unstable -y --no-install-recommends \
    bash-completion \
    bison \
    debhelper \
    default-jdk \
    g++ \
    gcc \
    gdb \
    gfortran \
    groff-base \
    libblas-dev \
    libbz2-dev \
    libcairo2-dev/unstable \
    libcurl4-openssl-dev \
    libjpeg-dev \
    liblapack-dev \
    liblzma-dev \
    libncurses-dev \
    libpango1.0-dev \
    libpcre2-dev \
    libpng-dev \
    libreadline-dev \
    libtiff5-dev \
    libx11-dev \
    libxt-dev \
    mpack \
    subversion \
    tcl-dev \
    texinfo \
    texlive-base \
    texlive-extra-utils \
    texlive-fonts-extra \
    texlive-fonts-recommended \
    texlive-plain-generic \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-latex-recommended \
    tk-dev \
    x11proto-core-dev \
    xauth \
    xdg-utils \
    xfonts-base \
    xvfb \
    zlib1g-dev \
    devscripts

## Check out R-devel
RUN cd /tmp \
&& svn co https://svn.r-project.org/R/trunk R-devel

## Build and install according the standard 'recipe' I emailed/posted years ago
RUN cd /tmp/R-devel \
  && R_PAPERSIZE=letter \
    R_BATCHSAVE="--no-save --no-restore" \
    R_BROWSER=xdg-open \
    PAGER=/usr/bin/pager \
    PERL=/usr/bin/perl \
    R_UNZIPCMD=/usr/bin/unzip \
    R_ZIPCMD=/usr/bin/zip \
    R_PRINTCMD=/usr/bin/lpr \
    LIBnn=lib \
    AWK=/usr/bin/awk \
    CFLAGS=$(R CMD config CFLAGS) \
    CXXFLAGS=$(R CMD config CXXFLAGS) \
    CXX11FLAGS=$(R CMD config CXX11FLAGS) \
    CXX14FLAGS=$(R CMD config CXX14FLAGS) \
    CXX17FLAGS=$(R CMD config CXX17FLAGS) \
  ./configure --enable-R-shlib \
               --without-blas \
               --without-lapack \
               --with-readline \
               --without-recommended-packages \
               --program-suffix=dev \
  && make \
  && make install \
  && rm -rf /tmp/R-devel

## Set default CRAN repo
RUN echo 'options(repos = c(CRAN = "https://cloud.r-project.org/"))' >> /usr/local/lib/R/etc/Rprofile.site

RUN cd /usr/local/bin \
&& mv R Rdevel \
&& mv Rscript Rscriptdevel \
&& ln -s Rdevel RD \
&& ln -s Rscriptdevel RDscript
