FROM postgres:latest

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps sudo

RUN mkdir -p /data/tablespaces      \
 && mkdir -p /data/tablespaces/ts_a \
 && mkdir -p /data/tablespaces/ts_b \
 && mkdir -p /data/tablespaces/ts_c \
 && chown -R postgres:postgres /data 


RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
RUN echo 'export PATH=$PATH:/usr/lib/postgresql/16/bin/' >> /etc/bash.bashrc
RUN echo 'export EDITOR=vim' >> /etc/bash.bashrc
COPY ./motd /etc/motd
COPY ./sudoers.conf /etc/sudoers

