if [ "$SERVER_NAME" == "pg_fdw1" ]; then
  psql -U forum -c "truncate categories cascade;" forumdb
fi

