resource "azurerm_api_management_subscription" "api_config_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_api_config_product.id
  display_name        = "Subscription for Api Config APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "forwarder_subkey" {
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = data.azurerm_api_management_product.apim_forwarder_product.id
  display_name        = "Subscription for Forwarder APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "service_payment_options_subkey" {
  count = var.env_short != "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_payment_options_product[0].id
  display_name        = "Subscription for Payments Options APIM"
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_user" "user_psp_signed_direct_dev" {
  count = var.env_short == "d" ? 1 : 0

  user_id             = "user_psp_signed_direct_dev"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  first_name          = "99999000001"
  last_name           = "PSP Signed Direct"
  email               = "" // TODO
  state               = "active"
}

resource "azurerm_api_management_user" "user_psp_signed_direct_uat" { 
  count = var.env_short == "u" ? 1 : 0

  user_id             = "user_psp_signed_direct_uat"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  first_name          = "99999000011"
  last_name           = "PSP DEMO"
  email               = "" // TODO
  state               = "active"
}

resource "azurerm_api_management_subscription" "service_payment_options_subkey_test_dev" {
  count = var.env_short == "d" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_payment_options_product[0].id
  display_name        = "Subscription for Payments Options APIM Test"
  user_id             = data.azurerm_api_management_user.user_psp_signed_direct_dev.id
  allow_tracing       = false
  state               = "active"
}

resource "azurerm_api_management_subscription" "service_payment_options_subkey_test_uat" {
  count = var.env_short == "u" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_payment_options_product[0].id
  display_name        = "Subscription for Payments Options APIM Test"
  user_id             = data.azurerm_api_management_user.user_psp_signed_direct_uat.id
  allow_tracing       = false
  state               = "active"
}


