### EVH
data "azurerm_eventhub_authorization_rule" "payment_options_re_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-payment-options-re-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh"
}

data "azurerm_eventhub_authorization_rule" "pagopa-weu-core-evh-ns04_nodo-dei-pagamenti-cache-sync-rx" {
  name                = "nodo-dei-pagamenti-cache-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_eventhub_authorization_rule" "payment_options_re_authorization_rule" {
  name                = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-payment-options-re-rx"
  resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh-rg"
  eventhub_name       = "${var.prefix}-${var.domain}-evh"
  namespace_name      = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}-evh"
}

data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "apim_api_config_product" {
  product_id          = "product-api-config-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
