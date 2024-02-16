##############
## Products ##
##############
module "apim_standin_manager_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "stand-in-manager"
  display_name = "API Stand-In Manager"
  description  = "Internal API for StandIn"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/standin-manager/_base_policy.xml")
}

############################
## API defined in repository
############################
