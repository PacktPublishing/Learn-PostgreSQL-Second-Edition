set -e
psql -U postgres -c "alter role postgres password 'LearnPostgreSQL'" postgres
psql -U postgres -c "create role luca with login password  'LearnPostgreSQL' connection limit 1" postgres
psql -U postgres -c "create role enrico with login password 'LearnPostgreSQL'" postgres


psql -U postgres -c "create role book_authors with nologin;" postgres
psql -U postgres -c "create role forum_admins with nologin;" postgres
psql -U postgres -c "create role forum_stats with nologin;" postgres

psql -U postgres -c "grant book_authors to luca" postgres
psql -U postgres -c "grant forum_stats to luca" postgres
psql -U postgres -c "grant book_authors to enrico" postgres
psql -U postgres -c "grant forum_admins to enrico" postgres
