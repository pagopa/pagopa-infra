##############################
## API NPG notification     ##
##############################
locals {
  apim_ecommerce_npg_notification_api = {
    display_name          = "ecommerce pagoPA - NPG notification API"
    description           = "API to handle NPG notification POST request"
    path                  = "ecommerce/npg/notifications"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "apim_ecommerce_npg_notification_api" {
  name                = "${local.project}-npg_notifications"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_npg_notification_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_ecommerce_npg_notifications" {
  name                  = "${local.project}-nodo_mock"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_npg_notification_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_npg_notification_api[0].id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_npg_notification_api.description
  display_name = local.apim_ecommerce_npg_notification_api.display_name
  path         = local.apim_ecommerce_npg_notification_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_npg_notification_api.service_url

  import {
    content_format = "openapi"
    content_value = templatefile("./api/npg-notification/_openapi.json.tpl", {
      host = local.apim_hostname
    })
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_npg_notifications_product_api" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_notifications[0].name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_npg_notifications_policy" {
  count               = var.env_short == "u" ? 1 : 0
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_notifications[0].name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/npg-notification/_base_policy.xml.tpl")
}