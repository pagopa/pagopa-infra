alter table ${schema}.carrello rename to carrello_old;
alter table ${schema}.carrello_parted rename to carrello;

alter table ${schema}.cd_info_pagamento rename to cd_info_pagamento_old;
alter table ${schema}.cd_info_pagamento_parted rename to cd_info_pagamento;

alter table ${schema}.idempotency_cache rename to idempotency_cache_old;
alter table ${schema}.idempotency_cache_parted rename to idempotency_cache;

alter table ${schema}.messaggi rename to messaggi_old;
alter table ${schema}.messaggi_parted rename to messaggi;

alter table ${schema}.pm_metadata rename to pm_metadata_old;
alter table ${schema}.pm_metadata_parted rename to pm_metadata;

alter table ${schema}.pm_session_data rename to pm_session_data_old;
alter table ${schema}.pm_session_data_parted rename to pm_session_data;

alter table ${schema}.position_activate rename to position_activate_old;
alter table ${schema}.position_activate_parted rename to position_activate;

alter table ${schema}.position_payment rename to position_payment_old;
alter table ${schema}.position_payment_parted rename to position_payment;

alter table ${schema}.position_payment_plan rename to position_payment_plan_old;
alter table ${schema}.position_payment_plan_parted rename to position_payment_plan;

alter table ${schema}.position_payment_status rename to position_payment_status_old;
alter table ${schema}.position_payment_status_parted rename to position_payment_status;

alter table ${schema}.position_payment_status_snapshot rename to position_payment_status_snapshot_old;
alter table ${schema}.position_payment_status_snapshot_parted rename to position_payment_status_snapshot;

alter table ${schema}.position_receipt rename to position_receipt_old;
alter table ${schema}.position_receipt_parted rename to position_receipt;

alter table ${schema}.position_receipt_recipient rename to position_receipt_recipient_old;
alter table ${schema}.position_receipt_recipient_parted rename to position_receipt_recipient;

alter table ${schema}.position_receipt_recipient_status rename to position_receipt_recipient_status_old;
alter table ${schema}.position_receipt_recipient_status_parted rename to position_receipt_recipient_status;

alter table ${schema}.position_receipt_transfer rename to position_receipt_transfer_old;
alter table ${schema}.position_receipt_transfer_parted rename to position_receipt_transfer;

alter table ${schema}.position_receipt_xml rename to position_receipt_xml_old;
alter table ${schema}.position_receipt_xml_parted rename to position_receipt_xml;

alter table ${schema}.position_retry_pa_send_rt rename to position_retry_pa_send_rt_old;
alter table ${schema}.position_retry_pa_send_rt_parted rename to position_retry_pa_send_rt;

alter table ${schema}.position_retry_sendpaymentresult rename to position_retry_sendpaymentresult_old;
alter table ${schema}.position_retry_sendpaymentresult_parted rename to position_retry_sendpaymentresult;

alter table ${schema}.position_service rename to position_service_old;
alter table ${schema}.position_service_parted rename to position_service;

alter table ${schema}.position_status rename to position_status_old;
alter table ${schema}.position_status_parted rename to position_status;

alter table ${schema}.position_status_snapshot rename to position_status_snapshot_old;
alter table ${schema}.position_status_snapshot_parted rename to position_status_snapshot;

alter table ${schema}.position_subject rename to position_subject_old;
alter table ${schema}.position_subject_parted rename to position_subject;

alter table ${schema}.position_transfer rename to position_transfer_old;
alter table ${schema}.position_transfer_parted rename to position_transfer;

alter table ${schema}.retry_pa_attiva_rpt rename to retry_pa_attiva_rpt_old;
alter table ${schema}.retry_pa_attiva_rpt_parted rename to retry_pa_attiva_rpt;

alter table ${schema}.retry_pa_invia_rt rename to retry_pa_invia_rt_old;
alter table ${schema}.retry_pa_invia_rt_parted rename to retry_pa_invia_rt;

alter table ${schema}.retry_rpt rename to retry_rpt_old;
alter table ${schema}.retry_rpt_parted rename to retry_rpt;

alter table ${schema}.rpt rename to rpt_old;
alter table ${schema}.rpt_parted rename to rpt;

alter table ${schema}.rpt_activations rename to rpt_activations_old;
alter table ${schema}.rpt_activations_parted rename to rpt_activations;

alter table ${schema}.rpt_soggetti rename to rpt_soggetti_old;
alter table ${schema}.rpt_soggetti_parted rename to rpt_soggetti;

alter table ${schema}.rpt_versamenti rename to rpt_versamenti_old;
alter table ${schema}.rpt_versamenti_parted rename to rpt_versamenti;

alter table ${schema}.rpt_versamenti_bollo rename to rpt_versamenti_bollo_old;
alter table ${schema}.rpt_versamenti_bollo_parted rename to rpt_versamenti_bollo;

alter table ${schema}.rpt_xml rename to rpt_xml_old;
alter table ${schema}.rpt_xml_parted rename to rpt_xml;

alter table ${schema}.rt rename to rt_old;
alter table ${schema}.rt_parted rename to rt;

alter table ${schema}.rt_versamenti rename to rt_versamenti_old;
alter table ${schema}.rt_versamenti_parted rename to rt_versamenti;

alter table ${schema}.rt_versamenti_bollo rename to rt_versamenti_bollo_old;
alter table ${schema}.rt_versamenti_bollo_parted rename to rt_versamenti_bollo;

alter table ${schema}.rt_xml rename to rt_xml_old;
alter table ${schema}.rt_xml_parted rename to rt_xml;

alter table ${schema}.stati_carrello rename to stati_carrello_old;
alter table ${schema}.stati_carrello_parted rename to stati_carrello;

alter table ${schema}.stati_carrello_snapshot rename to stati_carrello_snapshot_old;
alter table ${schema}.stati_carrello_snapshot_parted rename to stati_carrello_snapshot;

alter table ${schema}.stati_rpt rename to stati_rpt_old;
alter table ${schema}.stati_rpt_parted rename to stati_rpt;

alter table ${schema}.stati_rpt_snapshot rename to stati_rpt_snapshot_old;
alter table ${schema}.stati_rpt_snapshot_parted rename to stati_rpt_snapshot;

alter table ${schema}.token_utility rename to token_utility_old;
alter table ${schema}.token_utility_parted rename to token_utility;

alter table ${schema}.verifica_bollettino rename to verifica_bollettino_old;
alter table ${schema}.verifica_bollettino_parted rename to verifica_bollettino;
