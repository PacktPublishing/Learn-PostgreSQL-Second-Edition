FROM postgres:latest

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps 

RUN mkdir -p /data/tablespaces      \
 && mkdir -p /data/tablespaces/ts_a \
 && mkdir -p /data/tablespaces/ts_b \
 && mkdir -p /data/tablespaces/ts_c \
 && chown -R postgres:postgres /data 

RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

