FROM postgres:16.0

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps iproute2 iputils-ping 

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8

RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY motd /etc/motd



