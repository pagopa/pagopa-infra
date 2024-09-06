CREATE TABLE ${schema}.carrello_parted (
                                         id numeric DEFAULT nextval('${schema}.carrello_seq'::regclass) NOT NULL,
                                         id_sessione varchar(50) NOT NULL,
                                         data_msg_rich timestamp(6) NOT NULL,
                                         id_carrello varchar(35) NOT NULL,
                                         staz_intermediariopa varchar(35) NOT NULL,
                                         intermediariopa varchar(35) NOT NULL,
                                         canale varchar(35) NOT NULL,
                                         psp varchar(35) NOT NULL,
                                         intermediariopsp varchar(35) NOT NULL,
                                         tipo_versamento varchar(35) NULL,
                                         parametri_profilo_pagamento varchar(255) NULL,
                                         inserted_timestamp timestamp(6) NOT NULL,
                                         updated_timestamp timestamp(6) NOT NULL,
                                         codice_convenzione varchar(35) NULL,
                                         flag_multibeneficiario bpchar(1) DEFAULT 'N'::bpchar NOT NULL,
                                         CONSTRAINT carrello_parted__pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS carrello_id_carrello_parted_idx ON ${schema}.carrello_parted USING btree (id_carrello);

---

CREATE TABLE ${schema}.cd_info_pagamento_parted (
                                                  obj_id numeric DEFAULT nextval('${schema}.cd_info_pagamento_seq'::regclass) NOT NULL,
                                                  ident_dominio varchar(35) NOT NULL,
                                                  iuv varchar(35) NOT NULL,
                                                  ccp varchar(35) NOT NULL,
                                                  id_sessione varchar(100) NULL,
                                                  inserted_timestamp timestamp(6) NOT NULL,
                                                  updated_timestamp timestamp(6) NOT NULL,
                                                  CONSTRAINT cd_info_pagamento_parted_pk PRIMARY KEY (obj_id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS cd_info_pagamento_parted_idx ON ${schema}.cd_info_pagamento_parted USING btree (ident_dominio, iuv, ccp);

---

CREATE TABLE ${schema}.idempotency_cache_parted (
                                                  id numeric DEFAULT nextval('${schema}.idempotency_cache_seq'::regclass) NOT NULL,
                                                  primitiva varchar(50) NOT NULL,
                                                  psp_id varchar(50) NOT NULL,
                                                  pa_fiscal_code varchar(50) NULL,
                                                  notice_id varchar(50) NULL,
                                                  idempotency_key varchar(50) NULL,
                                                  "token" varchar(50) NULL,
                                                  valid_to timestamp(6) NOT NULL,
                                                  hash_request varchar(500) NOT NULL,
                                                  response text NOT NULL,
                                                  inserted_timestamp timestamp(6) NOT NULL,
                                                  updated_timestamp timestamp(6) NULL,
                                                  inserted_by varchar(100) NULL,
                                                  updated_by varchar(100) NULL,
                                                  CONSTRAINT idempotency_cache_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS idempotency_cache_hash_parted_idx ON ${schema}.idempotency_cache_parted USING btree (hash_request);
CREATE INDEX IF NOT EXISTS idempotency_cache_key_psp_parted_id ON ${schema}.idempotency_cache_parted USING btree (idempotency_key, psp_id);
CREATE INDEX IF NOT EXISTS idempotency_cache_psp_notice_parted_idx ON ${schema}.idempotency_cache_parted USING btree (primitiva, psp_id, notice_id);
CREATE INDEX IF NOT EXISTS idempotency_cache_psp_token_parted_idx ON ${schema}.idempotency_cache_parted USING btree (primitiva, psp_id, token);

---

CREATE TABLE ${schema}.messaggi_parted (
                                         id numeric DEFAULT nextval('${schema}.messaggi_seq'::regclass) NOT NULL,
                                         id_sessione varchar(50) NOT NULL,
                                         id_dominio varchar(35) NULL,
                                         iuv varchar(35) NULL,
                                         ccp varchar(35) NULL,
                                         id_carrello varchar(35) NULL,
                                         tipo varchar(35) NULL,
                                         timestamp_evento timestamp(6) NULL,
                                         "source" text NULL,
                                         source_type varchar(10) NULL,
                                         CONSTRAINT messaggi_parted_pk PRIMARY KEY (id, timestamp_evento)
) partition by range ("timestamp_evento");
CREATE INDEX IF NOT EXISTS messaggi_id_carrello_parted_idx ON ${schema}.messaggi_parted USING btree (id_carrello);
CREATE INDEX IF NOT EXISTS messaggi_id_dominio_iuv_ccp_parted_idx ON ${schema}.messaggi_parted USING btree (id_dominio, iuv, ccp);
CREATE INDEX IF NOT EXISTS messaggi_id_sess_parted ON ${schema}.messaggi_parted USING btree (id_sessione);

---

CREATE TABLE ${schema}.pm_metadata_parted (
                                            id numeric DEFAULT nextval('${schema}.sq_pm_metadata_id'::regclass) NOT NULL,
                                            transaction_id varchar(50) NOT NULL,
                                            "key" varchar(140) NOT NULL,
                                            value varchar(140) NOT NULL,
                                            inserted_timestamp timestamp(6) NOT NULL,
                                            updated_timestamp timestamp(6) NOT NULL,
                                            inserted_by varchar(100) NOT NULL,
                                            updated_by varchar(100) NOT NULL,
                                            CONSTRAINT pk_pm_metadata_parted PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.pm_session_data_parted (
                                                id numeric DEFAULT nextval('${schema}.pm_session_data_seq'::regclass) NOT NULL,
                                                id_sessione varchar(50) NOT NULL,
                                                tipo varchar(35) NOT NULL,
                                                mobile_token varchar(255) NULL,
                                                rrn varchar(255) NULL,
                                                tipo_interazione varchar(255) NULL,
                                                importo_totale_pagato float4 NULL,
                                                esito_transazione_carta varchar(255) NULL,
                                                codice_autorizzativo varchar(6) NULL,
                                                timestamp_operazione timestamp(6) NULL,
                                                inserted_timestamp timestamp(6) NOT NULL,
                                                updated_timestamp timestamp(6) NOT NULL,
                                                motivo_annullamento varchar(10) NULL,
                                                codice_convenzione varchar(35) NULL,
                                                codice_autorizzativo_paypal varchar(255) NULL,
                                                id_transazione_psp_paypal varchar(255) NULL,
                                                id_transazione_pm_paypal varchar(255) NULL,
                                                id_transazione_pm_bpay varchar(255) NULL,
                                                id_transazione_psp_bpay varchar(255) NULL,
                                                outcome_payment_gateway varchar(255) NULL,
                                                commissione float4 NULL,
                                                codice_autorizzativo_bpay varchar(255) NULL,
                                                CONSTRAINT rpt_pm_data_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS pm_sess_data_sessid_parted_idx ON ${schema}.pm_session_data_parted USING btree (id_sessione);
CREATE INDEX IF NOT EXISTS pm_session_data_rrn_parted_idx ON ${schema}.pm_session_data_parted USING btree (rrn);

---

CREATE TABLE ${schema}.position_activate_parted (
                                                  id numeric DEFAULT nextval('${schema}.position_activate_seq'::regclass) NOT NULL,
                                                  pa_fiscal_code varchar(50) NULL,
                                                  notice_id varchar(50) NULL,
                                                  creditor_reference_id varchar(50) NULL,
                                                  psp_id varchar(50) NULL,
                                                  idempotency_key varchar(50) NULL,
                                                  payment_token varchar(50) NULL,
                                                  token_valid_from timestamp(6) NULL,
                                                  token_valid_to timestamp(6) NULL,
                                                  due_date timestamp(6) NULL,
                                                  amount numeric NULL,
                                                  inserted_timestamp timestamp(6) DEFAULT now() NULL,
                                                  updated_timestamp timestamp(6) NULL,
                                                  inserted_by varchar(100) NULL,
                                                  updated_by varchar(100) NULL,
                                                  payment_method varchar(4) NULL,
                                                  touchpoint varchar(10) NULL,
                                                  suggested_idbundle varchar(70) NULL,
                                                  suggested_idcibundle varchar(70) NULL,
                                                  suggested_user_fee numeric NULL,
                                                  suggested_pa_fee numeric NULL,
                                                  payment_note varchar(255) NULL,
                                                  CONSTRAINT position_activate_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_activate_parted_idx1 ON ${schema}.position_activate_parted USING btree (payment_token);
CREATE INDEX IF NOT EXISTS position_activate_pa_parted_no ON ${schema}.position_activate_parted USING btree (pa_fiscal_code, notice_id, payment_token);

---

CREATE TABLE ${schema}.position_payment_status_parted (
                                                        id numeric DEFAULT nextval('${schema}.position_payment_status_seq'::regclass) NOT NULL,
                                                        pa_fiscal_code varchar(50) NULL,
                                                        notice_id varchar(50) NULL,
                                                        status varchar(50) NULL,
                                                        inserted_timestamp timestamp(6) NULL,
                                                        creditor_reference_id varchar(50) NULL,
                                                        payment_token varchar(50) NULL,
                                                        inserted_by varchar(100) NULL,
                                                        CONSTRAINT position_payment_status_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_retry_sendpaymentresult_parted (
                                                                 id numeric DEFAULT nextval('${schema}.sq_position_retry_sendpaymentresult_id'::regclass) NOT NULL,
                                                                 payment_token varchar(255) NOT NULL,
                                                                 id_dominio varchar(255) NULL,
                                                                 iuv varchar(255) NULL,
                                                                 ccp varchar(255) NULL,
                                                                 notice_id varchar(255) NULL,
                                                                 creditor_reference_id varchar(255) NULL,
                                                                 psp_transaction_id varchar(255) NOT NULL,
                                                                 psp_id varchar(35) NULL,
                                                                 stazione varchar(255) NULL,
                                                                 canale varchar(35) NULL,
                                                                 id_sessione_originale varchar(50) NOT NULL,
                                                                 outcome varchar(10) NULL,
                                                                 retry numeric(5) NOT NULL,
                                                                 inserted_timestamp timestamp(6) NOT NULL,
                                                                 updated_timestamp timestamp(6) NOT NULL,
                                                                 inserted_by varchar(100) NOT NULL,
                                                                 updated_by varchar(100) NOT NULL,
                                                                 "version" varchar(10) DEFAULT 'v1'::character varying NULL,
                                                                 request text NULL,
                                                                 CONSTRAINT pk_position_retry_sendpaymentresult_parted PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_status_parted (
                                                id numeric DEFAULT nextval('${schema}.position_status_seq'::regclass) NOT NULL,
                                                pa_fiscal_code varchar(50) NULL,
                                                notice_id varchar(50) NULL,
                                                status varchar(50) NULL,
                                                inserted_timestamp timestamp(6) NULL,
                                                inserted_by varchar(100) NULL,
                                                CONSTRAINT position_status_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_subject_parted (
                                                 id numeric DEFAULT nextval('${schema}.position_subject_seq'::regclass) NOT NULL,
                                                 subject_type varchar(50) NULL,
                                                 entity_unique_identifier_type varchar(1) NULL,
                                                 entity_unique_identifier_value varchar(255) NULL,
                                                 full_name varchar(255) NULL,
                                                 street_name varchar(255) NULL,
                                                 civic_number varchar(50) NULL,
                                                 postal_code varchar(50) NULL,
                                                 city varchar(50) NULL,
                                                 state_province_region varchar(50) NULL,
                                                 country varchar(50) NULL,
                                                 email varchar(256) NULL,
                                                 inserted_timestamp timestamp(6) NOT NULL,
                                                 updated_timestamp timestamp(6) NOT NULL,
                                                 inserted_by varchar(100) NULL,
                                                 updated_by varchar(100) NULL,
                                                 CONSTRAINT position_subject_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");


CREATE TABLE ${schema}.retry_pa_attiva_rpt_parted (
                                                    id numeric DEFAULT nextval('${schema}.retry_pa_attiva_rpt_seq'::regclass) NOT NULL,
                                                    pa_fiscal_code varchar(50) NOT NULL,
                                                    iuv varchar(50) NULL,
                                                    "token" varchar(50) NOT NULL,
                                                    retry numeric(19) NOT NULL,
                                                    inserted_timestamp timestamp(6) NOT NULL,
                                                    updated_timestamp timestamp(6) NOT NULL,
                                                    ready bpchar(1) NULL,
                                                    CONSTRAINT retry_pa_attiva_rpt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS retry_pa_attiva_rpt_parted_idx1 ON ${schema}.retry_pa_attiva_rpt_parted USING btree (pa_fiscal_code, iuv, token);

---

CREATE TABLE ${schema}.retry_pa_invia_rt_parted (
                                                  id numeric DEFAULT nextval('${schema}.retry_pa_invia_rt_seq'::regclass) NOT NULL,
                                                  id_sessione varchar(50) NOT NULL,
                                                  id_stazione varchar(35) NOT NULL,
                                                  id_intermediario_pa varchar(35) NOT NULL,
                                                  id_canale varchar(35) NOT NULL,
                                                  id_sessione_originale varchar(36) NOT NULL,
                                                  id_dominio varchar(35) NOT NULL,
                                                  iuv varchar(35) NOT NULL,
                                                  ccp varchar(35) NOT NULL,
                                                  stato varchar(35) NULL,
                                                  inserted_timestamp timestamp(6) NOT NULL,
                                                  inserted_by varchar(35) NOT NULL,
                                                  updated_timestamp timestamp(6) NOT NULL,
                                                  updated_by varchar(35) NOT NULL,
                                                  retry numeric(19) NOT NULL,
                                                  stato_rpt varchar(50) NULL,
                                                  CONSTRAINT retry_pa_invia_rt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE UNIQUE INDEX retry_pa_invia_rt_parted_un ON ${schema}.retry_pa_invia_rt_parted USING btree (iuv, ccp, id_dominio, inserted_timestamp);

---

CREATE TABLE ${schema}.retry_rpt_parted (
                                          id numeric DEFAULT nextval('${schema}.retry_rpt_seq'::regclass) NOT NULL,
                                          id_sessione varchar(50) NOT NULL,
                                          id_carrello varchar(35) NULL,
                                          id_canale varchar(35) NOT NULL,
                                          id_dominio varchar(35) NOT NULL,
                                          iuv varchar(35) NOT NULL,
                                          ccp varchar(35) NOT NULL,
                                          stato varchar(35) NULL,
                                          inserted_timestamp timestamp(6) NOT NULL,
                                          updated_timestamp timestamp(6) NOT NULL,
                                          inserted_by varchar(35) NOT NULL,
                                          updated_by varchar(35) NOT NULL,
                                          retry numeric(19) NOT NULL,
                                          id_sessione_originale varchar(50) NULL,
                                          CONSTRAINT retry_rpt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.rpt_activations_parted (
                                                pa_fiscal_code varchar(50) NULL,
                                                notice_id varchar(50) NULL,
                                                creditor_reference_id varchar(50) NULL,
                                                payment_token varchar(50) NULL,
                                                paaattivarptresp bpchar(1) NULL,
                                                nodoinviarptreq bpchar(1) NULL,
                                                paaattivarpterror bpchar(1) NULL,
                                                inserted_timestamp timestamp(6) DEFAULT to_timestamp('1970-01-01'::text, 'yyyy-mm-dd'::text) NULL,
                                                updated_timestamp timestamp(6) NULL,
                                                inserted_by varchar(100) NULL,
                                                updated_by varchar(100) NULL,
                                                retry_pending bpchar(1) DEFAULT 'N'::bpchar NOT NULL
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rpt_activations_fu6msyd0tadcw_parted_idx ON ${schema}.rpt_activations_parted USING btree (creditor_reference_id, payment_token, pa_fiscal_code);
CREATE INDEX IF NOT EXISTS rpt_activations_pa_fiscal_code_parted_idx ON ${schema}.rpt_activations_parted USING btree (pa_fiscal_code, notice_id, creditor_reference_id);

---

CREATE TABLE ${schema}.rt_parted (
                                   id numeric DEFAULT nextval('${schema}.rt_seq'::regclass) NOT NULL,
                                   id_sessione varchar(50) NOT NULL,
                                   ccp varchar(35) NOT NULL,
                                   ident_dominio varchar(35) NOT NULL,
                                   iuv varchar(35) NOT NULL,
                                   cod_esito numeric(19) NOT NULL,
                                   esito varchar(35) NOT NULL,
                                   data_ricevuta timestamp(6) NOT NULL,
                                   data_richiesta timestamp(6) NOT NULL,
                                   id_ricevuta varchar(35) NOT NULL,
                                   id_richiesta varchar(35) NOT NULL,
                                   somma_versamenti float4 NOT NULL,
                                   inserted_timestamp timestamp(6) NOT NULL,
                                   updated_timestamp timestamp(6) NOT NULL,
                                   canale varchar(32) NULL,
                                   notifica_processata bpchar(1) DEFAULT 'N'::bpchar NOT NULL,
                                   generata_da varchar(10) NULL,
                                   CONSTRAINT rt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rt_unique_parted ON ${schema}.rt_parted USING btree (ident_dominio, iuv, ccp);
---* rt_unique_parted non pèuò piu essere unico, non avrebbe senso


---

CREATE TABLE ${schema}.stati_carrello_parted (
                                               id_sessione varchar(50) NOT NULL,
                                               id_carrello varchar(35) NOT NULL,
                                               stato varchar(35) NOT NULL,
                                               inserted_by varchar(35) NOT NULL,
                                               inserted_timestamp timestamp(6) NOT NULL,
                                               id_sessione_originale varchar(50) NULL,
                                               id int8 GENERATED BY DEFAULT AS IDENTITY( INCREMENT BY 1 MINVALUE 1 MAXVALUE 9223372036854775807 START 1 CACHE 1 NO CYCLE) NOT NULL,
                                               CONSTRAINT stati_carrello_parted_pk PRIMARY KEY (id,inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS stati_carrello_idx_id_carrello_id_sessione_parted ON ${schema}.stati_carrello_parted USING btree (id_carrello, id_sessione);

---

CREATE TABLE ${schema}.stati_carrello_snapshot_parted (
                                                        id_sessione varchar(50) NOT NULL,
                                                        id_carrello varchar(35) NOT NULL,
                                                        stato varchar(35) NOT NULL,
                                                        inserted_timestamp timestamp(6) NOT NULL,
                                                        updated_timestamp timestamp(6) NOT NULL,
                                                        inserted_by varchar(35) NOT NULL,
                                                        updated_by varchar(35) NOT NULL,
                                                        CONSTRAINT pk_carrello_parted PRIMARY KEY (id_carrello, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS stati_carrello_snapshot_idx_id_sessione_parted ON ${schema}.stati_carrello_snapshot_parted USING btree (id_sessione);

---

CREATE TABLE ${schema}.stati_rpt_parted (
                                          id numeric DEFAULT nextval('${schema}.stati_rpt_seq'::regclass) NOT NULL,
                                          id_sessione varchar(50) NOT NULL,
                                          id_sessione_originale varchar(50) NULL,
                                          id_dominio varchar(35) NOT NULL,
                                          iuv varchar(35) NOT NULL,
                                          ccp varchar(35) NOT NULL,
                                          stato varchar(35) NOT NULL,
                                          inserted_by varchar(35) NOT NULL,
                                          inserted_timestamp timestamp(6) NOT NULL,
                                          CONSTRAINT stati_rpt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS stati_rpt_idx_id_sessione_originale_parted ON ${schema}.stati_rpt_parted USING btree (id_sessione_originale);
CREATE INDEX IF NOT EXISTS stati_rpt_idx_rptkey_id_sessione_parted ON ${schema}.stati_rpt_parted USING btree (id_dominio, iuv, ccp, id_sessione);
CREATE INDEX IF NOT EXISTS stati_rpt_mv_parted_idx1 ON ${schema}.stati_rpt_parted USING btree (inserted_timestamp);

---

CREATE TABLE ${schema}.stati_rpt_snapshot_parted (
                                                   id_dominio varchar(35) NOT NULL,
                                                   iuv varchar(35) NOT NULL,
                                                   ccp varchar(35) NOT NULL,
                                                   id_sessione varchar(50) NOT NULL,
                                                   stato varchar(35) NOT NULL,
                                                   inserted_timestamp timestamp(6) NOT NULL,
                                                   updated_timestamp timestamp(6) NOT NULL,
                                                   inserted_by varchar(35) NOT NULL,
                                                   updated_by varchar(35) NOT NULL,
                                                   push numeric(1) NULL,
                                                   CONSTRAINT stati_rpt_snapshot_parted_pk PRIMARY KEY (id_dominio, iuv, ccp, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS stati_rpt_snapshot_parted_idx1 ON ${schema}.stati_rpt_snapshot_parted USING btree (stato);
CREATE INDEX IF NOT EXISTS stati_rpt_snapshot_idx_id_sessione_parted ON ${schema}.stati_rpt_snapshot_parted USING btree (id_sessione);
CREATE INDEX IF NOT EXISTS stati_rpt_snapshot_mv_parted_idx1 ON ${schema}.stati_rpt_snapshot_parted USING btree (inserted_timestamp);

---

CREATE TABLE ${schema}.verifica_bollettino_parted (
                                                    id numeric DEFAULT nextval('${schema}.verifica_bollettino_seq'::regclass) NOT NULL,
                                                    ccpost varchar(12) NOT NULL,
                                                    notice_id varchar(50) NOT NULL,
                                                    pa_fiscal_code varchar(50) NOT NULL,
                                                    inserted_timestamp timestamp(6) NOT NULL,
                                                    updated_timestamp timestamp(6) NOT NULL,
                                                    inserted_by varchar(100) NULL,
                                                    updated_by varchar(100) NULL,
                                                    CONSTRAINT vb_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS verifica_bollettino_unique_parted ON ${schema}.verifica_bollettino_parted USING btree (notice_id, pa_fiscal_code, inserted_timestamp);
---* indice non può essere unico

---

--- tabelle con FK

CREATE TABLE ${schema}.rt_versamenti_parted (
                                              id numeric DEFAULT nextval('${schema}.rt_versamenti_seq'::regclass) NOT NULL,
                                              progressivo numeric(19) NOT NULL,
                                              importo_rt float4 NOT NULL,
                                              esito varchar(35) NULL,
                                              causale_versamento varchar(255) NOT NULL,
                                              dati_specifici_riscossione varchar(255) NOT NULL,
                                              commissione_applicate_psp float4 NULL,
                                              fk_rt numeric(19) NOT NULL,
                                              inserted_timestamp timestamp(6) NOT NULL,
                                              updated_timestamp timestamp(6) NOT NULL,
                                              commissione_carico_pa float4 NULL,
                                              commissione_applicate_pa float4 NULL,
                                              CONSTRAINT rt_versamenti_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rt_versamenti_fk_rt_parted_idx ON ${schema}.rt_versamenti_parted USING btree (fk_rt);

---

CREATE TABLE ${schema}.position_service_parted (
                                                 id numeric DEFAULT nextval('${schema}.position_service_seq'::regclass) NOT NULL,
                                                 pa_fiscal_code varchar(50) NULL,
                                                 notice_id varchar(50) NULL,
                                                 description varchar(140) NULL,
                                                 company_name varchar(140) NULL,
                                                 office_name varchar(140) NULL,
                                                 debtor_id numeric NULL,
                                                 inserted_timestamp timestamp(6) NULL,
                                                 updated_timestamp timestamp(6) NULL,
                                                 inserted_by varchar(100) NULL,
                                                 updated_by varchar(100) NULL,
                                                 CONSTRAINT ps_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_service_inserted_timestamp_parted ON ${schema}.position_service_parted USING btree (inserted_timestamp);
CREATE INDEX IF NOT EXISTS position_service_pa_fiscal_code_parted_idx ON ${schema}.position_service_parted USING btree (pa_fiscal_code, notice_id);
---* indice non può essere unico

---

CREATE TABLE ${schema}.position_status_snapshot_parted (
                                                         id numeric DEFAULT nextval('${schema}.position_status_snapshot_seq'::regclass) NOT NULL,
                                                         pa_fiscal_code varchar(50) NULL,
                                                         notice_id varchar(50) NULL,
                                                         status varchar(50) NULL,
                                                         inserted_timestamp timestamp(6) NULL,
                                                         updated_timestamp timestamp(6) NULL,
                                                         fk_position_service numeric NULL,
                                                         activation_pending bpchar(1) DEFAULT 'N'::bpchar NULL,
                                                         inserted_by varchar(100) NULL,
                                                         updated_by varchar(100) NULL,
                                                         CONSTRAINT position_status_snapshot_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_status_snapshot_parted_idx ON ${schema}.position_status_snapshot_parted USING btree (fk_position_service);
CREATE INDEX IF NOT EXISTS position_status_snapshot_parted_idx1 ON ${schema}.position_status_snapshot_parted USING btree (notice_id, pa_fiscal_code);
CREATE INDEX IF NOT EXISTS position_status_snapshot_parted_idx2 ON ${schema}.position_status_snapshot_parted USING btree (notice_id);
CREATE INDEX IF NOT EXISTS position_status_snapshot_inserted_timestamp_parted ON ${schema}.position_status_snapshot_parted USING btree (inserted_timestamp);

---

CREATE TABLE ${schema}.rpt_parted (
                                    id numeric DEFAULT nextval('${schema}.rpt_seq'::regclass) NOT NULL,
                                    id_sessione varchar(50) NOT NULL,
                                    ccp varchar(35) NOT NULL,
                                    ident_dominio varchar(35) NOT NULL,
                                    iuv varchar(35) NOT NULL,
                                    bic_addebito varchar(11) NULL,
                                    data_msg_rich timestamp(6) NOT NULL,
                                    flag_canc bpchar(1) NOT NULL,
                                    iban_addebito varchar(35) NULL,
                                    id_msg_rich varchar(100) NOT NULL,
                                    staz_intermediariopa varchar(35) NOT NULL,
                                    intermediariopa varchar(35) NOT NULL,
                                    canale varchar(35) NOT NULL,
                                    psp varchar(35) NOT NULL,
                                    intermediariopsp varchar(35) NOT NULL,
                                    tipo_versamento varchar(35) NOT NULL,
                                    num_versamenti numeric(19) NOT NULL,
                                    rt_signature_code numeric(19) NOT NULL,
                                    somma_versamenti float4 NOT NULL,
                                    parametri_profilo_pagamento varchar(255) NULL,
                                    fk_carrello numeric(19) NULL,
                                    inserted_timestamp timestamp(6) NOT NULL,
                                    updated_timestamp timestamp(6) NOT NULL,
                                    ricevuta_pm bpchar(1) DEFAULT 'N'::bpchar NOT NULL,
                                    wisp_2 bpchar(1) DEFAULT 'N'::bpchar NOT NULL,
                                    flag_seconda bpchar(1) NULL,
                                    flag_io bpchar(1) NULL,
                                    CONSTRAINT rpt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS cffj72a4012c5_parted_idx ON ${schema}.rpt_parted USING btree (iuv, ident_dominio, ccp, flag_io);
CREATE INDEX IF NOT EXISTS dsf6xw4twzyr2_parted_idx ON ${schema}.rpt_parted USING btree (fk_carrello, wisp_2);
CREATE INDEX IF NOT EXISTS rpt_fk_carrello_parted ON ${schema}.rpt_parted USING btree (fk_carrello);
CREATE INDEX IF NOT EXISTS rpt_staz_intermediariopa_parted ON ${schema}.rpt_parted USING btree (staz_intermediariopa);
CREATE INDEX IF NOT EXISTS rpt_unique_parted ON ${schema}.rpt_parted USING btree (ident_dominio, iuv, ccp);
---* indice non può essere unico

---

CREATE TABLE ${schema}.rpt_soggetti_parted (
                                             rpt_id numeric(19) NOT NULL,
                                             tipo_soggetto bpchar(1) NOT NULL,
                                             tipo_identificativo_univoco bpchar(1) NOT NULL,
                                             codice_identificativo_univoco varchar(35) NOT NULL,
                                             anagrafica varchar(70) NOT NULL,
                                             indirizzo varchar(70) NULL,
                                             civico varchar(16) NULL,
                                             cap varchar(16) NULL,
                                             localita varchar(35) NULL,
                                             provincia varchar(35) NULL,
                                             nazione varchar(4) NULL,
                                             email varchar(256) NULL,
                                             codice_unitoper varchar(35) NULL,
                                             denomin_unitoper varchar(35) NULL,
                                             inserted_timestamp timestamp(6) NOT NULL,
                                             updated_timestamp timestamp(6) NOT NULL,
                                             CONSTRAINT rpt_soggetti_parted_pk PRIMARY KEY (rpt_id, tipo_soggetto, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rpt_soggetti_rpt_id_parted_idx ON ${schema}.rpt_soggetti_parted USING btree (rpt_id);

---

CREATE TABLE ${schema}.rpt_versamenti_parted (
                                               id numeric DEFAULT nextval('${schema}.rpt_versamenti_seq'::regclass) NOT NULL,
                                               progressivo numeric(19) NOT NULL,
                                               importo float4 NOT NULL,
                                               commissione_carico_pa float4 NULL,
                                               iban varchar(35) NULL,
                                               iban_appoggio varchar(35) NULL,
                                               bic_accredito varchar(11) NULL,
                                               bic_appoggio varchar(11) NULL,
                                               credenziali_pagatore varchar(35) NULL,
                                               causale_versamento varchar(255) NOT NULL,
                                               tipo_versamento varchar(25) NOT NULL,
                                               dati_specifici_riscossione varchar(255) NOT NULL,
                                               fk_rpt numeric(19) NOT NULL,
                                               inserted_timestamp timestamp(6) NOT NULL,
                                               updated_timestamp timestamp(6) NOT NULL,
                                               CONSTRAINT rpt_versamenti_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rpt_versamenti_fk_rpt_parted_idx ON ${schema}.rpt_versamenti_parted USING btree (fk_rpt);

---

CREATE TABLE ${schema}.rpt_versamenti_bollo_parted (
                                                     id numeric DEFAULT nextval('${schema}.rpt_versamenti_bollo_seq'::regclass) NOT NULL,
                                                     progressivo numeric(19) NOT NULL,
                                                     tipo_bollo varchar(2) NOT NULL,
                                                     hash_documento varchar(70) NOT NULL,
                                                     provincia_residenza varchar(2) NOT NULL,
                                                     fk_rpt_versamenti numeric(19) NOT NULL,
                                                     inserted_timestamp timestamp(6) NOT NULL,
                                                     updated_timestamp timestamp(6) NOT NULL,
                                                     CONSTRAINT rpt_versamenti_bollo_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rpt_versamenti_bollo_fk_rpt_versamenti_parted_idx ON ${schema}.rpt_versamenti_bollo_parted USING btree (fk_rpt_versamenti);

---

CREATE TABLE ${schema}.rpt_xml_parted (
                                        id numeric DEFAULT nextval('${schema}.rpt_xml_seq'::regclass) NOT NULL,
                                        ccp varchar(35) NOT NULL,
                                        ident_dominio varchar(35) NOT NULL,
                                        iuv varchar(35) NOT NULL,
                                        fk_rpt numeric(19) NULL,
                                        fk_carrello numeric(19) NULL,
                                        id_sessione varchar(50) NULL,
                                        id_carrello varchar(35) NULL,
                                        xml_content text NOT NULL,
                                        inserted_timestamp timestamp(6) NOT NULL,
                                        updated_timestamp timestamp(6) NOT NULL,
                                        CONSTRAINT rpt_xml_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rpt_xml_ccp_iuv_parted_idx ON ${schema}.rpt_xml_parted USING btree (ccp, iuv);
CREATE INDEX IF NOT EXISTS rpt_xml_fk_rpt_parted_idx ON ${schema}.rpt_xml_parted USING btree (fk_rpt);
CREATE INDEX IF NOT EXISTS rpt_xml_id_fk_carrello_parted_idx ON ${schema}.rpt_xml_parted USING btree (fk_carrello);

---

CREATE TABLE ${schema}.position_payment_parted (
                                                 id numeric DEFAULT nextval('${schema}.position_payment_seq'::regclass) NOT NULL,
                                                 pa_fiscal_code varchar(50) NULL,
                                                 notice_id varchar(50) NULL,
                                                 creditor_reference_id varchar(50) NULL,
                                                 payment_token varchar(50) NULL,
                                                 broker_pa_id varchar(50) NULL,
                                                 station_id varchar(50) NULL,
                                                 station_version numeric NULL,
                                                 psp_id varchar(50) NULL,
                                                 broker_psp_id varchar(50) NULL,
                                                 channel_id varchar(50) NULL,
                                                 idempotency_key varchar(50) NULL,
                                                 amount numeric NULL,
                                                 fee numeric NULL,
                                                 outcome varchar(50) NULL,
                                                 payment_method varchar(50) NULL,
                                                 payment_channel varchar(50) NULL,
                                                 transfer_date date NULL,
                                                 payer_id numeric NULL,
                                                 application_date date NULL,
                                                 inserted_timestamp timestamp(6) NULL,
                                                 updated_timestamp timestamp(6) NULL,
                                                 fk_payment_plan numeric NULL,
                                                 rpt_id numeric NULL,
                                                 payment_type varchar(10) DEFAULT 'NA'::character varying NOT NULL,
                                                 carrello_id numeric NULL,
                                                 original_payment_token varchar(50) NULL,
                                                 flag_io bpchar(1) DEFAULT 'N'::bpchar NULL,
                                                 ricevuta_pm bpchar(1) DEFAULT 'N'::bpchar NULL,
                                                 flag_activate_resp_missing bpchar(1) NULL,
                                                 flag_paypal bpchar(1) NULL,
                                                 inserted_by varchar(100) NULL,
                                                 updated_by varchar(100) NULL,
                                                 transaction_id varchar(255) NULL,
                                                 close_version varchar(50) NULL,
                                                 fee_pa numeric NULL,
                                                 bundle_id varchar(70) NULL,
                                                 bundle_pa_id varchar(70) NULL,
                                                 pm_info bytea NULL,
                                                 mbd bpchar(1) DEFAULT 'N'::bpchar NULL,
                                                 fee_spo numeric(19) NULL,
                                                 payment_note varchar(255) NULL,
                                                 flag_standin bpchar(1) NULL,
                                                 CONSTRAINT position_payment_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS i_fk_pp_ps_parted ON ${schema}.position_payment_parted USING btree (fk_payment_plan);
CREATE INDEX IF NOT EXISTS i_fk_pp_rpt_parted ON ${schema}.position_payment_parted USING btree (rpt_id);
CREATE INDEX IF NOT EXISTS position_payment_parted_idx ON ${schema}.position_payment_parted USING btree (payment_token);
CREATE INDEX IF NOT EXISTS position_payment_parted_idx1 ON ${schema}.position_payment_parted USING btree (notice_id);
CREATE INDEX IF NOT EXISTS position_payment_parted_idx3 ON ${schema}.position_payment_parted USING btree (payment_token, psp_id, inserted_timestamp);
CREATE INDEX IF NOT EXISTS position_payment_inserted_timestamp_parted ON ${schema}.position_payment_parted USING btree (inserted_timestamp);
CREATE INDEX IF NOT EXISTS position_payment_trans_id_parted_idx ON ${schema}.position_payment_parted USING btree (transaction_id);

---

CREATE TABLE ${schema}.position_payment_plan_parted (
                                                      id numeric DEFAULT nextval('${schema}.position_payment_plan_seq'::regclass) NOT NULL,
                                                      pa_fiscal_code varchar(50) NULL,
                                                      notice_id varchar(50) NULL,
                                                      creditor_reference_id varchar(50) NULL,
                                                      due_date timestamp(6) NULL,
                                                      retention_date timestamp(6) NULL,
                                                      amount numeric NULL,
                                                      flag_final_payment varchar(1) NULL,
                                                      inserted_timestamp timestamp(6) NULL,
                                                      updated_timestamp timestamp(6) NULL,
                                                      metadata varchar(3000) NULL,
                                                      fk_position_service numeric NULL,
                                                      inserted_by varchar(100) NULL,
                                                      updated_by varchar(100) NULL,
                                                      CONSTRAINT ppp_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS cred_fiscal_code_parted_idx ON ${schema}.position_payment_plan_parted USING btree (creditor_reference_id, pa_fiscal_code);
CREATE INDEX IF NOT EXISTS i_06b1nax785kuu_parted_idx ON ${schema}.position_payment_plan_parted USING btree (creditor_reference_id, notice_id, pa_fiscal_code);
CREATE INDEX IF NOT EXISTS position_payment_plan_parted_idx ON ${schema}.position_payment_plan_parted USING btree (fk_position_service);

---

CREATE TABLE ${schema}.position_payment_status_snapshot_parted (
                                                                 id numeric DEFAULT nextval('${schema}.position_payment_status_snapshot_seq'::regclass) NOT NULL,
                                                                 pa_fiscal_code varchar(50) NULL,
                                                                 notice_id varchar(50) NULL,
                                                                 creditor_reference_id varchar(50) NULL,
                                                                 payment_token varchar(50) NULL,
                                                                 status varchar(50) NULL,
                                                                 inserted_timestamp timestamp(6) NULL,
                                                                 updated_timestamp timestamp(6) NULL,
                                                                 fk_position_payment numeric NULL,
                                                                 inserted_by varchar(100) NULL,
                                                                 updated_by varchar(100) NULL,
                                                                 CONSTRAINT position_payment_status_snapshot_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_payment_status_parted_idx ON ${schema}.position_payment_status_snapshot_parted USING btree (status);
CREATE INDEX IF NOT EXISTS position_payment_status_snapshot_parted_idx ON ${schema}.position_payment_status_snapshot_parted USING btree (fk_position_payment);
CREATE INDEX IF NOT EXISTS position_payment_status_snapshot_parted_idx1 ON ${schema}.position_payment_status_snapshot_parted USING btree (notice_id);
CREATE INDEX IF NOT EXISTS position_payment_status_snapshot_inserted_timestamp_parted ON ${schema}.position_payment_status_snapshot_parted USING btree (inserted_timestamp);
CREATE INDEX IF NOT EXISTS position_payment_status_snapshot_pa_no_parted ON ${schema}.position_payment_status_snapshot_parted USING btree (pa_fiscal_code, notice_id, payment_token);
CREATE INDEX IF NOT EXISTS position_payment_status_snapshot_token_parted ON ${schema}.position_payment_status_snapshot_parted USING btree (payment_token);
CREATE INDEX IF NOT EXISTS ppss_2qupz9mdtj4b6_parted_idx ON ${schema}.position_payment_status_snapshot_parted USING btree (creditor_reference_id, pa_fiscal_code, payment_token);


---

CREATE TABLE ${schema}.position_receipt_parted (
                                                 id numeric DEFAULT nextval('${schema}.position_receipt_seq'::regclass) NOT NULL,
                                                 receipt_id varchar(50) NULL,
                                                 notice_id varchar(50) NULL,
                                                 pa_fiscal_code varchar(50) NULL,
                                                 creditor_reference_id varchar(50) NULL,
                                                 payment_token varchar(50) NULL,
                                                 outcome varchar(50) NULL,
                                                 payment_amount numeric NULL,
                                                 description varchar(140) NULL,
                                                 company_name varchar(140) NULL,
                                                 office_name varchar(140) NULL,
                                                 debtor_id numeric NULL,
                                                 psp_id varchar(50) NULL,
                                                 psp_fiscal_code varchar(50) NULL,
                                                 psp_vat_number varchar(50) NULL,
                                                 psp_company_name varchar(70) NULL,
                                                 channel_id varchar(50) NULL,
                                                 channel_description varchar(50) NULL,
                                                 payer_id numeric NULL,
                                                 payment_method varchar(50) NULL,
                                                 fee numeric NULL,
                                                 payment_date_time timestamp(6) NULL,
                                                 application_date date NULL,
                                                 transfer_date date NULL,
                                                 metadata varchar(3000) NULL,
                                                 rt_id numeric NULL,
                                                 fk_position_payment numeric NULL,
                                                 inserted_timestamp timestamp(6) NULL,
                                                 updated_timestamp timestamp(6) NULL,
                                                 inserted_by varchar(100) NULL,
                                                 updated_by varchar(100) NULL,
                                                 fee_pa numeric NULL,
                                                 bundle_id varchar(70) NULL,
                                                 bundle_pa_id varchar(70) NULL,
                                                 flag_standin bpchar(1) NULL,
                                                 CONSTRAINT position_receipt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_receipt_payment_date_time_parted ON ${schema}.position_receipt_parted USING btree (payment_date_time);

---

CREATE TABLE ${schema}.position_receipt_recipient_parted (
                                                           id numeric DEFAULT nextval('${schema}.position_receipt_recipient_seq'::regclass) NOT NULL,
                                                           pa_fiscal_code varchar(50) NULL,
                                                           notice_id varchar(50) NULL,
                                                           creditor_reference_id varchar(50) NULL,
                                                           payment_token varchar(50) NULL,
                                                           recipient_pa_fiscal_code varchar(50) NULL,
                                                           recipient_broker_pa_id varchar(50) NULL,
                                                           recipient_station_id varchar(50) NULL,
                                                           status varchar(50) NULL,
                                                           inserted_timestamp timestamp(6) NULL,
                                                           updated_timestamp timestamp(6) NULL,
                                                           fk_position_receipt numeric NOT NULL,
                                                           fk_receipt_xml numeric NULL,
                                                           inserted_by varchar(100) NULL,
                                                           updated_by varchar(100) NULL,
                                                           CONSTRAINT position_receipt_recipient_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_receipt_recipient_inserted_timestamp_parted ON ${schema}.position_receipt_recipient_parted USING btree (inserted_timestamp);
CREATE INDEX IF NOT EXISTS position_receipt_recipient_pa_no_to_parted ON ${schema}.position_receipt_recipient_parted USING btree (pa_fiscal_code, notice_id, payment_token);

---

CREATE TABLE ${schema}.position_receipt_recipient_status_parted (
                                                                  id numeric DEFAULT nextval('${schema}.position_receipt_recipient_status_seq'::regclass) NOT NULL,
                                                                  pa_fiscal_code varchar(50) NULL,
                                                                  notice_id varchar(50) NULL,
                                                                  creditor_reference_id varchar(50) NULL,
                                                                  payment_token varchar(50) NULL,
                                                                  recipient_pa_fiscal_code varchar(50) NULL,
                                                                  recipient_broker_pa_id varchar(50) NULL,
                                                                  recipient_station_id varchar(50) NULL,
                                                                  status varchar(50) NULL,
                                                                  inserted_timestamp timestamp(6) NULL,
                                                                  fk_position_receipt_recipient numeric NOT NULL,
                                                                  inserted_by varchar(100) NULL,
                                                                  CONSTRAINT position_receipt_recipient_status_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_receipt_transfer_parted (
                                                          fk_position_receipt numeric NOT NULL,
                                                          fk_position_transfer numeric NOT NULL,
                                                          inserted_timestamp timestamp(6) NULL,
                                                          updated_timestamp timestamp(6) NULL,
                                                          inserted_by varchar(100) NULL,
                                                          updated_by varchar(100) NULL
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_receipt_xml_parted (
                                                     id numeric DEFAULT nextval('${schema}.position_receipt_xml_seq'::regclass) NOT NULL,
                                                     pa_fiscal_code varchar(50) NULL,
                                                     notice_id varchar(50) NULL,
                                                     creditor_reference_id varchar(50) NULL,
                                                     payment_token varchar(50) NULL,
                                                     "xml" bytea NULL,
                                                     inserted_timestamp timestamp(6) NULL,
                                                     fk_position_receipt numeric NOT NULL,
                                                     recipient_pa_fiscal_code varchar(50) NULL,
                                                     recipient_broker_pa_id varchar(50) NULL,
                                                     recipient_station_id varchar(50) NULL,
                                                     updated_timestamp timestamp(6) NULL,
                                                     inserted_by varchar(100) NULL,
                                                     updated_by varchar(100) NULL,
                                                     CONSTRAINT position_receipt_xml_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_retry_pa_send_rt_parted (
                                                          id numeric DEFAULT nextval('${schema}.position_retry_pa_send_rt_seq'::regclass) NOT NULL,
                                                          pa_fiscal_code varchar(50) NOT NULL,
                                                          notice_id varchar(50) NULL,
                                                          "token" varchar(50) NOT NULL,
                                                          fk_recipient numeric NULL,
                                                          retry numeric(19) NOT NULL,
                                                          inserted_timestamp timestamp(6) NOT NULL,
                                                          updated_timestamp timestamp(6) NOT NULL,
                                                          CONSTRAINT position_retry_pa_send_rt_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");

---

CREATE TABLE ${schema}.position_transfer_parted (
                                                  id numeric DEFAULT nextval('${schema}.position_transfer_seq'::regclass) NOT NULL,
                                                  notice_id varchar(50) NULL,
                                                  creditor_reference_id varchar(50) NULL,
                                                  pa_fiscal_code varchar(50) NULL,
                                                  pa_fiscal_code_secondary varchar(50) NULL,
                                                  iban varchar(50) NULL,
                                                  amount float4 NULL,
                                                  remittance_information varchar(512) NULL,
                                                  transfer_category varchar(140) NULL,
                                                  transfer_identifier varchar(50) NULL,
                                                  "valid" varchar(1) NULL,
                                                  inserted_timestamp timestamp(6) NULL,
                                                  updated_timestamp timestamp(6) NULL,
                                                  fk_payment_plan numeric NULL,
                                                  fk_position_payment numeric NULL,
                                                  inserted_by varchar(100) NULL,
                                                  updated_by varchar(100) NULL,
                                                  metadata varchar(3000) NULL,
                                                  req_tipo_bollo varchar(2) NULL,
                                                  req_hash_documento varchar(72) NULL,
                                                  req_provincia_residenza varchar(2) NULL,
                                                  company_name_secondary varchar(140) NULL,
                                                  CONSTRAINT position_transfer_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS position_transfer_fk_position_payment_parted ON ${schema}.position_transfer_parted USING btree (fk_position_payment);
CREATE INDEX IF NOT EXISTS position_transfer_parted_idx1 ON ${schema}.position_transfer_parted USING btree (fk_payment_plan);

---

CREATE TABLE ${schema}.rt_versamenti_bollo_parted (
                                                    id numeric DEFAULT nextval('${schema}.rt_versamenti_bollo_seq'::regclass) NOT NULL,
                                                    progressivo numeric(19) NOT NULL,
                                                    tipo_bollo varchar(2) NOT NULL,
                                                    tipo_allegato_ricevuta varchar(2) NOT NULL,
                                                    iubd varchar(255) NOT NULL,
                                                    stato varchar(35) NOT NULL,
                                                    importo numeric(19) NOT NULL,
                                                    ora_acquisto timestamp(6) NOT NULL,
                                                    fk_rt_versamenti numeric(19) NOT NULL,
                                                    ack_impronta numeric(19) NULL,
                                                    ack_iudb numeric(19) NULL,
                                                    ack_codice_fiscale numeric(19) NULL,
                                                    ack_denominazione numeric(19) NULL,
                                                    inserted_timestamp timestamp(6) NOT NULL,
                                                    updated_timestamp timestamp(6) NOT NULL,
                                                    CONSTRAINT rt_versamenti_bollo_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rt_versamenti_bollo_fk_rt_versamenti_parted_idx ON ${schema}.rt_versamenti_bollo_parted USING btree (fk_rt_versamenti);
CREATE INDEX IF NOT EXISTS rt_versamenti_bollo_iubd_parted ON ${schema}.rt_versamenti_bollo_parted USING btree (iubd);

---

CREATE TABLE ${schema}.rt_xml_parted (
                                       id numeric DEFAULT nextval('${schema}.rt_xml_seq'::regclass) NOT NULL,
                                       ccp varchar(35) NOT NULL,
                                       ident_dominio varchar(35) NOT NULL,
                                       iuv varchar(35) NOT NULL,
                                       fk_rt numeric(19) NOT NULL,
                                       tipo_firma varchar(255) NULL,
                                       xml_content text NOT NULL,
                                       inserted_timestamp timestamp(6) NOT NULL,
                                       updated_timestamp timestamp(6) NOT NULL,
                                       id_sessione varchar(50) NULL,
                                       CONSTRAINT rt_xml_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS rt_xml_fk_rt_parted_idx ON ${schema}.rt_xml_parted USING btree (fk_rt);
CREATE INDEX IF NOT EXISTS rt_xml_parted_idx1 ON ${schema}.rt_xml_parted USING btree (ccp, iuv);

---

CREATE TABLE ${schema}.token_utility_parted (
                                              id numeric DEFAULT nextval('${schema}.token_utility_seq'::regclass) NOT NULL,
                                              pa_fiscal_code varchar(50) NULL,
                                              notice_id varchar(50) NULL,
                                              creditor_reference_id varchar(50) NULL,
                                              token1 varchar(50) NULL,
                                              token2 varchar(50) NULL,
                                              fk_payment1 numeric NULL,
                                              fk_payment2 numeric NULL,
                                              fk_rpt1 numeric NULL,
                                              fk_rpt2 numeric NULL,
                                              updated_timestamp timestamp(6) NULL,
                                              inserted_by varchar(100) NULL,
                                              updated_by varchar(100) NULL,
                                              inserted_timestamp timestamp(6) NULL,
                                              CONSTRAINT token_utility_parted_pk PRIMARY KEY (id, inserted_timestamp)
) partition by range ("inserted_timestamp");
CREATE INDEX IF NOT EXISTS i_fk_rpt_1_parted ON ${schema}.token_utility_parted USING btree (fk_rpt1);
CREATE INDEX IF NOT EXISTS i_fk_rpt_2_parted ON ${schema}.token_utility_parted USING btree (fk_rpt2);
