-- PROCEDURE: partition.modify_partition_monthly(integer, integer)

CREATE OR REPLACE PROCEDURE partition.modify_partition_monthly(
	IN a integer,
	IN n_month integer)
	SECURITY DEFINER
LANGUAGE 'plpgsql'
AS $BODY$
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
total_months INTEGER;
ptDataInizio timestamp :=  clock_timestamp();
ptDataInizioStep timestamp;
iIdTrace NUMERIC;
sUtente TEXT := USER;
tLabelStep TEXT;
tProcedureName TEXT:= 'modify_partition_monthly';

    tab_cursor CURSOR FOR
        SELECT lower(tabella) as tabella, lower(schema) as schema, lower(prefisso_nome_indice) as prefisso_indice, lower(campi_indice) as campi_indice
        FROM partition.tab_part_monthly;
    tab_record TEXT;
    tab_schema TEXT;

BEGIN

tLabelStep := 'Init';
iIdTrace := nextval('partition.seq_log'::regclass);
INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'modify_partition_monthly', ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','INIZIO',tLabelStep);

IF A is null
	THEN A=1;
END IF;

start_partition := date_trunc('month', CURRENT_DATE + (n_month || ' month')::interval)::date;
total_months := abs(n_month) + a;
for loop_counter in 0..total_months loop

   OPEN tab_cursor;
   	LOOP
        FETCH NEXT FROM tab_cursor INTO tab_record, tab_schema,l_prefisso_indice, l_campi_indice;
        EXIT WHEN NOT FOUND;

------------------------------------------------------------------------------------------------------

IF loop_counter = 0 THEN
    L_PART_LIST  = DATE_TRUNC('MONTH', start_partition - interval '4 years')::DATE;
    L_PART_LISTB = start_partition;
    L_PARTNAME   = tab_record || '_PMINVALUE';
ELSE
    L_PART_LIST  = DATE_TRUNC('MONTH', start_partition + ((loop_counter - 1) || ' month')::INTERVAL)::DATE;
    L_PART_LISTB = DATE_TRUNC('MONTH', start_partition + (loop_counter || ' month')::INTERVAL)::DATE;
    L_PARTNAME   = tab_record || '_P' || TO_CHAR(L_PART_LIST, 'YYYYMM');
END IF;

-- Creazione nome indice
L_INDEX_NAME := l_prefisso_indice || '_' || L_PARTNAME;

-- CREAZIONE PARTIZIONE
IF NOT EXISTS
      ( SELECT 1
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
      BEGIN
          EXECUTE l_sql;
          RAISE NOTICE 'Partizione creata con successo: %', L_PARTNAME;
      EXCEPTION
          WHEN OTHERS THEN
              RAISE NOTICE 'Errore nella creazione della partizione %: %', L_PARTNAME, SQLERRM;
      END;
     END IF;

-- CREAZIONE INDICE
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

END LOOP;

CLOSE tab_cursor;
END LOOP;

iIdTrace := nextval('seq_log'::regclass);
INSERT INTO partition.pg_log values (iIdTrace,sUtente, tProcedureName, ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','FINE','Procedura eseguita con successo');

EXCEPTION
WHEN OTHERS THEN

    iIdTrace := nextval('seq_log'::regclass);
    INSERT INTO PG_LOG values (iIdTrace,sUtente, tProcedureName, ptDataInizio, clock_timestamp(), ( clock_timestamp()- ptDataInizio) ,'KO','FINE',
                  CONCAT('Step:',tLabelStep,' , sqlerrm : ',sqlerrm));

END;
$BODY$;
ALTER PROCEDURE partition.modify_partition_monthly(integer, integer)
    OWNER TO partition;

GRANT EXECUTE ON PROCEDURE partition.modify_partition_monthly(integer, integer) TO PUBLIC;

GRANT EXECUTE ON PROCEDURE partition.modify_partition_monthly(integer, integer) TO partition;
