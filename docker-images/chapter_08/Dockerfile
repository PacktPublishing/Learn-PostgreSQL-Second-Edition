FROM postgres:latest

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps 

RUN mkdir -p /data/tablespaces      \
 && mkdir -p /data/tablespaces/ts_d \
 && mkdir -p /data/tablespaces/ts_e \
 && mkdir -p /data/tablespaces/ts_f \
 && chown -R postgres:postgres /data 


RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
