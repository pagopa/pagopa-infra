CREATE TABLE IF NOT EXISTS ${schema}.carrello_rpt_parted
(
  obj_id numeric NOT NULL DEFAULT nextval('${schema}.carrello_rpt_seq'::regclass),
  id_carrello character varying(35) COLLATE pg_catalog."default",
  codice_carrello character varying(128) COLLATE pg_catalog."default",
  staz_intermediariopa character varying(35) COLLATE pg_catalog."default",
  intermediariopa character varying(35) COLLATE pg_catalog."default",
  canale character varying(35) COLLATE pg_catalog."default",
  intermediariopsp character varying(35) COLLATE pg_catalog."default",
  psp character varying(35) COLLATE pg_catalog."default",
  id_sessione character varying(100) COLLATE pg_catalog."default" NOT NULL,
  parametri_pagamento_immediato character varying(255) COLLATE pg_catalog."default",
  parametri_profilo_pagamento character varying(255) COLLATE pg_catalog."default",
  url_redirezione_pa character varying(255) COLLATE pg_catalog."default",
  url_redirezione_psp character varying(255) COLLATE pg_catalog."default",
  stato character varying(20) COLLATE pg_catalog."default" NOT NULL,
  return_code character varying(10) COLLATE pg_catalog."default",
  esito_redirect character varying(50) COLLATE pg_catalog."default",
  tipo_interazione character varying(255) COLLATE pg_catalog."default",
  mobile_token character varying(255) COLLATE pg_catalog."default",
  rrn character varying(255) COLLATE pg_catalog."default",
  esito_transazione_carta character varying(35) COLLATE pg_catalog."default",
  codice_autorizzativo character varying(6) COLLATE pg_catalog."default",
  parametri_pm character varying(255) COLLATE pg_catalog."default",
  timestamp_operazione timestamp(6) without time zone,
  importo_totale_pagato numeric(19,0),
  inserted_timestamp timestamp(6) without time zone NOT NULL,
  inserted_by character varying(35) COLLATE pg_catalog."default" NOT NULL DEFAULT 'INSERTED_BY'::character varying,
  updated_timestamp timestamp(6) without time zone NOT NULL,
  updated_by character varying(35) COLLATE pg_catalog."default" NOT NULL DEFAULT 'UPDATED_BY'::character varying,
  CONSTRAINT carrello_rpt_parted_pk PRIMARY KEY (obj_id,inserted_timestamp)
  ) partition by range ("inserted_timestamp");

CREATE UNIQUE INDEX IF NOT EXISTS nodo_online_carrello_parted_idx1_uni ON ${schema}.carrello_rpt_parted USING btree(parametri_pagamento_immediato, psp, codice_carrello,inserted_timestamp);

-- Index: carrello_rpt_idx01

-- DROP INDEX IF EXISTS ${schema}.carrello_rpt_idx01;

CREATE INDEX IF NOT EXISTS carrello_rpt_parted_idx01
  ON ${schema}.carrello_rpt_parted USING btree
  (id_sessione COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: carrello_rpt_idx02

-- DROP INDEX IF EXISTS ${schema}.carrello_rpt_idx02;

CREATE INDEX IF NOT EXISTS carrello_rpt_parted_idx02
  ON ${schema}.carrello_rpt_parted USING btree
  (parametri_pagamento_immediato COLLATE pg_catalog."default" ASC NULLS LAST, psp COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: carrello_rpt_idx03

-- DROP INDEX IF EXISTS ${schema}.carrello_rpt_idx03;

CREATE INDEX IF NOT EXISTS carrello_rpt_parted_idx03
  ON ${schema}.carrello_rpt_parted USING btree
  (codice_carrello COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: carrello_rpt_idx04

-- DROP INDEX IF EXISTS ${schema}.carrello_rpt_idx04;

CREATE INDEX IF NOT EXISTS carrello_rpt_parted_idx04
  ON ${schema}.carrello_rpt_parted USING btree
  (id_carrello COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: nodo_online_carrello_idx1

-- DROP INDEX IF EXISTS ${schema}.nodo_online_carrello_idx1;

CREATE UNIQUE INDEX IF NOT EXISTS nodo_online_carrello_parted_idx1
  ON ${schema}.carrello_rpt_parted USING btree
  (parametri_pagamento_immediato COLLATE pg_catalog."default" ASC NULLS LAST, psp COLLATE pg_catalog."default" ASC NULLS LAST, codice_carrello COLLATE pg_catalog."default" ASC NULLS LAST,inserted_timestamp);

--

CREATE TABLE IF NOT EXISTS ${schema}.redirect_my_bank_parted
(
  obj_id numeric NOT NULL DEFAULT nextval('${schema}.redirect_my_bank_seq'::regclass),
  id_dominio character varying(35) COLLATE pg_catalog."default",
  iuv character varying(35) COLLATE pg_catalog."default",
  ccp character varying(35) COLLATE pg_catalog."default",
  numero_ordine character varying(50) COLLATE pg_catalog."default",
  descr_ordine character varying(140) COLLATE pg_catalog."default",
  codice_mybank character varying(35) COLLATE pg_catalog."default",
  id_negozio character varying(15) COLLATE pg_catalog."default",
  importo numeric(10,0),
  chiave_avvio character varying(255) COLLATE pg_catalog."default",
  chiave_esito character varying(255) COLLATE pg_catalog."default",
  mac_richiesta character varying(100) COLLATE pg_catalog."default",
  mac_esito character varying(100) COLLATE pg_catalog."default",
  esito_ms character varying(255) COLLATE pg_catalog."default",
  aut character varying(35) COLLATE pg_catalog."default",
  bpw_tipo_transazione character varying(255) COLLATE pg_catalog."default",
  id_trans character varying(25) COLLATE pg_catalog."default",
  stato_sitord character varying(255) COLLATE pg_catalog."default",
  esito_sitord character varying(255) COLLATE pg_catalog."default",
  reqrefnum character varying(32) COLLATE pg_catalog."default",
  stato_pagamento character varying(100) COLLATE pg_catalog."default",
  url_situazione_ordine character varying(255) COLLATE pg_catalog."default",
  redirect_rpt numeric,
  redirect_carrello numeric,
  timestamp_esito timestamp(6) without time zone,
  inserted_timestamp timestamp(6) without time zone NOT NULL,
  inserted_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  updated_timestamp timestamp(6) without time zone NOT NULL,
  updated_by character varying(35) COLLATE pg_catalog."default" NOT NULL,
  CONSTRAINT redirect_my_bank_parted_pk PRIMARY KEY (obj_id,inserted_timestamp),
  CONSTRAINT redirect_my_bank_fk_carrello_rpt_parted FOREIGN KEY (redirect_carrello)
  REFERENCES ${schema}.carrello_rpt (obj_id) MATCH SIMPLE
                               ON UPDATE RESTRICT
                               ON DELETE RESTRICT,
  CONSTRAINT redirect_mybank_fk_rpt_parted FOREIGN KEY (redirect_rpt)
  REFERENCES ${schema}.rpt (obj_id) MATCH SIMPLE
                               ON UPDATE RESTRICT
                               ON DELETE RESTRICT
  ) partition by range ("inserted_timestamp");

--

CREATE TABLE IF NOT EXISTS ${schema}.rpt_parted
(
  obj_id numeric NOT NULL DEFAULT nextval('${schema}.rpt_seq'::regclass),
  id_dominio character varying(35) COLLATE pg_catalog."default" NOT NULL,
  iuv character varying(35) COLLATE pg_catalog."default" NOT NULL,
  ccp character varying(35) COLLATE pg_catalog."default" NOT NULL,
  codice_carrello character varying(128) COLLATE pg_catalog."default",
  staz_intermediariopa character varying(35) COLLATE pg_catalog."default",
  intermediariopa character varying(35) COLLATE pg_catalog."default",
  canale character varying(35) COLLATE pg_catalog."default",
  intermediariopsp character varying(35) COLLATE pg_catalog."default",
  psp character varying(35) COLLATE pg_catalog."default",
  id_sessione character varying(100) COLLATE pg_catalog."default" NOT NULL,
  parametri_pagamento_immediato character varying(255) COLLATE pg_catalog."default",
  parametri_profilo_pagamento character varying(255) COLLATE pg_catalog."default",
  url_redirezione_pa character varying(255) COLLATE pg_catalog."default",
  url_redirezione_psp character varying(255) COLLATE pg_catalog."default",
  stato character varying(20) COLLATE pg_catalog."default" NOT NULL,
  return_code character varying(10) COLLATE pg_catalog."default",
  esito_redirect character varying(50) COLLATE pg_catalog."default",
  tipo_interazione character varying(255) COLLATE pg_catalog."default",
  mobile_token character varying(255) COLLATE pg_catalog."default",
  rrn character varying(255) COLLATE pg_catalog."default",
  esito_transazione_carta character varying(35) COLLATE pg_catalog."default",
  codice_autorizzativo character varying(6) COLLATE pg_catalog."default",
  parametri_pm character varying(255) COLLATE pg_catalog."default",
  timestamp_operazione timestamp(6) without time zone,
  importo_totale_pagato numeric(19,0),
  inserted_timestamp timestamp(6) without time zone NOT NULL,
  inserted_by character varying(35) COLLATE pg_catalog."default" NOT NULL DEFAULT 'INSERTED_BY'::character varying,
  updated_timestamp timestamp(6) without time zone NOT NULL,
  updated_by character varying(35) COLLATE pg_catalog."default" NOT NULL DEFAULT 'UPDATED_BY'::character varying,
  CONSTRAINT rpt_parted_pk PRIMARY KEY (obj_id,inserted_timestamp)
  ) partition by range ("inserted_timestamp");

CREATE UNIQUE INDEX IF NOT EXISTS nodo_online_rpt_parted_idx1_uni ON ${schema}.rpt_parted USING btree(parametri_pagamento_immediato, psp, codice_carrello,inserted_timestamp);

-- Index: nodo_online_rpt_idx1

-- DROP INDEX IF EXISTS ${schema}.nodo_online_rpt_idx1;

CREATE UNIQUE INDEX IF NOT EXISTS nodo_online_rpt_parted_idx1
  ON ${schema}.rpt_parted USING btree
  (parametri_pagamento_immediato COLLATE pg_catalog."default" ASC NULLS LAST, psp COLLATE pg_catalog."default" ASC NULLS LAST, codice_carrello COLLATE pg_catalog."default" ASC NULLS LAST,inserted_timestamp);
-- Index: rpt_idx01

-- DROP INDEX IF EXISTS ${schema}.rpt_idx01;

CREATE INDEX IF NOT EXISTS rpt_parted_idx01
  ON ${schema}.rpt_parted USING btree
  (id_sessione COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: rpt_idx02

-- DROP INDEX IF EXISTS ${schema}.rpt_idx02;

CREATE INDEX IF NOT EXISTS rpt_parted_idx02
  ON ${schema}.rpt_parted USING btree
  (parametri_pagamento_immediato COLLATE pg_catalog."default" ASC NULLS LAST, psp COLLATE pg_catalog."default" ASC NULLS LAST);
-- Index: rpt_idx03

-- DROP INDEX IF EXISTS ${schema}.rpt_idx03;

CREATE INDEX IF NOT EXISTS rpt_parted_idx03
  ON ${schema}.rpt_parted USING btree
  (iuv COLLATE pg_catalog."default" ASC NULLS LAST, ccp COLLATE pg_catalog."default" ASC NULLS LAST);

--

CREATE TABLE IF NOT EXISTS ${schema}.tab_part
(
  tabella character varying(100) COLLATE pg_catalog."default",
  schema character varying(100) COLLATE pg_catalog."default"
  );
