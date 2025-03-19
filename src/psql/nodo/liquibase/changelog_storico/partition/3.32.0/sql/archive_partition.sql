-- PROCEDURE: partition.archive_partition()

-- DROP PROCEDURE IF EXISTS partition.archive_partition();

CREATE OR REPLACE PROCEDURE partition.archive_partition(
	)
LANGUAGE 'plpgsql'
AS $BODY$

DECLARE

l_partname TEXT;
l_part_list date;
l_part_listb date;
l_partab TEXT;
l_sql text;
l_exist text;
l_var_exist integer;
loop_counter INTEGER;

ptDataInizio timestamp :=  clock_timestamp();
ptDataInizioStep timestamp;
iIdTrace NUMERIC;
sUtente         TEXT := USER;

    tab_cursor CURSOR FOR
        SELECT * FROM dblink('conn_db_link', 'SELECT
			NOME_TABELLA,
			NOME_SCHEMA,
			NOME_PARTITION
		FROM partition.storico_part
		WHERE STATO=''N'' ORDER BY 3')
		as t(
		campo1  character varying,
		campo2  character varying,
		campo3  character varying);

    tNomePartizione TEXT;
    tNomeSchema TEXT;
    tNomeTabella TEXT;
	nColumns INTEGER;

	campi_cursor CURSOR FOR
		SELECT column_name, data_type, ordinal_position
		FROM information_schema.columns
		WHERE table_name =tNomeTabella and table_schema =tNomeSchema;

	tNomeColonna TEXT;
	tTipoColonna TEXT;
	tLungColonna TEXT;
	nPosizioneColonna INTEGER;
	tTypeRecord TEXT;
	nColonne INTEGER;
	tLabelStep TEXT;
	resultConnDBLINK TEXT;
--	koConnDBLINK EXCEPTION;
	tMessageRaise TEXT;
	tConnDbLink TEXT;
	esitoUpdate TEXT;
	nRowInsert NUMERIC;
BEGIN

tLabelStep := 'Init';
iIdTrace := nextval('partition.seq_log'::regclass);
INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'archive_partition', ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','INIZIO',tLabelStep);
tMessageRaise:= 'NULLO';

BEGIN
	SELECT elem  into tConnDbLink
FROM  (
    SELECT unnest(dblink_get_connections()::text[]) AS elem
    ) x WHERE ELEM = 'conn_db_link';
EXCEPTION WHEN NO_DATA_FOUND THEN

tConnDbLink := 'NULLO';

END;

IF tConnDbLink != 'conn_db_link' OR tConnDbLink IS NULL THEN
	SELECT dblink_connect('conn_db_link','connsvinodo') into resultConnDBLINK;
ELSE
	resultConnDBLINK = 'OK';
END IF;

if resultConnDBLINK = 'OK' THEN

	OPEN tab_cursor;
		LOOP
			FETCH NEXT FROM tab_cursor INTO tNomeTabella,tNomeSchema,tNomePartizione;
			EXIT WHEN NOT FOUND;

	------------------------------------------------------------------------------------------------------
			--costruisco il type del record da copiare
	tLabelStep := concat('nColonne - tNomeTabella:',tNomeTabella,' - tNomeSchema',tNomeSchema);
		SELECT COUNT(*) into nColonne
		FROM information_schema.columns
		WHERE table_name =tNomeTabella and table_schema =tNomeSchema;

	tTypeRecord := NULL;

	tLabelStep := 'OPEN campi_cursor';
		OPEN campi_cursor;
			LOOP
				FETCH NEXT FROM campi_cursor INTO tNomeColonna,tTipoColonna,nPosizioneColonna;
				EXIT WHEN NOT FOUND;

				tLabelStep :=concat(tLabelStep,' - PosizioneColonna',nPosizioneColonna);
				tTypeRecord := concat(tTypeRecord,tNomeColonna,' ',tTipoColonna);

				IF nColonne != nPosizioneColonna THEN
					tTypeRecord := concat(tTypeRecord,', ');
				END IF;

		END LOOP;

	 CLOSE campi_cursor;

	 /*	call online.PR_LOG(ptProcesso => CAST('archive_partition' AS TEXT),
			   ptDataInizio => now(),
			   ptEsito => CAST('OK' AS TEXT),
			   ptMessaggio => CAST(tTypeRecord AS TEXT),
			   ptNote => CAST('STEP pre-insert' AS TEXT));
			   */
	--copio i dati della partizione
	ptDataInizioStep :=clock_timestamp();
	 tLabelStep := concat('INSERT - NomePartizione:', tNomePartizione, ', NomeSchema:',tNomeSchema);
			l_sql := format('INSERT INTO %I.%I SELECT * FROM dblink(''conn_db_link'', ''SELECT * FROM %I.%I'')
							as t(%s)',  tNomeSchema, tNomePartizione, tNomeSchema, tNomePartizione, tTypeRecord );

			execute l_sql;
	 GET DIAGNOSTICS nRowInsert = ROW_COUNT;
	 iIdTrace := nextval('partition.seq_log'::regclass);
	 INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'archive_partition', ptDataInizioStep, clock_timestamp(), (clock_timestamp()- ptDataInizioStep) ,'OK','STEP INSERT',CONCAT(tLabelStep,' - nRowInsert=',nRowInsert));

	------------------------------------------------------------------------------------------------------
	-- AGGIORNO LA TABELLA STORICO_PART per settare che la storicizzazione è avvenuta
	tLabelStep := concat('UPDATE - NomePartizione:', tNomePartizione, ', NomeSchema:',tNomeSchema);
	ptDataInizioStep :=clock_timestamp();
	SELECT * into esitoUpdate
			FROM dblink('conn_db_link', 'UPDATE partition.storico_part SET STATO=''Y'', MODIFICATION_DATE=NOW()
						 WHERE nome_tabella ='''||tNomeTabella||
						 ''' AND nome_partition ='''||tNomePartizione||
						 ''' AND nome_schema ='''||tNomeSchema||
						 ''' AND STATO=''N''') tt(
     		updated text);

	iIdTrace := nextval('partition.seq_log'::regclass);
	 INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'archive_partition', ptDataInizioStep, clock_timestamp(), (clock_timestamp()- ptDataInizioStep) ,'OK','STEP UPDATE',tLabelStep||' - '||esitoUpdate);

	 END LOOP;

	 CLOSE tab_cursor;

		/*call online.PR_LOG(ptProcesso => CAST('archive_partition' AS TEXT),
			   ptDataInizio => now(),
			   ptEsito => CAST('OK' AS TEXT),
			   ptMessaggio => CAST('FINE' AS TEXT),
			   ptNote => CAST(l_sql AS TEXT));
			   */

		iIdTrace := nextval('partition.seq_log'::regclass);
		INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'archive_partition', ptDataInizio, clock_timestamp(), (clock_timestamp()- ptDataInizio) ,'OK','FINE','Procedura eseguita con successo');

ELSE

--	RAISE EXCEPTION koConnDBLINK;
tMessageRaise:= 'Errore connessione DBlink';
RAISE;

END IF;

EXCEPTION
WHEN OTHERS THEN

		iIdTrace := nextval('partition.seq_log'::regclass);
		INSERT INTO partition.pg_log values (iIdTrace,sUtente, 'archive_partition', ptDataInizio, clock_timestamp(), ( clock_timestamp()- ptDataInizio) ,'KO','FINE',
								  CONCAT('Step:',tLabelStep,' , Message : ',tMessageRaise,' , tConnDbLink : ',tConnDbLink,', sqlerrm : ',sqlerrm));

END;
$BODY$
;

ALTER PROCEDURE partition.archive_partition()
    OWNER TO partition;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO PUBLIC;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO azureuser;

GRANT EXECUTE ON PROCEDURE partition.archive_partition() TO partition;
