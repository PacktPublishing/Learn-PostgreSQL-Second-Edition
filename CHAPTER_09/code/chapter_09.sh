bash run-pg-docker.sh chapter9
psql -U forum forumdb
psql -U postgres forumdb
psql -U forum forumdb
gunzip < backup-db-world-temperatures.sql.gz | psql
psql -U postgres world_temperatures

