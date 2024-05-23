# Subscription key for Opex Dashboard
resource "azurerm_api_management_subscription" "opex_psp_subscription_key" {
  count = var.env_short == "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_psp_product.id
  display_name        = "PSP subscription key for Opex Dashboard"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "opex_org_subscription_key" {
  count = var.env_short == "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_org_product.id
  display_name        = "ORG subscription key for Opex Dashboard"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "opex_internal_subscription_key" {
  count = var.env_short == "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_internal_product.id
  display_name        = "INTERNAL subscription key for Opex Dashboard"
  allow_tracing       = false
  state               = "active"
}

# Subscription key for integration test
resource "azurerm_api_management_subscription" "test_psp_subscription_key" {
  count = var.env_short == "p" ? 0 : 1

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_psp_product.id
  display_name        = "PSP subscription key for integration/performance testing"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "test_org_subscription_key" {
  count = var.env_short == "p" ? 0 : 1

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_org_product.id
  display_name        = "ORG subscription key for integration/performance testing"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "test_internal_subscription_key" {
  count = var.env_short == "p" ? 0 : 1

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.fdr_internal_product.id
  display_name        = "INTERNAL subscription key for integration/performance testing"
  allow_tracing       = false
  state               = "active"
}
