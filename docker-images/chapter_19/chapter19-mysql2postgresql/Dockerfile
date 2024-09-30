FROM postgres:16.0

RUN apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade && apt-get install -y pgloader

RUN echo "Learn PostgreSQL 16" > /etc/motd
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
