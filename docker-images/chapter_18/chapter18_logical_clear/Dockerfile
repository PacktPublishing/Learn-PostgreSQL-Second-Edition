FROM postgres:16.0

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps iputils-ping  

RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

# USER postgres
# WORKDIR /var/lib/postgresql

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
