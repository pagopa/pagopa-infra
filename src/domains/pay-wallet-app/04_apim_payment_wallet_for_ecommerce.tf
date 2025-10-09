#################################################
## API payment wallet for eCommerce            ##
#################################################
locals {
  apim_payment_wallet_for_ecommerce_api = {
    display_name          = "pagoPA - payment wallet API for eCommerce"
    description           = "API dedicated to eCommerce to retrive wallet data useful to handle authorization request with eCommerce."
    path                  = "payment-wallet-for-ecommerce"
    subscription_required = true
    service_url           = null
  }
}

# Payment wallet for eCommerce APIs
resource "azurerm_api_management_api_version_set" "payment_wallet_for_ecommerce_api" {
  name                = "${local.project}-payment-wallet-for-ecommerce-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_for_ecommerce_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_wallet_for_ecommerce_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-payment-wallet-for-ecommerce-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_for_ecommerce_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_wallet_for_ecommerce_api.id
  api_version           = "v1"

  description  = local.apim_payment_wallet_for_ecommerce_api.description
  display_name = local.apim_payment_wallet_for_ecommerce_api.display_name
  path         = local.apim_payment_wallet_for_ecommerce_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_for_ecommerce_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-for-ecommerce/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet-for-ecommerce/v1/_base_policy.xml.tpl", {
    hostname = local.payment_wallet_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "post_wallet_notification" {
  api_name            = module.apim_payment_wallet_for_ecommerce_api_v1.name
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  operation_id        = "notifyWallet"
  xml_content         = file("./api/payment-wallet-for-ecommerce/v1/_post_notification.xm.tpl")
}