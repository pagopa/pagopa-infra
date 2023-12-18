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
  name                  = "${local.project}-npg_notifications"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_ecommerce_npg_notification_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_npg_notification_api.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_ecommerce_npg_notification_api.description
  display_name = local.apim_ecommerce_npg_notification_api.display_name
  path         = local.apim_ecommerce_npg_notification_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_npg_notification_api.service_url

  import {
    content_format = "openapi"
    content_value  = file("./api/npg-notification/_openapi.json.tpl")
  }
}

resource "azurerm_api_management_product_api" "apim_ecommerce_npg_notifications_product_api" {
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_notifications.name
  product_id          = module.apim_ecommerce_product.product_id
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
}

resource "azurerm_api_management_api_policy" "apim_ecommerce_npg_notifications_policy" {
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_notifications.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/npg-notification/_base_policy.xml.tpl")
}

resource "azurerm_api_management_api_operation_policy" "npg_notifications_policy" {
  api_name            = azurerm_api_management_api.apim_ecommerce_npg_notifications.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "npgNotify"

  xml_content = templatefile("./api/npg-notification/_npg_notifications_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}

data "azurerm_key_vault_secret" "npg_notification_jwt_secret" {
  name         = "npg-notification-signing-key"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_api_management_named_value" "npg_notification_jwt_secret" {
  name                = "npg-notification-jwt-secret"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "npg-notification-jwt-secret"
  value               = data.azurerm_key_vault_secret.npg_notification_jwt_secret.value
  secret              = true
}
