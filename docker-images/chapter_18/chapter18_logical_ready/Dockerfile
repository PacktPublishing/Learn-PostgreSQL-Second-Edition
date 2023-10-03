FROM postgres:latest

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps 

RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

# USER postgres
# WORKDIR /var/lib/postgresql

