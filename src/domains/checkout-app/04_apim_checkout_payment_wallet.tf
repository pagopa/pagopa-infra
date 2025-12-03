locals {
  apim_checkout_payment_wallet_api = {
    display_name          = "Checkout pagoPA Payment Wallet"
    description           = "Checkout APIs dedicated to wallet domain integration."
    path                  = "checkout/payment-wallet"
    subscription_required = false
    service_url           = null
  }
}

module "apim_checkout_payment_wallet_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "checkout-payment-wallet"
  display_name = local.apim_checkout_payment_wallet_api.display_name
  description  = local.apim_checkout_payment_wallet_api.description

  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/checkout/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "checkout_payment_wallet_api_v1" {
  name                = "${local.parent_project}-payment-wallet-api"
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_checkout_payment_wallet_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_checkout_payment_wallet_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.parent_project}-payment-wallet-api"
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_checkout_payment_wallet_product.product_id]
  subscription_required = local.apim_checkout_payment_wallet_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.checkout_payment_wallet_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_checkout_payment_wallet_api.service_url

  description  = local.apim_checkout_payment_wallet_api.description
  display_name = local.apim_checkout_payment_wallet_api.display_name
  path         = local.apim_checkout_payment_wallet_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/checkout/checkout_payment_wallet/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/checkout/checkout_payment_wallet/v1/_base_policy.xml.tpl", {
    payment_wallet_hostname   = local.payment_wallet_hostname
    checkout_ingress_hostname = var.checkout_ingress_hostname
    checkout_origin           = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}

resource "azurerm_api_management_api_operation_policy" "get_wallets_v1" {
  api_name            = "${local.parent_project}-payment-wallet-api-v1"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = "getCheckoutPaymentWalletsByIdUser"

  xml_content = file("./api/checkout/checkout_payment_wallet/v1/_get_wallets.xml.tpl")
}
