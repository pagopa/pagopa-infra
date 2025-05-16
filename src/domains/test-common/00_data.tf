# apim
data "azurerm_api_management" "apim" {
  name                = "${local.product}-apim"
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_resource_group" "rg_api" {
  name = "${local.product}-api-rg"
}

data "azurerm_api_management_product" "fdr_psp_product" {
  product_id          = "fdr-psp"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_api_management_product" "fdr_org_product" {
  product_id          = "fdr-org"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_api_management_product" "fdr_internal_product" {
  product_id          = "fdr_internal"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

data "azurerm_key_vault" "key_vault" {
  name                = "${local.product}-${var.domain}-kv"
  resource_group_name = "${local.product}-${var.domain}-sec-rg"
}
