data "azurerm_api_management_product" "gpd_payments_helpdesk_product" {
  product_id          = local.apim.product_id
  api_management_name = local.apim.name
  resource_group_name = local.apim.rg
}