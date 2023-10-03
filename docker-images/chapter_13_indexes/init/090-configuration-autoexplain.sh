
psql -U postgres -c "ALTER SYSTEM SET logging_collector TO on;" forumdb
psql -U postgres -c "ALTER SYSTEM SET log_destination   TO 'stderr';" forumdb
psql -U postgres -c "ALTER SYSTEM SET log_directory     TO 'log';" forumdb
psql -U postgres -c "ALTER SYSTEM SET log_filename      TO 'postgresql.log';" forumdb
psql -U postgres -c "ALTER SYSTEM SET log_rotation_age  TO '1d';" forumdb
psql -U postgres -c "ALTER SYSTEM SET log_rotation_size TO '50MB';" forumdb

psql -U postgres -c "ALTER SYSTEM SET shared_preload_libraries TO 'auto_explain';" forumdb

psql -U postgres -c "LOAD 'auto_explain';" forumdb
