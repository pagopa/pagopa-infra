resource "azurerm_api_management_named_value" "ndp_eCommerce_trxId_ttl" {
  name                = "ndp-eCommerce-transactionId-ttl"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ndp-eCommerce-transactionId-ttl"
  value               = var.decoupler_configuration.ndp_eCommerce_trxId_ttl
}

resource "azurerm_api_management_named_value" "ndp_nodo_fc_nav_ttl" {
  name                = "ndp-nodo-fiscalCode-noticeNumber-ttl"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = "ndp-nodo-fiscalCode-noticeNumber-ttl"
  value               = var.decoupler_configuration.ndp_nodo_fc_nav_ttl
}
