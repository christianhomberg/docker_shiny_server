FROM r-base:3.4.1

MAINTAINER Tim Jones "timothy.jones1@amey.co.uk"

# Install dependencies and Download and install shiny server
RUN apt-get update && apt-get install -y -t unstable \
    sudo \
    gdebi-core \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev/unstable \
    libssl-dev \
    libssh2-1-dev \
    libxt-dev && \
    wget --no-verbose "https://download3.rstudio.org/ubuntu-12.04/x86_64/shiny-server-1.5.3.838-amd64.deb" -O ss-stable.deb && \
    gdebi -n ss-stable.deb && \
    rm -f version.txt ss-stable.deb && \
    R -e "install.packages('devtools')"
    #&& \
RUN R -e "devtools::install_version('shiny', version = '1.0.3', repos = 'http://cran.us.r-project.org')" && \
    mkdir /srv/shiny-servers/ && \
    cp -R /usr/local/lib/R/site-library/shiny/examples/* /srv/shiny-servers/ && \
    rm -rf /var/lib/apt/lists/*

EXPOSE 3838

COPY shiny-server.sh /usr/bin/shiny-server.sh

CMD ["/usr/bin/shiny-server.sh"]
