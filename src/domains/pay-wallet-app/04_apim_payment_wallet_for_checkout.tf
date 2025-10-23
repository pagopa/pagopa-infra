#################################################
## API payment wallet for checkout             ##
#################################################
locals {
  apim_payment_wallet_for_checkout_api = {
    display_name          = "pagoPA - payment wallet API for checkout"
    description           = "API dedicated to checkout to retrive wallet data useful to show to the autenticated user."
    path                  = "payment-wallet-for-checkout"
    subscription_required = true
    service_url           = null
  }
}

# Payment wallet for checkout APIs
resource "azurerm_api_management_api_version_set" "payment_wallet_for_checkout_api" {
  name                = "${local.project}-payment-wallet-for-checkout-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payment_wallet_for_checkout_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_payment_wallet_for_checkout_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-payment-wallet-for-checkout-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payment_wallet_product.product_id]
  subscription_required = local.apim_payment_wallet_for_checkout_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.payment_wallet_for_checkout_api.id
  api_version           = "v1"

  description  = local.apim_payment_wallet_for_checkout_api.description
  display_name = local.apim_payment_wallet_for_checkout_api.display_name
  path         = local.apim_payment_wallet_for_checkout_api.path
  protocols    = ["https"]
  service_url  = local.apim_payment_wallet_for_checkout_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payment-wallet-for-checkout/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/payment-wallet-for-checkout/v1/_base_policy.xml.tpl", {
    hostname                  = local.payment_wallet_hostname
    checkout_ingress_hostname = local.checkout_ingress_hostname
    pdv_api_base_path         = var.pdv_api_base_path
    checkout_origin           = var.env_short == "d" ? "*" : "https://${var.dns_zone_checkout}.${var.external_domain}"
  })
}
