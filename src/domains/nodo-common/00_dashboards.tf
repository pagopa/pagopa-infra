locals {
  # common list of operation IDs from the exported OpenAPI, grouped by service path, keyed by API name
  opex_nodo_operation_ids = {
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

  # Nodo instances: identifiers and backend of the Nexi Postgres one
  opex_nodo_nodes = {
    u = {
      pagopa_postgres_id    = "NDP001UAT"
      nexi_postgres_id      = "NDP004UAT"
      nexi_postgres_backend = "https://10.79.20.63"
      grafana_url           = "https://pagopa-u-weu-grafana-cpavbjb0axhrdcg3.weu.grafana.azure.com/d/aepmv9bibr0u8c/preview-manual-ndp-transactions-monitoring"
      kibana_url            = "https://pagopa-s-weu-ec.kb.westeurope.azure.elastic-cloud.com/s/ndp-uat/app/dashboards#/view/1e045fcc-569d-49ce-8798-d40b3ac23aad?_g=%28refreshInterval:%28pause:!t,value:60000%29,time:%28from:now-15m,to:now%29%29&_a=%28viewMode:view%29"
    }
    p = {
      pagopa_postgres_id    = "NDP001PROD"
      nexi_postgres_id      = "NDP004PROD"
      nexi_postgres_backend = "https://10.79.20.25"
      grafana_url           = "https://pagopa-p-weu-grafana-avb5f4e0fqawgyea.weu.grafana.azure.com/d/aepmv9bibr0u8c/preview-manual-ndp-transactions-monitoring?orgId=1&var-domainIdSearchFilter=&var-noticeNumberSearchFilter=&var-paymentTokenSearchFilter=&var-verifiedOnInstance=No%20filter&var-activatedOnInstance=No%20filter&from=now-30m&to=now"
      kibana_url            = ""
    }
  }

  opex_nodo_auth_dashboard_config = {
    u = {
      excluded_backend_url = local.opex_nodo_nodes.u.nexi_postgres_backend
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_operation_ids.u.node_for_psp_v1.verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_operation_ids.u.node_for_psp_v1.activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_operation_ids.u.node_for_psp_v1.sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_operation_ids.u.node_for_psp_v1.activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_operation_ids.u.node_for_psp_v1.sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_operation_ids.u.node_for_psp_v1.verificaBollettino
        demandPaymentNotice              = local.opex_nodo_operation_ids.u.node_for_psp_v1.demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_operation_ids.u.node_for_psp_v1.nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_operation_ids.u.node_for_psp_v1.nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_operation_ids.u.node_for_psp_v1.nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_operation_ids.u.node_for_psp_v1.nodoChiediTemplateInformativaPSP
      }
    }
    p = {
      excluded_backend_url = local.opex_nodo_nodes.p.nexi_postgres_backend
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_operation_ids.p.node_for_psp_v1.verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_operation_ids.p.node_for_psp_v1.activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_operation_ids.p.node_for_psp_v1.sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_operation_ids.p.node_for_psp_v1.activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_operation_ids.p.node_for_psp_v1.sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_operation_ids.p.node_for_psp_v1.verificaBollettino
        demandPaymentNotice              = local.opex_nodo_operation_ids.p.node_for_psp_v1.demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_operation_ids.p.node_for_psp_v1.nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_operation_ids.p.node_for_psp_v1.nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_operation_ids.p.node_for_psp_v1.nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_operation_ids.p.node_for_psp_v1.nodoChiediTemplateInformativaPSP
      }
    }
  }

  opex_nodo_auth_dashboard_json = contains(keys(local.opex_nodo_auth_dashboard_config), var.env_short) ? jsondecode(templatefile("./dashboards/opex_pagopa-nodo-auth.json.tpl", {
    apim_id                    = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}"
    apim_name                  = local.pagopa_apim_name
    excluded_backend_url       = local.opex_nodo_auth_dashboard_config[var.env_short].excluded_backend_url
    nodo_host                  = "weu${var.env}.nodo.${local.internal_dns_zone_name}"
    op_verifyPaymentNotice     = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.verifyPaymentNotice
    op_activatePaymentNotice   = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.activatePaymentNotice
    op_activatePaymentNoticeV2 = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.activatePaymentNoticeV2
    op_sendPaymentOutcome      = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.sendPaymentOutcome
    op_sendPaymentOutcomeV2    = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.sendPaymentOutcomeV2
    handled_operation_ids_kql  = join(", ", [for id in values(local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids) : "'${id}'"])
    operation_names_kql        = join(", ", [for name, id in merge(local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids, local.opex_nodo_auth_dashboard_config[var.env_short].unhandled_operation_ids) : "'${id}', '${name}'"])
  })) : null

  opex_nodo_auth_all_dashboard_json = contains(keys(local.opex_nodo_operation_ids), var.env_short) ? jsondecode(templatefile("./dashboards/opex_pagopa-nodo-auth-all.json.tpl", {
    apim_id   = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}"
    apim_name = local.pagopa_apim_name
    ops       = local.opex_nodo_operation_ids[var.env_short]
  })) : null

  opex_nodo_multinode_all_operation_ids = {
    for env_short, groups in local.opex_nodo_operation_ids :
    env_short => distinct(flatten([for group in values(groups) : values(group)]))
  }

  opex_nodo_multinode_ops = lookup(local.opex_nodo_operation_ids, var.env_short, {})

  # references to the operation ids of the deprecated primitives
  opex_nodo_multinode_deprecated_operation_ids = try([
    local.opex_nodo_multinode_ops.node_for_psp_v1.nodoChiediInformativaPA,
    local.opex_nodo_multinode_ops.node_for_psp_v1.nodoChiediTemplateInformativaPSP,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1.nodoChiediCopiaRT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediCopiaRT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediElencoQuadraturePA,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediInformativaPSP,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediListaPendentiRPT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediQuadraturaPA,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoChiediStatoRPT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoInviaCarrelloRPT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoInviaRPT,
    local.opex_nodo_multinode_ops.nodo_per_pa_v1_noauth.nodoPAChiediInformativaPA,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.closePayment,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoChiediAvanzamentoPagamento,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoChiediInformazioniPagamento,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoChiediListaPSP,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoInoltraEsitoPagamentoCarta,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoInoltraEsitoPagamentoPayPal,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoInoltraPagamentoMod1,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoInoltraPagamentoMod2,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.nodoNotificaAnnullamento,
    local.opex_nodo_multinode_ops.nodo_per_pm_v1_noauth.parkedList,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoAttivaRPT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoChiediElencoQuadraturePSP,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoChiediInformativaPA,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoInviaRT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoVerificaRPT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1.nodoChiediTemplateInformativaPSP,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoAttivaRPT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoChiediElencoQuadraturePSP,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoChiediInformativaPA,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoInviaRT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoVerificaRPT,
    local.opex_nodo_multinode_ops.nodo_per_psp_v1_noauth.nodoChiediTemplateInformativaPSP,
  ], [])

  # api structure (id, name, deprecated) built once, keyed by service group and operation
  opex_nodo_multinode_apis = {
    for group, operations in local.opex_nodo_multinode_ops : group => {
      for name, id in operations : name => {
        id         = id
        name       = name
        deprecated = contains(local.opex_nodo_multinode_deprecated_operation_ids, id)
      }
    }
  }

  opex_nodo_multinode_monitored_apis_kql = "datatable(operationId_s: string, primitive: string, deprecated: bool)[${join(", ", distinct(flatten([
    for group, operations in local.opex_nodo_multinode_apis : [
      for name, api in operations : "'${api.id}', '${api.name}', ${api.deprecated}"
    ]
  ])))}]"
  opex_nodo_multinode_dashboard_json = contains(keys(local.opex_nodo_nodes), var.env_short) ? jsondecode(templatefile("./dashboards/multi-node-monitoring-ndp.json.tpl", {
    apim_id               = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}"
    apim_name             = local.pagopa_apim_name
    appinsights_id        = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.monitor_resource_group_name}/providers/microsoft.insights/components/${local.application_insights_name}"
    appinsights_name      = local.application_insights_name
    nodo_host             = "weu${var.env}.nodo.${local.internal_dns_zone_name}"
    fdr_host              = "weu${var.env}.fdr.${local.internal_dns_zone_name}"
    nexi_postgres_backend = local.opex_nodo_nodes[var.env_short].nexi_postgres_backend
    nexi_postgres_id      = local.opex_nodo_nodes[var.env_short].nexi_postgres_id
    pagopa_postgres_id    = local.opex_nodo_nodes[var.env_short].pagopa_postgres_id
    grafana_url           = local.opex_nodo_nodes[var.env_short].grafana_url
    kibana_url            = local.opex_nodo_nodes[var.env_short].kibana_url
    all_operation_ids     = join(", ", [for id in local.opex_nodo_multinode_all_operation_ids[var.env_short] : "'${id}'"])
    apis                  = local.opex_nodo_multinode_apis
    monitored_apis_kql    = local.opex_nodo_multinode_monitored_apis_kql
  })) : null
}

resource "azurerm_portal_dashboard" "opex_pagopa_nodo_auth_nm3_only_pagopa_node" {
  count               = local.opex_nodo_auth_dashboard_json != null ? 1 : 0
  name                = "opex_${var.env_short}_pagopa-nodo-auth-nm3-only-PagoPA-node"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }

  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      local.opex_nodo_auth_dashboard_json.properties,
      {
        "lenses" = {
          for lens_index, lens in local.opex_nodo_auth_dashboard_json.properties.lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  )
}

resource "azurerm_portal_dashboard" "opex_pagopa_nodo_auth_all" {
  count               = local.opex_nodo_auth_all_dashboard_json != null ? 1 : 0
  name                = "opex_${var.env_short}_pagopa-nodo-auth-all"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }

  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      local.opex_nodo_auth_all_dashboard_json.properties,
      {
        "lenses" = {
          for lens_index, lens in local.opex_nodo_auth_all_dashboard_json.properties.lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  )
}

resource "azurerm_portal_dashboard" "opex_pagopa_nodo_multi_node_monitoring" {
  count               = local.opex_nodo_multinode_dashboard_json != null ? 1 : 0
  name                = "opex_${var.env_short}_pagopa-multi-node-monitoring-ndp"
  resource_group_name = var.monitor_resource_group_name
  location            = var.location
  tags = {
    source = "terraform"
  }

  #convert json dashboard output from Azure export function to the one handled by azurerm portal dashboard provider
  #see https://github.com/hashicorp/terraform-provider-azurerm/issues/27117 issue for more info
  dashboard_properties = jsonencode(
    merge(
      local.opex_nodo_multinode_dashboard_json.properties,
      {
        "lenses" = {
          for lens_index, lens in local.opex_nodo_multinode_dashboard_json.properties.lenses :
          tostring(lens_index) => merge(lens, {
            "parts" = {
              for part_index, part in lens.parts :
              tostring(part_index) => part
            }
          })
        }
      }
    )
  )
}
