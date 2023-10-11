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

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_technical_support_policy.xml")
}

##############
##  Group   ##
##############
resource "azurerm_api_management_group" "technical_support_group" {
  name                = "technical-support-group"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "API Assistenza"
  description         = "This is the API management group of Technical Support"
}

resource "azurerm_api_management_product_group" "technical_support_group_association" {
  product_id          = module.apim_technical_support_product.product_id
  group_name          = azurerm_api_management_group.technical_support_group.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}
