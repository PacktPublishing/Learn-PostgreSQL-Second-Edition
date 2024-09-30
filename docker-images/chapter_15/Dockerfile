FROM postgres:16.0

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps 

RUN mkdir -p /data/tablespaces        \
 && chown -R postgres:postgres /data  \
 && mkdir -p /backup/data             \
 && mkdir -p /backup/tablespaces      \
 && chown -R postgres:postgres /backup \
 && chmod -R 700 /backup


RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && export PATH=$PATH:/usr/lib/postgresql/16/bin/' >> /etc/bash.bashrc
COPY motd /etc/motd



RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
