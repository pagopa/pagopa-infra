data "azurerm_api_management" "apim" {
  name                = "${var.prefix}-${var.env_short}-apim"
  resource_group_name = "${var.prefix}-${var.env_short}-api-rg"
}

data "azurerm_api_management_product" "apim_node_for_psp_product" {
  product_id          = "nodo-auth"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_carts_product" {
  product_id          = "checkout-carts"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gpd_payments_rest" {
  product_id          = "gpd-payments-rest-aks"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_api_management_product" "apim_gps_spontaneous_payments_services_product" {
  product_id          = "gps-spontaneous-payments-services"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_resource_group" "identity_rg" {
  name = "${local.product}-identity-rg"
}

data "azurerm_api_management_product" "apim_gdp_debt_positions_product" {
  product_id          = "test-gpd-payments-pull-and-debt-positions"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

data "azurerm_redis_cache" "redis_cache" {
  name                = var.redis_ha_enabled ? format("%s-%s-weu-redis", var.prefix, var.env_short) : format("%s-%s-redis", var.prefix, var.env_short)
  resource_group_name = format("%s-%s-data-rg", var.prefix, var.env_short)
}

data "azurerm_eventhub_authorization_rule" "pagopa_weu_core_evh_ns04_nodo_dei_pagamenti_cache_sync_reader" {
  name                = "nodo-dei-pagamenti-cache-sync-rx"
  namespace_name      = "${local.product}-${local.evt_hub_location}-evh-ns04"
  eventhub_name       = "nodo-dei-pagamenti-cache"
  resource_group_name = "${local.product}-msg-rg"
}

data "azurerm_api_management_user" "pagoapa_core_user" {
  # user_id             = var.env_short == "u" ? "349fab55-1fe5-4b89-92ac-5bdeabe3010e" : "2d6fe3c6-5656-43c8-afd4-ccf2bb352cec"
  user_id             = "pagopa-core-usr"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
}
