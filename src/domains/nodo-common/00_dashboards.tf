locals {
  opex_nodo_auth_dashboard_config = {
    u = {
      excluded_backend_url = "https://10.79.20.63"
      operation_ids = {
        verifyPaymentNotice     = "6a5f497475a838165ccb1e3b"
        activatePaymentNotice   = "6a5f497475a838165ccb1e3c"
        sendPaymentOutcome      = "6a5f497475a838165ccb1e3d"
        activatePaymentNoticeV2 = "6a5f497475a838165ccb1e41"
        sendPaymentOutcomeV2    = "6a5f497475a838165ccb1e42"
      }
    }
    p = {
      excluded_backend_url = "https://10.79.20.25"
      operation_ids = {
        verifyPaymentNotice     = "63b6e2daea7c4a25440fda9f"
        activatePaymentNotice   = "63b6e2daea7c4a25440fdaa0"
        sendPaymentOutcome      = "63b6e2daea7c4a25440fdaa1"
        activatePaymentNoticeV2 = "63b6e2daea7c4a25440fdaa5"
        sendPaymentOutcomeV2    = "63b6e2daea7c4a25440fdaa6"
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
  })) : null
}

resource "azurerm_portal_dashboard" "opex_pagopa_nodo_auth" {
  count               = local.opex_nodo_auth_dashboard_json != null ? 1 : 0
  name                = "opex_pagopa-nodo-auth"
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