##############
## Products ##
##############
module "apim_technical_support_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "technical_support_api"
  display_name = "API Assistenza"
  description  = "Internal API for Technical Support"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_technical_support_policy.xml")
}
