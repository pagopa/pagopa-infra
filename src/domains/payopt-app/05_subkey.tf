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

# use for testing ( perf )

data "azurerm_api_management_user" "user_demo" {
  count = var.env_short != "p" ? 1 : 0
  # DEV -> 99999000001 PSP Signed Direct
  # UAT -> 99999000011 PSP DEMO
  user_id             = var.env_short == "u" ? "349fab55-1fe5-4b89-92ac-5bdeabe3010e" : "2d6fe3c6-5656-43c8-afd4-ccf2bb352cec"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
}
resource "azurerm_api_management_subscription" "service_payment_options_subkey" {
  depends_on = [data.azurerm_api_management_user.user_demo]
  count      = var.env_short != "p" ? 1 : 0

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  product_id          = module.apim_payment_options_product[0].id
  display_name        = "Subscription for Payments Options APIM"
  allow_tracing       = false
  state               = "active"
  user_id             = data.azurerm_api_management_user.user_demo[0].id # https://github.com/pagopa/pagopa-payment-options-service/blob/9d2682c700f72cfe3693a8a8a902b72fc8433af5/infra/policy/_get_payment_options_policy.xml#L13
}


