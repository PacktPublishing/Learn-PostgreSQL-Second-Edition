set -e
psql -U postgres -c "CREATE EXTENSION pg_stat_statements;" forumdb
psql -U postgres -c "CREATE EXTENSION plperl;" forumdb

psql -U postgres -c "ALTER SYSTEM SET shared_preload_libraries TO 'pg_stat_statements';" forumdb


psql -U postgres forumdb <<EOF
CREATE OR REPLACE FUNCTION
public.get_max( a int, b int )
RETURNS int
AS \$CODE\$
BEGIN
   IF a > b THEN
      RETURN a;
   ELSE
     RETURN b;
  END IF;
END
\$CODE\$
LANGUAGE plpgsql;
EOF
