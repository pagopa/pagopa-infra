##############
## Products ##
##############

module "apim_api_config_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "product-api-config"
  display_name = "ApiConfig JWT"
  description  = "Product for API Configuration with JWT "

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/apiconfig_api/_base_policy.xml")
}


locals {
  hostname = var.env == "prod" ? "weuprod.apiconfig.internal.platform.pagopa.it" : "weu${var.env}.apiconfig.internal.${var.env}.platform.pagopa.it"
}


########################
## Products for Auth  ##
## version for subkey ##
########################

module "apim_api_config_auth_product" {
  source = "./.terraform/modules/__v4__/api_management_product"

  product_id   = "product-api-config-auth"
  display_name = "ApiConfig SubKey"
  description  = "Product for API Configuration SubKey for B2B"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/apiconfig_api/_base_policy_auth.xml")
}
