resource "azurerm_api_management_named_value" "ndp_eCommerce_trxId_ttl" {
  name                = "ndp-eCommerce-transactionId-ttl"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ndp-eCommerce-transactionId-ttl"
  value               = var.decoupler_configuration.ndp_eCommerce_trxId_ttl
}

resource "azurerm_api_management_named_value" "ndp_nodo_fc_iuv_ttl" {
  name                = "ndp-nodo-fiscalCode-iuv-ttl"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ndp-nodo-fiscalCode-iuv-ttl"
  value               = var.decoupler_configuration.ndp_nodo_fc_iuv_ttl
}

resource "azurerm_api_management_named_value" "ndp_nodo_fc_nav_ttl" {
  name                = "ndp-nodo-fiscalCode-noticeNumber-ttl"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ndp-nodo-fiscalCode-noticeNumber-ttl"
  value               = var.decoupler_configuration.ndp_nodo_fc_nav_ttl
}

resource "azurerm_api_management_named_value" "api_config_aks" {
  name                = "apicfg-aks"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "apicfg-aks"
  value               = var.env_short == "p" ? "https://weu${var.env}.apiconfig.internal.platform.pagopa.it" : "https://weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
}
