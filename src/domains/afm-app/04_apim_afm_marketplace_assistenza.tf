###################################################
## Product AFM Marketplace for Technical Support ##
###################################################

#fetch technical support api product APIM product
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}