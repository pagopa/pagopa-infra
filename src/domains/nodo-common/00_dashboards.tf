locals {
  # common list of operation IDs from the exported OpenAPI, grouped by service path, keyed by API name
  opex_nodo_auth_operation_ids = {
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
      node_for_ecommerce_v1 = {
        checkPosition = "checkPosition"
      }
      node_for_ecommerce_v2 = {
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
      node_for_ecommerce_v1 = {
        checkPosition = "checkPosition"
      }
      node_for_ecommerce_v2 = {
        closePaymentV2 = "closePaymentV2"
      }
    }
  }

  opex_nodo_auth_dashboard_config = {
    u = {
      excluded_backend_url = "https://10.79.20.63"
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.verificaBollettino
        demandPaymentNotice              = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_auth_operation_ids.u.node_for_psp_v1.nodoChiediTemplateInformativaPSP
      }
    }
    p = {
      excluded_backend_url = "https://10.79.20.25"
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.verificaBollettino
        demandPaymentNotice              = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_auth_operation_ids.p.node_for_psp_v1.nodoChiediTemplateInformativaPSP
      }
    }
  }

  opex_nodo_auth_dashboard_json = contains(keys(local.opex_nodo_auth_dashboard_config), var.env_short) ? jsondecode(templatefile("./dashboards/opex_pagopa-nodo-auth.json.tpl", {
    apim_id                    = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}"
    apim_name                  = local.pagopa_apim_name
    excluded_backend_url       = local.opex_nodo_auth_dashboard_config[var.env_short].excluded_backend_url
    op_verifyPaymentNotice     = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.verifyPaymentNotice
    op_activatePaymentNotice   = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.activatePaymentNotice
    op_activatePaymentNoticeV2 = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.activatePaymentNoticeV2
    op_sendPaymentOutcome      = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.sendPaymentOutcome
    op_sendPaymentOutcomeV2    = local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids.sendPaymentOutcomeV2
    handled_operation_ids_kql  = join(", ", [for id in values(local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids) : "'${id}'"])
    operation_names_kql        = join(", ", [for name, id in merge(local.opex_nodo_auth_dashboard_config[var.env_short].operation_ids, local.opex_nodo_auth_dashboard_config[var.env_short].unhandled_operation_ids) : "'${id}', '${name}'"])
  })) : null

  # all-auth dashboard: every API of the common list except the *FlussoRendicontazione / *FlussiRendicontazione ones
  opex_nodo_auth_all_dashboard_json = contains(keys(local.opex_nodo_auth_operation_ids), var.env_short) ? jsondecode(templatefile("./dashboards/opex_pagopa-nodo-auth-all.json.tpl", {
    apim_id   = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}"
    apim_name = local.pagopa_apim_name
    ops       = { for service, apis in local.opex_nodo_auth_operation_ids[var.env_short] : service => { for api, id in apis : api => id if !can(regex("Fluss[oi]Rendicontazione$", api)) } }
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
