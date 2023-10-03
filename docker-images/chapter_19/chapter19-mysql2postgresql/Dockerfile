FROM postgres:latest

RUN apt-get update -y && apt-get upgrade -y && apt-get dist-upgrade && apt-get install -y pgloader

RUN echo "Learn PostgreSQL 16" > /etc/motd
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd
