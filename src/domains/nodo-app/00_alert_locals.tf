locals {
  # Operation IDs from the exported OpenAPI, grouped by service path, keyed by API name.
  # NOTE: copy of local.opex_nodo_operation_ids defined in nodo-common/00_dashboards.tf, keep them in sync.
  nodo_operation_ids = {
    u = {
      node_for_psp_v1 = {
        verifyPaymentNotice              = "6a5f497475a838165ccb1e3b"
        activatePaymentNotice            = "6a5f497475a838165ccb1e3c"
        sendPaymentOutcome               = "6a5f497475a838165ccb1e3d"
        verificaBollettino               = "6a5f497475a838165ccb1e3e"
        demandPaymentNotice              = "6a5f497475a838165ccb1e3f"
        nodoChiediCatalogoServiziV2      = "6a5f497475a838165ccb1e40"
        activatePaymentNoticeV2          = "6a5f497475a838165ccb1e41"
        sendPaymentOutcomeV2             = "6a5f497475a838165ccb1e42"
        nodoInviaFlussoRendicontazione   = "6a5f497475a838165ccb1e43"
        nodoChiediInformativaPA          = "6a5f497475a838165ccb1e44"
        nodoChiediTemplateInformativaPSP = "6a5f497475a838165ccb1e45"
      }
      nodo_per_pa_v1 = {
        nodoChiediStatoRPT                    = "6a5f489d75a838165ccb1c35"
        nodoChiediListaPendentiRPT            = "6a5f489d75a838165ccb1c36"
        nodoInviaRPT                          = "6a5f489d75a838165ccb1c37"
        nodoInviaCarrelloRPT                  = "6a5f489d75a838165ccb1c38"
        nodoChiediCopiaRT                     = "6a5f489d75a838165ccb1c39"
        nodoChiediInformativaPSP              = "6a5f489d75a838165ccb1c3a"
        nodoPAChiediInformativaPA             = "6a5f489d75a838165ccb1c3b"
        nodoChiediElencoQuadraturePA          = "6a5f489d75a838165ccb1c3c"
        nodoChiediQuadraturaPA                = "6a5f489d75a838165ccb1c3d"
        nodoChiediElencoFlussiRendicontazione = "6a5f489d75a838165ccb1c3e"
        nodoChiediFlussoRendicontazione       = "6a5f489d75a838165ccb1c3f"
      }
      nodo_per_psp_v1 = {
        nodoVerificaRPT                  = "6a5f489d75a838165ccb1c2e"
        nodoAttivaRPT                    = "6a5f489d75a838165ccb1c2f"
        nodoInviaRT                      = "6a5f489d75a838165ccb1c30"
        nodoChiediInformativaPA          = "6a5f489d75a838165ccb1c31"
        nodoChiediTemplateInformativaPSP = "6a5f489d75a838165ccb1c32"
        nodoChiediElencoQuadraturePSP    = "6a5f489d75a838165ccb1c33"
        nodoInviaFlussoRendicontazione   = "6a5f489d75a838165ccb1c34"
      }
      nodo_per_psp_richiesta_avvisi_v1 = {
        nodoChiediNumeroAvviso    = "6a5f489e75a838165ccb1c5d"
        nodoChiediCatalogoServizi = "6a5f489e75a838165ccb1c5e"
      }
      node_for_pa_v1 = {
        nodoChiediElencoFlussiRendicontazione = "6a5f48a175a838165ccb1c7f"
        nodoChiediFlussoRendicontazione       = "6a5f48a175a838165ccb1c80"
      }
      node_for_ecommerce_v1 = {
        checkPosition = "checkPosition"
      }
      node_for_ecommerce_v2 = {
        closePaymentV2 = "closePaymentV2"
      }
      node_for_psp_v1_noauth = {
        verifyPaymentNotice         = "6a5f489e75a838165ccb1c50"
        activatePaymentNotice       = "6a5f489e75a838165ccb1c51"
        sendPaymentOutcome          = "6a5f489e75a838165ccb1c52"
        verificaBollettino          = "6a5f489e75a838165ccb1c53"
        demandPaymentNotice         = "6a5f489e75a838165ccb1c54"
        nodoChiediCatalogoServiziV2 = "6a5f489e75a838165ccb1c55"
        activatePaymentNoticeV2     = "6a5f489e75a838165ccb1c56"
        sendPaymentOutcomeV2        = "6a5f489e75a838165ccb1c57"
      }
      nodo_per_pa_v1_noauth = {
        nodoChiediStatoRPT                    = "6a5f497875a838165ccb206c"
        nodoChiediListaPendentiRPT            = "6a5f497875a838165ccb206d"
        nodoInviaRPT                          = "6a5f497875a838165ccb206e"
        nodoInviaCarrelloRPT                  = "6a5f497875a838165ccb206f"
        nodoChiediCopiaRT                     = "6a5f497875a838165ccb2070"
        nodoChiediInformativaPSP              = "6a5f497875a838165ccb2071"
        nodoPAChiediInformativaPA             = "6a5f497875a838165ccb2072"
        nodoChiediElencoQuadraturePA          = "6a5f497875a838165ccb2073"
        nodoChiediQuadraturaPA                = "6a5f497875a838165ccb2074"
        nodoChiediElencoFlussiRendicontazione = "6a5f497875a838165ccb2075"
        nodoChiediFlussoRendicontazione       = "6a5f497875a838165ccb2076"
      }
      nodo_per_psp_v1_noauth = {
        nodoVerificaRPT                  = "6a5f497475a838165ccb1df8"
        nodoAttivaRPT                    = "6a5f497475a838165ccb1df9"
        nodoInviaRT                      = "6a5f497475a838165ccb1dfa"
        nodoChiediInformativaPA          = "6a5f497475a838165ccb1dfb"
        nodoChiediTemplateInformativaPSP = "6a5f497475a838165ccb1dfc"
        nodoChiediElencoQuadraturePSP    = "6a5f497475a838165ccb1dfd"
        nodoInviaFlussoRendicontazione   = "6a5f497475a838165ccb1dfe"
      }
      nodo_per_psp_richiesta_avvisi_v1_noauth = {
        nodoChiediNumeroAvviso    = "6a5f497975a838165ccb207b"
        nodoChiediCatalogoServizi = "6a5f497975a838165ccb207c"
      }
      nodo_per_pm_v1_noauth = {
        nodoChiediInformazioniPagamento = "nodoChiediInformazioniPagamento"
        nodoChiediAvanzamentoPagamento  = "nodoChiediAvanzamentoPagamento"
        nodoChiediListaPSP              = "nodoChiediListaPSP"
        nodoInoltraEsitoPagamentoCarta  = "nodoInoltraEsitoPagamentoCarta"
        nodoInoltraPagamentoMod1        = "nodoInoltraPagamentoMod1"
        nodoInoltraPagamentoMod2        = "nodoInoltraPagamentoMod2"
        nodoInoltraEsitoPagamentoPayPal = "nodoInoltraEsitoPagamentoPayPal"
        nodoNotificaAnnullamento        = "nodoNotificaAnnullamento"
        health                          = "health"
        closePayment                    = "closePayment"
        checkPosition                   = "checkPosition"
        parkedList                      = "parkedList"
      }
      nodo_per_pm_v2_noauth = {
        closePaymentV2 = "closePaymentV2"
      }
    }
    p = {
      node_for_psp_v1 = {
        verifyPaymentNotice              = "63b6e2daea7c4a25440fda9f"
        activatePaymentNotice            = "63b6e2daea7c4a25440fdaa0"
        sendPaymentOutcome               = "63b6e2daea7c4a25440fdaa1"
        verificaBollettino               = "63b6e2daea7c4a25440fdaa2"
        demandPaymentNotice              = "63b6e2daea7c4a25440fdaa3"
        nodoChiediCatalogoServiziV2      = "63b6e2daea7c4a25440fdaa4"
        activatePaymentNoticeV2          = "63b6e2daea7c4a25440fdaa5"
        sendPaymentOutcomeV2             = "63b6e2daea7c4a25440fdaa6"
        nodoInviaFlussoRendicontazione   = "63ff4f22aca2fd18dcc4a6f7"
        nodoChiediInformativaPA          = "63ff4f22aca2fd18dcc4a6f8"
        nodoChiediTemplateInformativaPSP = "63ff4f22aca2fd18dcc4a6f9"
      }
      nodo_per_pa_v1 = {
        nodoChiediElencoFlussiRendicontazione = "63b6e2da2a92e811a8f338f8"
        nodoChiediFlussoRendicontazione       = "63b6e2da2a92e811a8f338f9"
        nodoChiediStatoRPT                    = "63e5d8212a92e80448d38dfd"
        nodoChiediListaPendentiRPT            = "63e5d8212a92e80448d38dfe"
        nodoInviaRPT                          = "63e5d8212a92e80448d38dff"
        nodoInviaCarrelloRPT                  = "63e5d8212a92e80448d38e00"
        nodoChiediCopiaRT                     = "63e5d8212a92e80448d38e01"
        nodoChiediInformativaPSP              = "63e5d8212a92e80448d38e02"
        nodoPAChiediInformativaPA             = "63e5d8212a92e80448d38e03"
        nodoChiediElencoQuadraturePA          = "63e5d8212a92e80448d38e04"
        nodoChiediQuadraturaPA                = "63e5d8212a92e80448d38e05"
      }
      nodo_per_psp_v1 = {
        nodoVerificaRPT                  = "63b6e2da2a92e811a8f338fb"
        nodoAttivaRPT                    = "63b6e2da2a92e811a8f338fc"
        nodoInviaRT                      = "63b6e2da2a92e811a8f338fd"
        nodoChiediInformativaPA          = "63b6e2da2a92e811a8f338fe"
        nodoChiediTemplateInformativaPSP = "63b6e2da2a92e811a8f338ff"
        nodoChiediElencoQuadraturePSP    = "63b6e2da2a92e811a8f33900"
        nodoInviaFlussoRendicontazione   = "63b6e2da2a92e811a8f33901"
      }
      nodo_per_psp_richiesta_avvisi_v1 = {
        nodoChiediNumeroAvviso    = "63b6e2da2a92e811a8f338ed"
        nodoChiediCatalogoServizi = "63b6e2da2a92e811a8f338ee"
      }
      node_for_pa_v1 = {
        nodoChiediElencoFlussiRendicontazione = "63ff73adea7c4a1860530e3a"
        nodoChiediFlussoRendicontazione       = "63ff73adea7c4a1860530e3b"
      }
      node_for_ecommerce_v1 = {
        checkPosition = "checkPosition"
      }
      node_for_ecommerce_v2 = {
        closePaymentV2 = "closePaymentV2"
      }
      node_for_psp_v1_noauth = {
        verifyPaymentNotice         = "61dedafc2a92e81a0c7a58fb"
        activatePaymentNotice       = "61dedafc2a92e81a0c7a58fc"
        sendPaymentOutcome          = "61dedafc2a92e81a0c7a58fd"
        verificaBollettino          = "61dedafc2a92e81a0c7a58fe"
        demandPaymentNotice         = "62bb23bdea7c4a0f183fc065"
        nodoChiediCatalogoServiziV2 = "62bb23bdea7c4a0f183fc066"
        activatePaymentNoticeV2     = "63c559672a92e811a8f33a00"
        sendPaymentOutcomeV2        = "63c559672a92e811a8f33a01"
      }
      nodo_per_pa_v1_noauth = {
        nodoChiediElencoFlussiRendicontazione = "61e9633dea7c4a07cc7d480d"
        nodoChiediFlussoRendicontazione       = "61e9633dea7c4a07cc7d480e"
        nodoChiediStatoRPT                    = "62189aea2a92e81fa4f15ec4"
        nodoChiediListaPendentiRPT            = "62189aea2a92e81fa4f15ec5"
        nodoInviaRPT                          = "62189aea2a92e81fa4f15ec6"
        nodoInviaCarrelloRPT                  = "62189aea2a92e81fa4f15ec7"
        nodoChiediCopiaRT                     = "62189aea2a92e81fa4f15ec8"
        nodoChiediInformativaPSP              = "62189aea2a92e81fa4f15ec9"
        nodoPAChiediInformativaPA             = "62189aea2a92e81fa4f15eca"
        nodoChiediElencoQuadraturePA          = "62189aea2a92e81fa4f15ecb"
        nodoChiediQuadraturaPA                = "62189aea2a92e81fa4f15ecc"
      }
      nodo_per_psp_v1_noauth = {
        nodoVerificaRPT                  = "61dedafb2a92e81a0c7a58f5"
        nodoAttivaRPT                    = "61dedafc2a92e81a0c7a58f6"
        nodoInviaFlussoRendicontazione   = "61e9633eea7c4a07cc7d4811"
        nodoInviaRT                      = "6217ba1b2a92e81fa4f15e77"
        nodoChiediInformativaPA          = "6217ba1b2a92e81fa4f15e78"
        nodoChiediTemplateInformativaPSP = "6217ba1b2a92e81fa4f15e79"
        nodoChiediElencoQuadraturePSP    = "6217ba1b2a92e81fa4f15e7a"
      }
      nodo_per_psp_richiesta_avvisi_v1_noauth = {
        nodoChiediNumeroAvviso    = "6217ba1a2a92e81fa4f15e75"
        nodoChiediCatalogoServizi = "6217ba1b2a92e81fa4f15e76"
      }
      nodo_per_pm_v1_noauth = {
        nodoChiediInformazioniPagamento = "nodoChiediInformazioniPagamento"
        nodoChiediAvanzamentoPagamento  = "nodoChiediAvanzamentoPagamento"
        nodoChiediListaPSP              = "nodoChiediListaPSP"
        nodoInoltraEsitoPagamentoCarta  = "nodoInoltraEsitoPagamentoCarta"
        nodoInoltraPagamentoMod1        = "nodoInoltraPagamentoMod1"
        nodoInoltraPagamentoMod2        = "nodoInoltraPagamentoMod2"
        nodoNotificaAnnullamento        = "nodoNotificaAnnullamento"
        health                          = "health"
        nodoInoltraEsitoPagamentoPayPal = "nodoInoltraEsitoPagamentoPayPal"
        closePayment                    = "closePayment"
        checkPosition                   = "checkPosition"
        parkedList                      = "parkedList"
      }
      nodo_per_pm_v2_noauth = {
        closePaymentV2 = "closePaymentV2"
      }
    }
  }

  # API groups monitored by the alerts. The key must match a group in local.nodo_operation_ids.
  #  - sub_service: APIM API path used to filter the requests (url_s) of the whole group
  #  - excluded_operations: operations of the group that must not be monitored
  # Groups not listed here (e.g. node_for_pa_v1, nodo_per_pm_*) are not monitored.
  alert_api_groups = {
    node_for_psp_v1                         = { sub_service = "nodo-auth/node-for-psp", excluded_operations = [] }
    node_for_psp_v1_noauth                  = { sub_service = "nodo/node-for-psp", excluded_operations = [] }
    nodo_per_pa_v1                          = { sub_service = "nodo-auth/nodo-per-pa", excluded_operations = ["nodoChiediCopiaRT"] }
    nodo_per_pa_v1_noauth                   = { sub_service = "nodo/nodo-per-pa", excluded_operations = [] }
    nodo_per_psp_v1                         = { sub_service = "nodo-auth/nodo-per-psp", excluded_operations = [] }
    nodo_per_psp_v1_noauth                  = { sub_service = "nodo/nodo-per-psp", excluded_operations = [] }
    nodo_per_psp_richiesta_avvisi_v1        = { sub_service = "nodo-auth/nodo-per-psp-richiesta-avvisi", excluded_operations = [] }
    nodo_per_psp_richiesta_avvisi_v1_noauth = { sub_service = "nodo/nodo-per-psp-richiesta-avvisi", excluded_operations = [] }
    node_for_ecommerce_v1                   = { sub_service = "nodo-auth/node-for-ecommerce", excluded_operations = [] }
    node_for_ecommerce_v2                   = { sub_service = "nodo-auth/node-for-ecommerce", excluded_operations = [] }
  }

  # Operation IDs of the current environment (empty if the environment is not mapped, e.g. dev)
  env_operation_ids = lookup(local.nodo_operation_ids, var.env_short, {})

  # Monitored groups of the current environment: sub_service + map primitiva => operation id
  grouped_operation_sets = {
    for group, cfg in local.alert_api_groups : group => {
      sub_service = cfg.sub_service
      operations = {
        for primitiva, operation_id in local.env_operation_ids[group] : primitiva => operation_id
        if !contains(cfg.excluded_operations, primitiva)
      }
    }
    if contains(keys(local.env_operation_ids), group)
  }

  # Per group: sub_service + datatable rows ("operationId", "primitiva") for KQL queries
  formatted_operation_data = {
    for group, data in local.grouped_operation_sets : group => {
      sub_service = data.sub_service
      formatted_operations = join(",\n  ", [
        for primitiva, operation_id in data.operations : "\"${operation_id}\", \"${primitiva}\""
      ])
    }
  }

  # One entry per single API operation, used to create one alert per operation.
  single_operation_data = {
    for item in flatten([
      for group, data in local.grouped_operation_sets : [
        for primitiva, operation_id in data.operations : {
          key          = "${group}-${primitiva}"
          group        = group
          operation_id = operation_id
          primitiva    = primitiva
          sub_service  = data.sub_service
        }
      ]
    ]) : item.key => item
  }

  fault_code_alert_groups = ["node_for_psp_v1"]

  # Groups for which per-operation PagoPA Nodo (pagopa_nodo_ingress) availability and fault code alerts are created
  nodo_pagopa_alert_groups = ["node_for_psp_v1"]

  # node_for_psp_v1 operations that are expected to be handled by Nodo PagoPA.
  # Any other operation routed to Nodo PagoPA triggers the unhandled API invocation alert.
  nodo_pagopa_handled_primitive = [
    "verifyPaymentNotice",
    "activatePaymentNotice",
    "sendPaymentOutcome",
    "activatePaymentNoticeV2",
    "sendPaymentOutcomeV2",
  ]
  nodo_pagopa_handled_operation_ids = [
    for primitiva, operation_id in try(local.grouped_operation_sets["node_for_psp_v1"].operations, {}) : operation_id
    if contains(local.nodo_pagopa_handled_primitive, primitiva)
  ]


  # Evaluation timing and thresholds of the per-operation availability alerts, per environment.
  #  - timing.frequency / timing.time_window: alert evaluation frequency and lookback window (minutes)
  #  - timing.bin_size: size of the time bins used to compute the availability (minutes)
  #  - timing.align_bin_to_now: if true bins are aligned to now() (bin_at), so the whole window is a single bin;
  #    if false bins are aligned to the clock (bin), as in the original prod alerts
  #  - timing.throttling: minutes during which the same alert is not fired again (null = disabled)
  #  - thresholds.<alert>.min_calls: minimum number of calls in a bin to evaluate the availability
  #  - thresholds.<alert>.traffic_min / traffic_linear / low_availability / high_availability:
  #    expected availability is low_availability under traffic_min calls, high_availability over traffic_linear calls
  #    and linear in between. With low_availability == high_availability the expected availability is fixed.
  # Prod: original values (7m window, traffic based thresholds).
  # UAT: low traffic (a few calls per API every 5 minutes), so a longer window and a fixed 50% threshold
  #      are used to detect broken APIs instead of quality degradation.
  alert_config = {
    p = {
      timing = {
        frequency        = 5
        time_window      = 7
        bin_size         = 7
        align_bin_to_now = false
        throttling       = null
      }
      thresholds = {
        # min_calls = 6 is equivalent to the original "Total > 5" filter
        apim_availability             = { min_calls = 6, traffic_min = 20, traffic_linear = 90, low_availability = 80, high_availability = 98 }
        fault_code_availability       = { min_calls = 1, traffic_min = 150, traffic_linear = 400, low_availability = 95, high_availability = 97 }
        nodo_pagopa_apim_availability = { min_calls = 1, traffic_min = 100, traffic_linear = 200, low_availability = 92, high_availability = 99 }
        nodo_pagopa_fault_code        = { min_calls = 1, traffic_min = 100, traffic_linear = 200, low_availability = 95, high_availability = 97 }
      }
    }
    u = {
      timing = {
        frequency        = 10
        time_window      = 30
        bin_size         = 30
        align_bin_to_now = true
        throttling       = 30
      }
      thresholds = {
        apim_availability             = { min_calls = 5, traffic_min = 5, traffic_linear = 5, low_availability = 50, high_availability = 50 }
        fault_code_availability       = { min_calls = 5, traffic_min = 5, traffic_linear = 5, low_availability = 50, high_availability = 50 }
        nodo_pagopa_apim_availability = { min_calls = 5, traffic_min = 5, traffic_linear = 5, low_availability = 50, high_availability = 50 }
        nodo_pagopa_fault_code        = { min_calls = 5, traffic_min = 5, traffic_linear = 5, low_availability = 50, high_availability = 50 }
      }
    }
  }

  # Config of the current environment (falls back to prod values, alerts are not created where no operation IDs are mapped)
  alert_timing     = lookup(local.alert_config, var.env_short, local.alert_config.p).timing
  alert_thresholds = lookup(local.alert_config, var.env_short, local.alert_config.p).thresholds

  # KQL bin expression per time column (TimeGenerated for AzureDiagnostics, timestamp for App Insights)
  alert_bin_kql = {
    for column in ["TimeGenerated", "timestamp"] : column => (
      local.alert_timing.align_bin_to_now
      ? "bin_at(${column}, ${local.alert_timing.bin_size}m, now())"
      : "bin(${column}, ${local.alert_timing.bin_size}m)"
    )
  }

  error_fault_code = "('${join("', '", ["PPT_AUTENTICAZIONE", "PPT_SYSTEM_ERROR", "PPT_ERRORE_IDEMPOTENZA"])}')"

  // Nodo SOAP path
  nodo_soap_path = "/nodo/webservices/input"
  // Nodo SOAP path short
  nodo_soap_path_short = "/webservices/input"

  // PagoPA Nodo ingress
  pagopa_nodo_ingress = "https://${local.nodo_hostname}"

  # Default alert action groups: slack channel and email
  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack_pagopa_pagamenti_alert.id]
  # If production and severity is higher than severity 3, the alert is forwarder to opsgenie action group
  action_groups            = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]) : local.action_groups_default
  nodo_alert_action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]) : [data.azurerm_monitor_action_group.slack.id]
  # In case of alert with severity SEV3 it isn't forwarder to opsgenie, but only on slack channel and email
  action_groups_sev3 = var.env_short == "p" ? concat(local.action_groups_default) : local.action_groups_default
}
