FROM postgres:latest

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps postgresql-contib

RUN mkdir -p /data/tablespaces        \
 && chown -R postgres:postgres /data  



RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && export PATH=$PATH:/usr/lib/postgresql/16/bin/' >> /etc/bash.bashrc
COPY motd /etc/motd



