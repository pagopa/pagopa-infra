locals {
  # common list of operation IDs from the exported OpenAPI, keyed by <service>_<api>
  opex_nodo_auth_operation_ids = {
    u = {
      nm3_verifyPaymentNotice                  = "6a5f497475a838165ccb1e3b"
      nm3_activatePaymentNotice                = "6a5f497475a838165ccb1e3c"
      nm3_sendPaymentOutcome                   = "6a5f497475a838165ccb1e3d"
      nm3_verificaBollettino                   = "6a5f497475a838165ccb1e3e"
      nm3_demandPaymentNotice                  = "6a5f497475a838165ccb1e3f"
      nm3_nodoChiediCatalogoServiziV2          = "6a5f497475a838165ccb1e40"
      nm3_activatePaymentNoticeV2              = "6a5f497475a838165ccb1e41"
      nm3_sendPaymentOutcomeV2                 = "6a5f497475a838165ccb1e42"
      nm3_nodoInviaFlussoRendicontazione       = "6a5f497475a838165ccb1e43"
      nm3_nodoChiediInformativaPA              = "6a5f497475a838165ccb1e44"
      nm3_nodoChiediTemplateInformativaPSP     = "6a5f497475a838165ccb1e45"
      pa_nodoChiediStatoRPT                    = "6a5f489d75a838165ccb1c35"
      pa_nodoChiediListaPendentiRPT            = "6a5f489d75a838165ccb1c36"
      pa_nodoInviaRPT                          = "6a5f489d75a838165ccb1c37"
      pa_nodoInviaCarrelloRPT                  = "6a5f489d75a838165ccb1c38"
      pa_nodoChiediCopiaRT                     = "6a5f489d75a838165ccb1c39"
      pa_nodoChiediInformativaPSP              = "6a5f489d75a838165ccb1c3a"
      pa_nodoPAChiediInformativaPA             = "6a5f489d75a838165ccb1c3b"
      pa_nodoChiediElencoQuadraturePA          = "6a5f489d75a838165ccb1c3c"
      pa_nodoChiediQuadraturaPA                = "6a5f489d75a838165ccb1c3d"
      pa_nodoChiediElencoFlussiRendicontazione = "6a5f489d75a838165ccb1c3e"
      pa_nodoChiediFlussoRendicontazione       = "6a5f489d75a838165ccb1c3f"
      psp_nodoVerificaRPT                      = "6a5f489d75a838165ccb1c2e"
      psp_nodoAttivaRPT                        = "6a5f489d75a838165ccb1c2f"
      psp_nodoInviaRT                          = "6a5f489d75a838165ccb1c30"
      psp_nodoChiediInformativaPA              = "6a5f489d75a838165ccb1c31"
      psp_nodoChiediTemplateInformativaPSP     = "6a5f489d75a838165ccb1c32"
      psp_nodoChiediElencoQuadraturePSP        = "6a5f489d75a838165ccb1c33"
      psp_nodoInviaFlussoRendicontazione       = "6a5f489d75a838165ccb1c34"
      ra_nodoChiediNumeroAvviso                = "6a5f489e75a838165ccb1c5d"
      ra_nodoChiediCatalogoServizi             = "6a5f489e75a838165ccb1c5e"
    }
    p = {
      nm3_verifyPaymentNotice                  = "63b6e2daea7c4a25440fda9f"
      nm3_activatePaymentNotice                = "63b6e2daea7c4a25440fdaa0"
      nm3_sendPaymentOutcome                   = "63b6e2daea7c4a25440fdaa1"
      nm3_verificaBollettino                   = "63b6e2daea7c4a25440fdaa2"
      nm3_demandPaymentNotice                  = "63b6e2daea7c4a25440fdaa3"
      nm3_nodoChiediCatalogoServiziV2          = "63b6e2daea7c4a25440fdaa4"
      nm3_activatePaymentNoticeV2              = "63b6e2daea7c4a25440fdaa5"
      nm3_sendPaymentOutcomeV2                 = "63b6e2daea7c4a25440fdaa6"
      nm3_nodoInviaFlussoRendicontazione       = "63ff4f22aca2fd18dcc4a6f7"
      nm3_nodoChiediInformativaPA              = "63ff4f22aca2fd18dcc4a6f8"
      nm3_nodoChiediTemplateInformativaPSP     = "63ff4f22aca2fd18dcc4a6f9"
      pa_nodoChiediElencoFlussiRendicontazione = "63b6e2da2a92e811a8f338f8"
      pa_nodoChiediFlussoRendicontazione       = "63b6e2da2a92e811a8f338f9"
      pa_nodoChiediStatoRPT                    = "63e5d8212a92e80448d38dfd"
      pa_nodoChiediListaPendentiRPT            = "63e5d8212a92e80448d38dfe"
      pa_nodoInviaRPT                          = "63e5d8212a92e80448d38dff"
      pa_nodoInviaCarrelloRPT                  = "63e5d8212a92e80448d38e00"
      pa_nodoChiediCopiaRT                     = "63e5d8212a92e80448d38e01"
      pa_nodoChiediInformativaPSP              = "63e5d8212a92e80448d38e02"
      pa_nodoPAChiediInformativaPA             = "63e5d8212a92e80448d38e03"
      pa_nodoChiediElencoQuadraturePA          = "63e5d8212a92e80448d38e04"
      pa_nodoChiediQuadraturaPA                = "63e5d8212a92e80448d38e05"
      psp_nodoVerificaRPT                      = "63b6e2da2a92e811a8f338fb"
      psp_nodoAttivaRPT                        = "63b6e2da2a92e811a8f338fc"
      psp_nodoInviaRT                          = "63b6e2da2a92e811a8f338fd"
      psp_nodoChiediInformativaPA              = "63b6e2da2a92e811a8f338fe"
      psp_nodoChiediTemplateInformativaPSP     = "63b6e2da2a92e811a8f338ff"
      psp_nodoChiediElencoQuadraturePSP        = "63b6e2da2a92e811a8f33900"
      psp_nodoInviaFlussoRendicontazione       = "63b6e2da2a92e811a8f33901"
      ra_nodoChiediNumeroAvviso                = "63b6e2da2a92e811a8f338ed"
      ra_nodoChiediCatalogoServizi             = "63b6e2da2a92e811a8f338ee"
    }
  }

  opex_nodo_auth_dashboard_config = {
    u = {
      excluded_backend_url = "https://10.79.20.63"
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_auth_operation_ids.u.nm3_verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_auth_operation_ids.u.nm3_activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_auth_operation_ids.u.nm3_sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_auth_operation_ids.u.nm3_activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_auth_operation_ids.u.nm3_sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_auth_operation_ids.u.nm3_verificaBollettino
        demandPaymentNotice              = local.opex_nodo_auth_operation_ids.u.nm3_demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_auth_operation_ids.u.nm3_nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_auth_operation_ids.u.nm3_nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_auth_operation_ids.u.nm3_nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_auth_operation_ids.u.nm3_nodoChiediTemplateInformativaPSP
      }
    }
    p = {
      excluded_backend_url = "https://10.79.20.25"
      operation_ids = {
        verifyPaymentNotice     = local.opex_nodo_auth_operation_ids.p.nm3_verifyPaymentNotice
        activatePaymentNotice   = local.opex_nodo_auth_operation_ids.p.nm3_activatePaymentNotice
        sendPaymentOutcome      = local.opex_nodo_auth_operation_ids.p.nm3_sendPaymentOutcome
        activatePaymentNoticeV2 = local.opex_nodo_auth_operation_ids.p.nm3_activatePaymentNoticeV2
        sendPaymentOutcomeV2    = local.opex_nodo_auth_operation_ids.p.nm3_sendPaymentOutcomeV2
      }
      unhandled_operation_ids = {
        verificaBollettino               = local.opex_nodo_auth_operation_ids.p.nm3_verificaBollettino
        demandPaymentNotice              = local.opex_nodo_auth_operation_ids.p.nm3_demandPaymentNotice
        nodoChiediCatalogoServiziV2      = local.opex_nodo_auth_operation_ids.p.nm3_nodoChiediCatalogoServiziV2
        nodoInviaFlussoRendicontazione   = local.opex_nodo_auth_operation_ids.p.nm3_nodoInviaFlussoRendicontazione
        nodoChiediInformativaPA          = local.opex_nodo_auth_operation_ids.p.nm3_nodoChiediInformativaPA
        nodoChiediTemplateInformativaPSP = local.opex_nodo_auth_operation_ids.p.nm3_nodoChiediTemplateInformativaPSP
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
    ops       = { for key, id in local.opex_nodo_auth_operation_ids[var.env_short] : key => id if !can(regex("Fluss[oi]Rendicontazione$", key)) }
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
