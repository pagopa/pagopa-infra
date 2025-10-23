##############################
## API redirect outcome     ##
##############################
locals {
  apim_ecommerce_redirect_outcome_api = {
    display_name          = "ecommerce pagoPA - Redirect outcome API"
    description           = "API to handle redirect transaction's outcome requests"
    path                  = "ecommerce/redirect"
    subscription_required = true
    service_url           = null
  }
}

#Product that contains api that pagoPA exposes to PSP's for redirect payment flow integration
module "apim_ecommerce_redirect_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "ecommerce-redirect"
  display_name = "eCommerce for redirect pagoPA"
  description  = "eCommerce pagoPA product dedicated to redirect payment flow integration"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#Version set for redirect api's v1
resource "azurerm_api_management_api_version_set" "apim_ecommerce_redirect_outcome_api_v1" {
  name                = "${local.project}-redirect_outcomes"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_redirect_outcome_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_redirect_outcome_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-ecommerce-redirect-outcome-api"
  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name
  product_ids           = [module.apim_ecommerce_redirect_product.product_id]
  subscription_required = local.apim_ecommerce_redirect_outcome_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.apim_ecommerce_redirect_outcome_api_v1.id
  api_version           = "v1"
  service_url           = local.apim_ecommerce_redirect_outcome_api.service_url

  description  = local.apim_ecommerce_redirect_outcome_api.description
  display_name = local.apim_ecommerce_redirect_outcome_api.display_name
  path         = local.apim_ecommerce_redirect_outcome_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/redirect-outcome/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = file("./api/redirect-outcome/v1/_base_policy.xml.tpl")
  api_operation_policies = [
    {
      operation_id = "CallbackOutcome",
      xml_content = templatefile("./api/redirect-outcome/v1/_redirect_outcome_policy.xml.tpl", {
        hostname = local.ecommerce_hostname
      })
    }
  ]
}
