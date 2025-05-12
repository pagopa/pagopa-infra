CREATE OR REPLACE PROCEDURE add_archive_partition(
	)
AS $function$
DECLARE

l_partname TEXT;
l_part_list date;
l_part_listb date;
l_partab TEXT;
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
tProcedureName TEXT:= 'add_archive_partition';
    tab_cursor CURSOR FOR
        SELECT
			nmsp_child.nspname  AS nome_schema,
			sc.NOME_TABELLA AS nome_tabella,
			child.relname       AS nome_partizione
		FROM pg_inherits
			JOIN pg_class parent            ON pg_inherits.inhparent = parent.oid
			JOIN pg_class child             ON pg_inherits.inhrelid   = child.oid
			JOIN pg_namespace nmsp_parent   ON nmsp_parent.oid  = parent.relnamespace
			JOIN pg_namespace nmsp_child    ON nmsp_child.oid   = child.relnamespace
			JOIN partition.STORICO_CONFIG sc ON lower(sc.NOME_TABELLA) = parent.relname AND lower(sc.NOME_SCHEMA) = nmsp_parent.nspname
		WHERE  SUBSTR(child.relname,LENGTH(child.relname)-7,8)!='MINVALUE'
		AND (TO_NUMBER(SUBSTR(child.relname,LENGTH(child.relname)-7,8),'99999999')<
			TO_NUMBER(to_char((CURRENT_DATE-GIORNI_RETENTION), 'yyyymmdd'),'99999999')	)
		AND sc.STATO='Y';

    tNomePartizione TEXT;
    tNomeSchema TEXT;
    tNomeTabella TEXT;

BEGIN

tLabelStep := 'Init';
iIdTrace := nextval('partition.seq_log'::regclass);
INSERT INTO partition.PG_LOG values (iIdTrace,sUtente, tProcedureName, ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','INIZIO',tLabelStep);
RAISE NOTICE 'fuori cursore';
OPEN tab_cursor;
   	LOOP
        FETCH NEXT FROM tab_cursor INTO tNomeSchema,tNomeTabella,tNomePartizione;
        EXIT WHEN NOT FOUND;

------------------------------------------------------------------------------------------------------
  RAISE NOTICE 'nome tabella: %, nome partizione: %', tNomeTabella, tNomePartizione;
--inserisco le partizioni da storicizzare
   IF NOT EXISTS
	  (SELECT *
		 FROM   partition.storico_part
		   WHERE nome_tabella =tNomeTabella and nome_partition=tNomePartizione and nome_schema=tNomeSchema)
	   THEN
      RAISE NOTICE 'partizione non presente in storico_part';
	   INSERT INTO partition.storico_part(
		nome_tabella, nome_schema, nome_partition, stato, insert_date, modification_date, deleting_date)
		VALUES (tNomeTabella, tNomeSchema, tNomePartizione, 'N', NOW(), NULL, NULL);

  	 END IF;
------------------------------------------------------------------------------------------------------

	IF EXISTS
	  (SELECT *
		 FROM   partition.storico_part
		   WHERE nome_tabella =tNomeTabella and  nome_partition=tNomePartizione and nome_schema=tNomeSchema AND STATO='Y') --partizioni storicizzate
	   THEN

	   	  l_sql := format('DROP TABLE %I.%I',  tNomeSchema, tNomePartizione);
		  execute l_sql;

		UPDATE partition.storico_part SET STATO='E', DELETING_DATE=NOW()
		   WHERE nome_tabella =tNomeTabella and nome_partition=tNomePartizione and nome_schema=tNomeSchema AND STATO='Y';

  	 END IF;

 END LOOP;

 CLOSE tab_cursor;

iIdTrace := nextval('partition.seq_log'::regclass);
INSERT INTO partition.PG_LOG values (iIdTrace,sUtente, tProcedureName, ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','FINE','Procedura eseguita con successo');

EXCEPTION
WHEN OTHERS THEN

		iIdTrace := nextval('partition.seq_log'::regclass);
		INSERT INTO partition.PG_LOG values (iIdTrace,sUtente, tProcedureName, ptDataInizio, clock_timestamp(), ( clock_timestamp()- ptDataInizio) ,'KO','FINE',
								  CONCAT('Step:',tLabelStep,' , sqlerrm : ',sqlerrm));

END;
$function$
LANGUAGE 'plpgsql'
;
ALTER PROCEDURE partition.add_archive_partition()
    OWNER TO partition;
GRANT EXECUTE ON PROCEDURE partition.add_archive_partition() TO PUBLIC;
GRANT EXECUTE ON PROCEDURE partition.add_archive_partition() TO azureuser;
GRANT EXECUTE ON PROCEDURE partition.add_archive_partition() TO partition;
