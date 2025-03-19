CREATE TABLE IF NOT EXISTS partition.STORICO_CONFIG
(
  NOME_TABELLA character varying(50),
  NOME_SCHEMA character varying(50) ,
  GIORNI_RETENTION integer NOT NULL,
  STATO character varying(2)
);


CREATE TABLE IF NOT EXISTS partition.STORICO_PART
(
    NOME_TABELLA character varying(50),
    NOME_SCHEMA character varying(50) ,
	NOME_PARTITION character varying(50) ,
	STATO character varying(2),
	INSERT_DATE timestamp(6),
	MODIFICATION_DATE timestamp(6),
	DELETING_DATE timestamp(6)
);

CREATE SEQUENCE IF NOT EXISTS partition.seq_log
    INCREMENT 1
    START 1
    MINVALUE 1
    MAXVALUE 9223372036854775807
    CACHE 1;


CREATE TABLE IF NOT EXISTS PG_LOG
(
  ID_TRACE NUMERIC DEFAULT nextval('seq_log'::regclass) NOT NULL ,
  UTENTE character varying,
  PROCESSO character varying,
  DATA_INIZIO timestamp without time zone,
  DATA_FINE timestamp without time zone,
  DELTA_TIME INTERVAL,
  ESITO character varying,
  MESSAGGIO character varying,
  NOTE character varying
);

