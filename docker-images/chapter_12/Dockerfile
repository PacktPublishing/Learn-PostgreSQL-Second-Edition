FROM postgres:16.0

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps pgxnclient postgresql-contrib postgresql-plperl-16 make postgresql-server-dev-16 gcc

RUN mkdir -p /data/tablespaces      \
 && mkdir -p /src/tagext            \
 && chown -R postgres:postgres /src \
 && chown -R postgres:postgres /data 


RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd

COPY ./sudoers.conf /etc/sudoers

COPY ./tagext /src/tagext
RUN chown -R postgres:postgres /src


RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
