CREATE TABLE IF NOT EXISTS ${schema}.rendicontazione_sftp_receive_queue_parted
(
  id numeric NOT NULL DEFAULT nextval('${schema}.rendicontazione_sftp_receive_queue_seq'::regclass),
  file_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
  status character varying(10) COLLATE pg_catalog."default" NOT NULL,
  file_size numeric(19,0),
  server_id numeric(19,0) NOT NULL,
  host_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
  port numeric(19,0) NOT NULL,
  path character varying(255) COLLATE pg_catalog."default" NOT NULL,
  hash character varying(32) COLLATE pg_catalog."default" NOT NULL,
  content bytea NOT NULL,
  sender character varying(50) COLLATE pg_catalog."default",
  receiver character varying(50) COLLATE pg_catalog."default",
  inserted_timestamp timestamp(6) without time zone NOT NULL,
  updated_timestamp timestamp(6) without time zone NOT NULL,
  inserted_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  updated_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  CONSTRAINT rendicontazione_sftp_receive_queue_parted_pk PRIMARY KEY (id,inserted_timestamp)
  ) partition by range ("inserted_timestamp");


--

CREATE TABLE IF NOT EXISTS ${schema}.rendicontazione_sftp_send_queue_parted
(
  id numeric NOT NULL DEFAULT nextval('${schema}.rendicontazione_sftp_send_queue_seq'::regclass),
  file_name character varying(255) COLLATE pg_catalog."default" NOT NULL,
  status character varying(10) COLLATE pg_catalog."default" NOT NULL,
  file_size numeric(19,0),
  server_id numeric(19,0) NOT NULL,
  host_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
  port numeric(19,0) NOT NULL,
  path character varying(255) COLLATE pg_catalog."default" NOT NULL,
  hash character varying(32) COLLATE pg_catalog."default" NOT NULL,
  content bytea NOT NULL,
  sender character varying(50) COLLATE pg_catalog."default",
  receiver character varying(50) COLLATE pg_catalog."default",
  inserted_timestamp timestamp(6) without time zone NOT NULL,
  updated_timestamp timestamp(6) without time zone NOT NULL,
  inserted_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  updated_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  retry numeric(19,0),
  CONSTRAINT rendicontazione_sftp_send_queue_parted_pk PRIMARY KEY (id,inserted_timestamp)
  ) partition by range ("inserted_timestamp");
