data "azurerm_api_management_product" "apim_receipts_internal_product" {
  product_id          = "receipts-internal"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
