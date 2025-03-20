-- PROCEDURE: partition.modify_partition(integer, integer)

-- DROP PROCEDURE IF EXISTS partition.modify_partition(integer, integer);

CREATE OR REPLACE PROCEDURE partition.modify_partition(
	a integer,
	n_day integer)
LANGUAGE 'plpgsql'
AS $BODY$

--	10,1 da domani fino a 10 giorni -> creo solo 9 partizioni
--	10, -1 parto da ieri -> creo 11 partizioni
--	10,0 funziona come prima
DECLARE

l_partname TEXT;
l_part_list date;
l_part_listb date;
l_partab TEXT;
L_INDEX_NAME TEXT;
l_campi_indice TEXT;
l_prefisso_indice TEXT;
l_sql text;
l_exist text;
l_var_exist integer;
loop_counter INTEGER;

start_partition date;
ptDataInizio timestamp :=  clock_timestamp();
ptDataInizioStep timestamp;
iIdTrace NUMERIC;
sUtente         TEXT := USER;
tLabelStep TEXT;

    tab_cursor CURSOR FOR
        SELECT lower(tabella) as tabella, lower(schema) as schema, lower(prefisso_nome_indice) as prefisso_indice, lower(campi_indice) as campi_indice
        FROM partition.TAB_PART;
    tab_record TEXT;
    tab_schema TEXT;

BEGIN

tLabelStep := 'Init';
iIdTrace := nextval('partition.seq_log'::regclass);
INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'modify_partition', ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','INIZIO',tLabelStep);

IF A is null
	THEN A=1;
END IF;

start_partition := CURRENT_DATE+n_day;

for loop_counter in 0..a-n_day loop

   OPEN tab_cursor;
   	LOOP
        FETCH NEXT FROM tab_cursor INTO tab_record, tab_schema,l_prefisso_indice, l_campi_indice;
        EXIT WHEN NOT FOUND;

------------------------------------------------------------------------------------------------------

IF loop_counter=0 THEN
  L_PART_LIST  = DATE_TRUNC('DAY', start_partition+loop_counter-1500)::DATE;
  L_PART_LISTB = DATE_TRUNC('DAY', start_partition+loop_counter+1)::DATE;
  L_PARTNAME  := TAB_RECORD||'_PMINVALUE';
ELSE
  L_PART_LIST = date_trunc('day', start_partition+loop_counter)::date;
  L_PART_LISTB = date_trunc('day', start_partition+loop_counter+1)::date;
  L_PARTNAME := tab_record||'_P'||to_char(start_partition+loop_counter, 'yyyymmdd');
END IF;

  L_INDEX_NAME := l_prefisso_indice||'_'||L_PARTNAME;

   IF NOT EXISTS
	  (SELECT 1
		 FROM   information_schema.tables
		   WHERE  table_name=l_partname and table_schema=tab_schema
	  union all
	SELECT
    1
	FROM pg_inherits
    JOIN pg_class parent            ON pg_inherits.inhparent = parent.oid
    JOIN pg_class child             ON pg_inherits.inhrelid   = child.oid
    JOIN pg_namespace nmsp_parent   ON nmsp_parent.oid  = parent.relnamespace
    JOIN pg_namespace nmsp_child    ON nmsp_child.oid   = child.relnamespace
	WHERE child.relname=l_partname and nmsp_child.nspname =tab_schema
	  )
	   THEN

		  l_sql := format('CREATE TABLE  %I.%I PARTITION OF %I.%I FOR VALUES FROM (%L) TO (%L)',  tab_schema, l_partname,  tab_schema, tab_record, l_part_list, l_part_listb);
		  execute l_sql;

  	 END IF;

	IF NOT EXISTS
				(SELECT *
				FROM pg_stat_all_indexes
				WHERE  indexrelname=L_INDEX_NAME and schemaname=tab_schema)
				THEN
					  if l_campi_indice is not null then
				l_sql := format('CREATE UNIQUE INDEX %I ON %I.%I USING BTREE(%s)',  L_INDEX_NAME,  tab_schema, l_partname, l_campi_indice);
				execute l_sql;
		  end if;
  	 END IF;
------------------------------------------------------------------------------------------------------

 END LOOP;

 CLOSE tab_cursor;

END LOOP;

		iIdTrace := nextval('partition.seq_log'::regclass);
		INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'modify_partition', ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','FINE','Procedura eseguita con successo');
EXCEPTION
WHEN OTHERS THEN

		iIdTrace := nextval('partition.seq_log'::regclass);
		INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'modify_partition', ptDataInizio, clock_timestamp(), ( clock_timestamp()- ptDataInizio) ,'KO','FINE',
								  CONCAT('Step:',tLabelStep,' , sqlerrm : ',sqlerrm));

END;
$BODY$
;

ALTER PROCEDURE partition.modify_partition(integer, integer)
    OWNER TO partition;

GRANT EXECUTE ON PROCEDURE partition.modify_partition(integer, integer) TO PUBLIC;

GRANT EXECUTE ON PROCEDURE partition.modify_partition(integer, integer) TO azureuser;

GRANT EXECUTE ON PROCEDURE partition.modify_partition(integer, integer) TO partition;
