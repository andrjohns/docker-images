FROM ghcr.io/r-wasm/webr:main

RUN Rscript -e 'install.packages("pak")'
RUN Rscript -e 'pak::pak("r-wasm/rwasm")'
