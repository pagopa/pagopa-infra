-- PROCEDURE: partition.archive_partition()

CREATE OR REPLACE PROCEDURE partition.archive_partition(
	)
LANGUAGE 'plpgsql'
AS $BODY$
  DECLARE
    l_partname text;
    l_part_list  DATE;
    l_part_listb DATE;
    l_partab text;
    l_sql text;
    l_exist text;
    l_var_exist  INTEGER;
    loop_counter INTEGER;
    ptdatainizio timestamp := clock_timestamp();
    ptdatainiziostep timestamp;
    iidtrace NUMERIC;
    sutente text := USER;
    tab_cursor
    CURSOR FOR
      SELECT *
      FROM   dblink('conn_db_link', 'SELECT NOME_TABELLA, NOME_SCHEMA, NOME_PARTITION FROM partition.storico_part WHERE STATO=''N'' AND nome_partition LIKE ''%_P________'' ORDER BY 3') AS t( campo1 CHARACTER varying, campo2 CHARACTER varying, campo3 CHARACTER varying);

tnomepartizione text;
tnomeschema text;
tnometabella text;
ncolumns INTEGER;
campi_cursor
CURSOR FOR
  SELECT column_name,
         data_type,
         ordinal_position
  FROM   information_schema.COLUMNS
  WHERE  table_name =tnometabella
  AND    table_schema =tnomeschema;

tnomecolonna text;
ttipocolonna text;
tlungcolonna text;
nposizionecolonna INTEGER;
ttyperecord text;
ncolonne INTEGER;
tlabelstep text;
resultconndblink text;
-- koConnDBLINK EXCEPTION;
tmessageraise text;
tconndblink text;
esitoupdate text;
nrowinsert NUMERIC;
BEGIN
  tlabelstep := 'Init';
  iidtrace := NEXTVAL('partition.seq_log'::regclass);
  INSERT INTO PARTITION.pg_log VALUES
              (
                          iidtrace,
                          sutente,
                          'archive_partition',
                          ptdatainizio,
                          clock_timestamp(),
                          (clock_timestamp()- ptdatainizio) ,
                          'OK',
                          'INIZIO',
                          tlabelstep
              );

  tmessageraise:= 'NULLO';
  BEGIN
    SELECT elem
    INTO   tconndblink
    FROM   (
                  SELECT unnest(dblink_get_connections()::text[]) AS elem ) x
    WHERE  elem = 'conn_db_link';

  EXCEPTION
  WHEN no_data_found THEN
    tconndblink := 'NULLO';
  END;
  IF tconndblink != 'conn_db_link'
    OR
    tconndblink IS NULL THEN
    RAISE notice 'connessione non presente: creo';
    SELECT dblink_connect('conn_db_link','connsvinodo')
    INTO   resultconndblink;

  ELSE
    RAISE notice 'connessione presente';
    resultconndblink = 'OK';
  END IF;
  RAISE notice 'connessione: %', resultconndblink;
  IF resultconndblink = 'OK' THEN
    OPEN tab_cursor;
    LOOP
      FETCH NEXT
      FROM  tab_cursor
      INTO  tnometabella,
            tnomeschema,
            tnomepartizione;

      EXIT
    WHEN NOT FOUND;
      ------------------------------------------------------------------------------------------------------
      RAISE notice 'nome tabella: %, nome partizione: %', tnometabella, tnomepartizione;
      --costruisco il type del record da copiare
      tlabelstep := concat('nColonne - tNomeTabella:',tnometabella,' - tNomeSchema',tnomeschema);
      SELECT count(*)
      INTO   ncolonne
      FROM   information_schema.COLUMNS
      WHERE  table_name =tnometabella
      AND    table_schema =tnomeschema;

      ttyperecord := NULL;
      tlabelstep := 'OPEN campi_cursor';
      OPEN campi_cursor;
      LOOP
        FETCH NEXT
        FROM  campi_cursor
        INTO  tnomecolonna,
              ttipocolonna,
              nposizionecolonna;

        EXIT
      WHEN NOT FOUND;
        tlabelstep :=concat(tlabelstep,' - PosizioneColonna',nposizionecolonna);
        ttyperecord := concat(ttyperecord,tnomecolonna,' ',ttipocolonna);
        IF ncolonne != nposizionecolonna THEN
			RAISE notice 'ncolonne != poscolonna';
          ttyperecord := concat(ttyperecord,', ');
        END IF;
      END LOOP;
      CLOSE campi_cursor;
      /* call online.PR_LOG(ptProcesso => CAST('archive_partition' AS TEXT),
ptDataInizio => now(),
ptEsito => CAST('OK' AS TEXT),
ptMessaggio => CAST(tTypeRecord AS TEXT),
ptNote => CAST('STEP pre-insert' AS TEXT));
*/
      --copio i dati della partizione
      ptdatainiziostep :=clock_timestamp();
      tlabelstep := concat('INSERT - NomePartizione:', tnomepartizione, ', NomeSchema:',tnomeschema);
      l_sql := format('INSERT INTO %I.%I SELECT * FROM dblink(''conn_db_link'', ''SELECT * FROM %I.%I'') as t(%s)', tnomeschema, tnomepartizione, tnomeschema, tnomepartizione, ttyperecord );
      RAISE notice 'sql: %', l_sql;
      EXECUTE l_sql;
      GET diagnostics nrowinsert = row_count;
      iidtrace := NEXTVAL('partition.seq_log'::regclass);
      INSERT INTO PARTITION.pg_log VALUES
                  (
                              iidtrace,
                              sutente,
                              'archive_partition',
                              ptdatainiziostep,
                              clock_timestamp(),
                              (clock_timestamp()- ptdatainiziostep) ,
                              'OK',
                              'STEP INSERT',
                                          concat(tlabelstep,' - nRowInsert=',nrowinsert)
                  );

      RAISE notice 'nRowInsert: %', nrowinsert;
      ------------------------------------------------------------------------------------------------------
      -- AGGIORNO LA TABELLA STORICO_PART per settare che la storicizzazione è avvenuta
      tlabelstep := concat('UPDATE - NomePartizione:', tnomepartizione, ', NomeSchema:',tnomeschema);
      ptdatainiziostep :=clock_timestamp();
      RAISE notice 'update sql: UPDATE partition.storico_part SET STATO=''Y'', MODIFICATION_DATE=NOW() WHERE nome_tabella =''%'' AND nome_partition =''%'' AND nome_schema =''%'' AND STATO=''N''', tnometabella, tnomepartizione, tnomeschema;
      SELECT *
      INTO   esitoupdate
      FROM   dblink('conn_db_link', 'UPDATE partition.storico_part SET STATO=''Y'', MODIFICATION_DATE=NOW()  WHERE nome_tabella ='''
                    ||tnometabella
                    || ''' AND nome_partition ='''
                    ||tnomepartizione
                    || ''' AND nome_schema ='''
                    ||tnomeschema
                    || ''' AND STATO=''N''') tt( updated text);

      iidtrace := NEXTVAL('partition.seq_log'::regclass);
      INSERT INTO PARTITION.pg_log VALUES
                  (
                              iidtrace,
                              sutente,
                              'archive_partition',
                              ptdatainiziostep,
                              clock_timestamp(),
                              (clock_timestamp()- ptdatainiziostep) ,
                              'OK',
                              'STEP UPDATE',
                              tlabelstep
                                          ||' - '
                                          ||esitoupdate
                  );

      RAISE notice 'esitoUpdate: %', esitoupdate;
    END LOOP;
    CLOSE tab_cursor;
    /*call online.PR_LOG(ptProcesso => CAST('archive_partition' AS TEXT),
ptDataInizio => now(),
ptEsito => CAST('OK' AS TEXT),
ptMessaggio => CAST('FINE' AS TEXT),
ptNote => CAST(l_sql AS TEXT));
*/
    iidtrace := NEXTVAL('partition.seq_log'::regclass);
    INSERT INTO PARTITION.pg_log VALUES
                (
                            iidtrace,
                            sutente,
                            'archive_partition',
                            ptdatainizio,
                            clock_timestamp(),
                            (clock_timestamp()- ptdatainizio) ,
                            'OK',
                            'FINE',
                            'Procedura eseguita con successo'
                );

  ELSE
    -- RAISE EXCEPTION koConnDBLINK;
    tmessageraise:= 'Errore connessione DBlink';
    RAISE;
  END IF;
EXCEPTION
WHEN OTHERS THEN
  iidtrace := NEXTVAL('partition.seq_log'::regclass);
  INSERT INTO PARTITION.pg_log VALUES
              (
                          iidtrace,
                          sutente,
                          'archive_partition',
                          ptdatainizio,
                          clock_timestamp(),
                          ( clock_timestamp()- ptdatainizio) ,
                          'KO',
                          'FINE',
                                      concat('Step:',tlabelstep,' , Message : ',tmessageraise,' , tConnDbLink : ',tconndblink,', sqlerrm : ',SQLERRM)
              );

END;
$BODY$;
ALTER PROCEDURE partition.archive_partition()
    OWNER TO partition;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO PUBLIC;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO azureuser;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO partition;

