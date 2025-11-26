ALTER TABLE ${schema}.carrello rename TO carrello_old;
ALTER TABLE ${schema}.carrello_parted rename TO carrello;

ALTER TABLE ${schema}.cd_info_pagamento rename TO cd_info_pagamento_old;
ALTER TABLE ${schema}.cd_info_pagamento_parted rename TO cd_info_pagamento;

ALTER TABLE ${schema}.idempotency_cache rename TO idempotency_cache_old;
ALTER TABLE ${schema}.idempotency_cache_parted rename TO idempotency_cache;

ALTER TABLE ${schema}.messaggi rename TO messaggi_old;
ALTER TABLE ${schema}.messaggi_parted rename TO messaggi;

ALTER TABLE ${schema}.pm_metadata rename TO pm_metadata_old;
ALTER TABLE ${schema}.pm_metadata_parted rename TO pm_metadata;

ALTER TABLE ${schema}.pm_session_data rename TO pm_session_data_old;
ALTER TABLE ${schema}.pm_session_data_parted rename TO pm_session_data;

ALTER TABLE ${schema}.position_activate rename TO position_activate_old;
ALTER TABLE ${schema}.position_activate_parted rename TO position_activate;

ALTER TABLE ${schema}.position_payment rename TO position_payment_old;
ALTER TABLE ${schema}.position_payment_parted rename TO position_payment;

ALTER TABLE ${schema}.position_payment_plan rename TO position_payment_plan_old;
ALTER TABLE ${schema}.position_payment_plan_parted rename TO position_payment_plan;

ALTER TABLE ${schema}.position_payment_status rename TO position_payment_status_old;
ALTER TABLE ${schema}.position_payment_status_parted rename TO position_payment_status;

ALTER TABLE ${schema}.position_payment_status_snapshot rename TO position_payment_status_snapshot_old;
ALTER TABLE ${schema}.position_payment_status_snapshot_parted rename TO position_payment_status_snapshot;

ALTER TABLE ${schema}.position_receipt rename TO position_receipt_old;
ALTER TABLE ${schema}.position_receipt_parted rename TO position_receipt;

ALTER TABLE ${schema}.position_receipt_recipient rename TO position_receipt_recipient_old;
ALTER TABLE ${schema}.position_receipt_recipient_parted rename TO position_receipt_recipient;

ALTER TABLE ${schema}.position_receipt_recipient_status rename TO position_receipt_recipient_status_old;
ALTER TABLE ${schema}.position_receipt_recipient_status_parted rename TO position_receipt_recipient_status;

ALTER TABLE ${schema}.position_receipt_transfer rename TO position_receipt_transfer_old;
ALTER TABLE ${schema}.position_receipt_transfer_parted rename TO position_receipt_transfer;

ALTER TABLE ${schema}.position_receipt_xml rename TO position_receipt_xml_old;
ALTER TABLE ${schema}.position_receipt_xml_parted rename TO position_receipt_xml;

ALTER TABLE ${schema}.position_retry_pa_send_rt rename TO position_retry_pa_send_rt_old;
ALTER TABLE ${schema}.position_retry_pa_send_rt_parted rename TO position_retry_pa_send_rt;

ALTER TABLE ${schema}.position_retry_sendpaymentresult rename TO position_retry_sendpaymentresult_old;
ALTER TABLE ${schema}.position_retry_sendpaymentresult_parted rename TO position_retry_sendpaymentresult;

ALTER TABLE ${schema}.position_service rename TO position_service_old;
ALTER TABLE ${schema}.position_service_parted rename TO position_service;

ALTER TABLE ${schema}.position_status rename TO position_status_old;
ALTER TABLE ${schema}.position_status_parted rename TO position_status;

ALTER TABLE ${schema}.position_status_snapshot rename TO position_status_snapshot_old;
ALTER TABLE ${schema}.position_status_snapshot_parted rename TO position_status_snapshot;

ALTER TABLE ${schema}.position_subject rename TO position_subject_old;
ALTER TABLE ${schema}.position_subject_parted rename TO position_subject;

ALTER TABLE ${schema}.position_transfer rename TO position_transfer_old;
ALTER TABLE ${schema}.position_transfer_parted rename TO position_transfer;

ALTER TABLE ${schema}.retry_pa_attiva_rpt rename TO retry_pa_attiva_rpt_old;
ALTER TABLE ${schema}.retry_pa_attiva_rpt_parted rename TO retry_pa_attiva_rpt;

ALTER TABLE ${schema}.retry_pa_invia_rt rename TO retry_pa_invia_rt_old;
ALTER TABLE ${schema}.retry_pa_invia_rt_parted rename TO retry_pa_invia_rt;

ALTER TABLE ${schema}.retry_rpt rename TO retry_rpt_old;
ALTER TABLE ${schema}.retry_rpt_parted rename TO retry_rpt;

ALTER TABLE ${schema}.rpt rename TO rpt_old;
ALTER TABLE ${schema}.rpt_parted rename TO rpt;

ALTER TABLE ${schema}.rpt_activations rename TO rpt_activations_old;
ALTER TABLE ${schema}.rpt_activations_parted rename TO rpt_activations;

ALTER TABLE ${schema}.rpt_soggetti rename TO rpt_soggetti_old;
ALTER TABLE ${schema}.rpt_soggetti_parted rename TO rpt_soggetti;

ALTER TABLE ${schema}.rpt_versamenti rename TO rpt_versamenti_old;
ALTER TABLE ${schema}.rpt_versamenti_parted rename TO rpt_versamenti;

ALTER TABLE ${schema}.rpt_versamenti_bollo rename TO rpt_versamenti_bollo_old;
ALTER TABLE ${schema}.rpt_versamenti_bollo_parted rename TO rpt_versamenti_bollo;

ALTER TABLE ${schema}.rpt_xml rename TO rpt_xml_old;
ALTER TABLE ${schema}.rpt_xml_parted rename TO rpt_xml;

ALTER TABLE ${schema}.rt rename TO rt_old;
ALTER TABLE ${schema}.rt_parted rename TO rt;

ALTER TABLE ${schema}.rt_versamenti rename TO rt_versamenti_old;
ALTER TABLE ${schema}.rt_versamenti_parted rename TO rt_versamenti;

ALTER TABLE ${schema}.rt_versamenti_bollo rename TO rt_versamenti_bollo_old;
ALTER TABLE ${schema}.rt_versamenti_bollo_parted rename TO rt_versamenti_bollo;

ALTER TABLE ${schema}.rt_xml rename TO rt_xml_old;
ALTER TABLE ${schema}.rt_xml_parted rename TO rt_xml;

ALTER TABLE ${schema}.stati_carrello rename TO stati_carrello_old;
ALTER TABLE ${schema}.stati_carrello_parted rename TO stati_carrello;

ALTER TABLE ${schema}.stati_carrello_snapshot rename TO stati_carrello_snapshot_old;
ALTER TABLE ${schema}.stati_carrello_snapshot_parted rename TO stati_carrello_snapshot;

ALTER TABLE ${schema}.stati_rpt rename TO stati_rpt_old;
ALTER TABLE ${schema}.stati_rpt_parted rename TO stati_rpt;

ALTER TABLE ${schema}.stati_rpt_snapshot rename TO stati_rpt_snapshot_old;
ALTER TABLE ${schema}.stati_rpt_snapshot_parted rename TO stati_rpt_snapshot;

ALTER TABLE ${schema}.token_utility rename TO token_utility_old;
ALTER TABLE ${schema}.token_utility_parted rename TO token_utility;

ALTER TABLE ${schema}.verifica_bollettino rename TO verifica_bollettino_old;
ALTER TABLE ${schema}.verifica_bollettino_parted rename TO verifica_bollettino;
