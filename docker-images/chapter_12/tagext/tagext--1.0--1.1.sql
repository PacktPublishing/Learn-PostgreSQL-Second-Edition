DROP FUNCTION IF EXISTS tag_path( text );

CREATE OR REPLACE FUNCTION tag_path( tag_to_search text,
                                     delimiter text DEFAULT ' > ' )
RETURNS TEXT
AS $CODE$
DECLARE
  tag_path text;
  current_parent_pk int;
BEGIN

  tag_path = tag_to_search;

  SELECT parent
  INTO   current_parent_pk
  FROM   tags
  WHERE  tag = tag_to_search;

  -- here we must loop
  WHILE current_parent_pk IS NOT NULL LOOP
      SELECT parent, tag || delimiter || tag_path
      INTO   current_parent_pk, tag_path
      FROM   tags
      WHERE  pk = current_parent_pk;
  END LOOP;

  RETURN tag_path;
END
$CODE$
LANGUAGE plpgsql;
