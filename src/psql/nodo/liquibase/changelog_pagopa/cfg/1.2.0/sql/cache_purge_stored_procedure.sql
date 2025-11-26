-- Procedure for purge old records from cfg.cache table
CREATE OR REPLACE PROCEDURE cfg_cache_purge(
  minimum_records_on_table integer DEFAULT 7,
  start_date date DEFAULT NULL,
  ttl_days integer DEFAULT 7)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE

current_records integer;
deleted_records integer;
analyzed_records integer;

BEGIN

-- Get total count of records before purge process
SELECT COUNT(*) AS record_count
INTO current_records
FROM cfg.cache;

-- If there are a number of records lower than minimum required records,
-- then terminate the process prematurely
IF current_records <= minimum_records_on_table THEN
  RAISE WARNING '[%] Found [%] total records in the table [cfg.cache] (eligible and ineligible for cancellation). Cannot delete records because there must be at least [%] minimum records.', clock_timestamp(), current_records, minimum_records_on_table;
	RETURN;
ELSE
	RAISE INFO '[%] Found [%] total records in the table [cfg.cache] (eligible and ineligible for cancellation), providing at least a minimum of [%] records. Proceeding with delete operation.', clock_timestamp(), current_records, minimum_records_on_table;
END IF;

-- Giving priority to 'start_date' for target execution
IF start_date IS NOT NULL THEN

  -- Counting how many records are lower than passed date, in order to
	-- leave at least a minimum number of records as backup
	SELECT COUNT(*) AS record_count
	INTO analyzed_records
	FROM cfg.cache
	WHERE "time" < start_date;

  -- If the number of records to be deleted does not allow at least a
	-- minimum number of elements to be kept as a backup, the set of elements
	-- to be deleted must be reduced
	IF current_records - analyzed_records < minimum_records_on_table THEN
	  RAISE INFO '[%] Executing delete of records before date [%]. Deleting only [%] of [%] eligible records in order to provide minimum record count ([%])', clock_timestamp(), start_date, current_records - minimum_records_on_table, analyzed_records, minimum_records_on_table;
    DELETE FROM cfg.cache c
		WHERE c.id NOT IN (
      SELECT ca.id
		  FROM cfg.cache ca
		  ORDER BY ca.time DESC
		  LIMIT minimum_records_on_table
		);

  -- The number of records to be deleted leaves a sufficiently large
  -- set of backup records, so delete them all.
  ELSE
    RAISE INFO '[%] Executing delete of [%] records before date [%].', clock_timestamp(), current_records - minimum_records_on_table, start_date;
    DELETE FROM cfg.cache
    WHERE "time" < start_date;
  END IF;

-- Second priority level to 'ttl_days' for target execution
ELSE

  -- Counting how many records are lower than passed interval, in order to
  -- leave at least a minimum number of records as backup
  SELECT COUNT(*) AS record_count
  INTO analyzed_records
  FROM cfg.cache
  WHERE "time" < now() - (interval '1 day' * ttl_days);

      -- If the number of records to be deleted does not allow at least a
      -- minimum number of elements to be kept as a backup, the set of elements
      -- to be deleted must be reduced
  IF current_records - analyzed_records < minimum_records_on_table THEN
    RAISE INFO '[%] Executing delete of records older than [%] days. Deleting only [%] of [%] eligible records in order to provide minimum record count ([%])', clock_timestamp(), ttl_days, current_records - minimum_records_on_table, analyzed_records, minimum_records_on_table;
    DELETE FROM cfg.cache c
    WHERE c.id NOT IN (
      SELECT ca.id
      FROM cfg.cache ca
      ORDER BY ca.time DESC
      LIMIT minimum_records_on_table
    );

  -- The number of records to be deleted leaves a sufficiently large
  -- set of backup records, so delete them all.
  ELSE
    RAISE INFO '[%] Executing delete of [%] records older than [%] days.', clock_timestamp(), analyzed_records, ttl_days;
    DELETE FROM cfg.cache
    WHERE "time" < now() - (interval '1 day' * ttl_days);
  END IF;

END IF;

-- Get the number of deleted records from last executed query
GET DIAGNOSTICS deleted_records = ROW_COUNT;
RAISE INFO '[%] Deleted [%] records from [cfg.cache] table.', clock_timestamp(), deleted_records;

END;
$BODY$;

ALTER PROCEDURE cfg.cfg_cache_purge() OWNER TO cfg;
GRANT EXECUTE ON PROCEDURE cfg.cfg_cache_purge() TO cfg;
