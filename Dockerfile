# Dockerfile
FROM rocker/rstudio:4.5.0


# System package
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        libcurl4-openssl-dev libxml2-dev libssl-dev \
        libharfbuzz-dev libfribidi-dev libglpk40 \
        build-essential && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# CRAN

ENV R_LIBS_SITE=/usr/local/lib/R/site-library
RUN mkdir -p $R_LIBS_SITE && chmod -R 755 $R_LIBS_SITE
RUN install2.r --error --skipinstalled BiocManager tidyverse data.table

# others
RUN Rscript -e "options(Ncpus = parallel::detectCores()); \
    BiocManager::install(c('clusterProfiler','org.Hs.eg.db', 'org.At.tair.db', 'TCC', 'WGCNA'), \
                         ask = FALSE, update = FALSE, \
                         lib = Sys.getenv('R_LIBS_SITE'))"

# user
COPY add_users.sh /usr/local/bin/add_users.sh
COPY users.csv    /etc/rstudio/users.csv
RUN chmod +x /usr/local/bin/add_users.sh
ENTRYPOINT ["/bin/bash", "/usr/local/bin/add_users.sh"]

