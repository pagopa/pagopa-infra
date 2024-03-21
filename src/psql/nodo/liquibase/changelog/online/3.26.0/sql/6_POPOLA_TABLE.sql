INSERT INTO ${schema}.carrello
SELECT *
FROM   ${schema}.carrello_old;

INSERT INTO ${schema}.cd_info_pagamento
SELECT *
FROM   ${schema}.cd_info_pagamento_old;

INSERT INTO ${schema}.idempotency_cache
SELECT *
FROM   ${schema}.idempotency_cache_old;

INSERT INTO ${schema}.messaggi
SELECT *
FROM   ${schema}.messaggi_old;

INSERT INTO ${schema}.pm_metadata
SELECT *
FROM   ${schema}.pm_metadata_old;

INSERT INTO ${schema}.pm_session_data
SELECT *
FROM   ${schema}.pm_session_data_old;

INSERT INTO ${schema}.position_activate
SELECT *
FROM   ${schema}.position_activate_old;

INSERT INTO ${schema}.position_payment
SELECT *
FROM   ${schema}.position_payment_old;

INSERT INTO ${schema}.position_payment_plan
SELECT *
FROM   ${schema}.position_payment_plan_old;

INSERT INTO ${schema}.position_payment_status
SELECT *
FROM   ${schema}.position_payment_status_old;

INSERT INTO ${schema}.position_payment_status_snapshot
SELECT *
FROM   ${schema}.position_payment_status_snapshot_old;

INSERT INTO ${schema}.position_receipt
SELECT *
FROM   ${schema}.position_receipt_old;

INSERT INTO ${schema}.position_receipt_recipient
SELECT *
FROM   ${schema}.position_receipt_recipient_old;

INSERT INTO ${schema}.position_receipt_recipient_status
SELECT *
FROM   ${schema}.position_receipt_recipient_status_old;

INSERT INTO ${schema}.position_receipt_transfer
SELECT *
FROM   ${schema}.position_receipt_transfer_old;

INSERT INTO ${schema}.position_receipt_xml
SELECT *
FROM   ${schema}.position_receipt_xml_old;

INSERT INTO ${schema}.position_retry_pa_send_rt
SELECT *
FROM   ${schema}.position_retry_pa_send_rt_old;

INSERT INTO ${schema}.position_retry_sendpaymentresult
SELECT *
FROM   ${schema}.position_retry_sendpaymentresult_old;

INSERT INTO ${schema}.position_service
SELECT *
FROM   ${schema}.position_service_old;

INSERT INTO ${schema}.position_status
SELECT *
FROM   ${schema}.position_status_old;

INSERT INTO ${schema}.position_status_snapshot
SELECT *
FROM   ${schema}.position_status_snapshot_old;

INSERT INTO ${schema}.position_subject
SELECT *
FROM   ${schema}.position_subject_old;

INSERT INTO ${schema}.position_transfer
SELECT *
FROM   ${schema}.position_transfer_old;

INSERT INTO ${schema}.retry_pa_attiva_rpt
SELECT *
FROM   ${schema}.retry_pa_attiva_rpt_old;

INSERT INTO ${schema}.retry_pa_invia_rt
SELECT *
FROM   ${schema}.retry_pa_invia_rt_old;

INSERT INTO ${schema}.retry_rpt
SELECT *
FROM   ${schema}.retry_rpt_old;

INSERT INTO ${schema}.rpt
SELECT *
FROM   ${schema}.rpt_old;

INSERT INTO ${schema}.rpt_activations
SELECT *
FROM   ${schema}.rpt_activations_old;

INSERT INTO ${schema}.rpt_soggetti
SELECT *
FROM   ${schema}.rpt_soggetti_old;

INSERT INTO ${schema}.rpt_versamenti
SELECT *
FROM   ${schema}.rpt_versamenti_old;

INSERT INTO ${schema}.rpt_versamenti_bollo
SELECT *
FROM   ${schema}.rpt_versamenti_bollo_old;

INSERT INTO ${schema}.rpt_xml
SELECT *
FROM   ${schema}.rpt_xml_old;

INSERT INTO ${schema}.rt
SELECT *
FROM   ${schema}.rt_old;

INSERT INTO ${schema}.rt_versamenti
SELECT *
FROM   ${schema}.rt_versamenti_old;

INSERT INTO ${schema}.rt_versamenti_bollo
SELECT *
FROM   ${schema}.rt_versamenti_bollo_old;

INSERT INTO ${schema}.rt_xml
SELECT *
FROM   ${schema}.rt_xml_old;

INSERT INTO ${schema}.stati_carrello
SELECT *
FROM   ${schema}.stati_carrello_old;

INSERT INTO ${schema}.stati_carrello_snapshot
SELECT *
FROM   ${schema}.stati_carrello_snapshot_old;

INSERT INTO ${schema}.stati_rpt
SELECT *
FROM   ${schema}.stati_rpt_old;

INSERT INTO ${schema}.stati_rpt_snapshot
SELECT *
FROM   ${schema}.stati_rpt_snapshot_old;

INSERT INTO ${schema}.token_utility
SELECT *
FROM   ${schema}.token_utility_old;

INSERT INTO ${schema}.verifica_bollettino
SELECT *
FROM   ${schema}.verifica_bollettino_old;
