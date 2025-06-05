# Dockerfile
FROM rocker/rstudio:latest

RUN apt-get update && \
    apt-get install -y sudo git && \
    apt-get clean

COPY add_users.sh /usr/local/bin/add_users.sh
COPY users.csv    /etc/rstudio/users.csv
RUN chmod +x /usr/local/bin/add_users.sh

ENTRYPOINT ["/bin/bash", "/usr/local/bin/add_users.sh"]

