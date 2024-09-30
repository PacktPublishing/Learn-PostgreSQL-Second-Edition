FROM postgres:16.0

RUN apt-get update \
 && apt-get install -y net-tools vim sudo less emacs-nox procps pgbadger lighttpd nmap postgresql-16-pgaudit cron

RUN mkdir -p /data/tablespaces        \
 && chown -R postgres:postgres /data  \
 && mkdir -p /data/html               \
 && chown -R postgres:www-data /data/html 


RUN echo "Learn PostgreSQL 16" > /etc/motd

RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && cat /etc/motd' >> /etc/bash.bashrc
COPY ./motd /etc/motd

# start web server
COPY ./lighthttpd.conf /etc/lighttpd/lighttpd.conf


RUN echo "*/5 * * * *  /usr/bin/pgbadger -I -f stderr -O /data/html /postgres/16/data/log/*.log" | crontab -u postgres -

COPY ./start_services.sh /usr/local/bin
RUN chmod 755 /usr/local/bin/start_services.sh
RUN echo '/usr/local/bin/start_services.sh'  >> /etc/bash.bashrc

COPY ./sudoers.conf /etc/sudoers
RUN chmod 110 /etc/sudoers
RUN chown root:root /etc/sudoers

RUN echo en_US.UTF-8 UTF-8 > /etc/locale.gen
RUN locale-gen en_US.UTF-8
