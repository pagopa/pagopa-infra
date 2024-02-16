##############
## Products ##
##############
module "apim_standin_manager_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.20.0"

  product_id   = "stand-in-manager"
  display_name = "API StandIn"
  description  = "Internal API for StandIn"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/standin-manager/_base_policy.xml")
}

##############
##  Group   ##
##############
resource "azurerm_api_management_group" "standin_manager_group" {
  name                = "standin-manager-group"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "API StandIn"
  description         = "This is the API management group of StandIn Manager"
}

resource "azurerm_api_management_product_group" "standin_manager_group_association" {
  product_id          = module.apim_standin_manager_product.product_id
  group_name          = azurerm_api_management_group.standin_manager_group.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
