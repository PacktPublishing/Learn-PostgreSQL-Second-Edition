#!/bin/sh

for what in $(echo lighttpd cron ); do
    service $what status >/dev/null 2>&1
    if [ $? != 0 ]; then
	sudo service $what restart > /dev/null 2>&1
    fi
done


# do a initial pgbadger run so the user has not to wait
# five minutes for the first update
/usr/bin/pgbadger -I -f stderr -O /data/html /postgres/16/data/log/*.log > /dev/null 2>&1
