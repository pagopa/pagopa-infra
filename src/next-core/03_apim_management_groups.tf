
resource "azurerm_api_management_group" "readonly" {
  name                = "read-only"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Read Only"
}

resource "azurerm_api_management_group" "checkout_rate_no_limit" {
  name                = "checkout-rate-no-limit"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Checkout rate no limit"
}

resource "azurerm_api_management_group" "checkout_rate_limit_300" {
  name                = "checkout-rate-limit-300"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Checkout rate limit 300"
}

resource "azurerm_api_management_group" "client_io" {
  name                = "client-io"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Client IO"
}

resource "azurerm_api_management_group" "centro_stella" {
  name                = "centro-stella"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Centro Stella"
}

resource "azurerm_api_management_group" "piattaforma_notifiche" {
  name                = "piattaforma-notifiche"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Piattaforma notifiche"
}

resource "azurerm_api_management_group" "payment_manager" {
  name                = "payment-manager"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Payment Manager"
}

resource "azurerm_api_management_group" "ecommerce" {
  name                = "ecommerce"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Ecommerce pagoPA"
}

resource "azurerm_api_management_group" "pda" {
  name                = "client-pda"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "Client PDA"
}
resource "azurerm_api_management_group" "gps_grp" {
  name                = "gps-spontaneous-payments"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "GPS Spontaneous Payments for ECs"
}
resource "azurerm_api_management_group" "afm_calculator" {
  name                = "afm-calculator"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "AFM Calculator for Node"
  description         = "API management group of AFM Calculator for Node"
}
resource "azurerm_api_management_group" "pagopa_core_grp" {
  name                = "pagopa-core-grp"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim[0].name
  display_name        = "pagoPa Core" #"https://groups.google.com/a/pagopa.it/g/pagopa-core/about"
}
