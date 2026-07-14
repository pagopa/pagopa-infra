###################################################
## API NPG SDK integrity (ecommerce-for-checkout) ##
###################################################
# Exposes the payment-methods-handler NPG SDK integrity endpoint inside the
# ecommerce-for-checkout product. Free to invoke (the hash is not sensitive) but under a
# stricter rate limit than the rest of the group: the NPG SDK sync pipeline calls it once
# per hour in batch to fetch the source-of-truth hash. The npg-api-key never leaves the
# eCommerce domain - APIM injects the handler's internal api key on the backend call.
locals {
  apim_ecommerce_checkout_npg_sdk_api = {
    display_name          = "Ecommerce NPG SDK integrity API for checkout pagoPA"
    description           = "NPG SDK subresource integrity hash (source of truth) for the checkout SDK sync pipeline"
    path                  = "checkout/npg/sdk"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "ecommerce_checkout_npg_sdk_api" {
  name                = "${local.project}-checkout-npg-sdk-integrity-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_checkout_npg_sdk_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_checkout_npg_sdk_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-checkout-npg-sdk-integrity-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_ecommerce_checkout_product.product_id]
  subscription_required = local.apim_ecommerce_checkout_npg_sdk_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_checkout_npg_sdk_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_checkout_npg_sdk_api.description
  display_name = local.apim_ecommerce_checkout_npg_sdk_api.display_name
  path         = local.apim_ecommerce_checkout_npg_sdk_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_checkout_npg_sdk_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-checkout-npg-sdk/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-checkout-npg-sdk/v1/_base_policy.xml.tpl", {
    hostname         = local.ecommerce_hostname
    rate_limit_calls = var.env_short == "p" ? 10 : 60
  })
}
