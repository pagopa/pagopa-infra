##############
## Products ##
##############

module "apim_qi_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "qi"
  display_name = "QI pagoPA"
  description  = "Product for Quality Improvement pagoPA"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################################################
## API QI service                          ##
#################################################
locals {
  apim_qi_api = {
    display_name          = "pagoPA - Quality Improvement API"
    description           = "API for Quality Improvement service"
    path                  = "qi"
    subscription_required = true
    service_url           = null
  }
}
