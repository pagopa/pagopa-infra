##############
## Products ##
##############

module "apim_buyerbanks_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "buyerbanks"
  display_name = "buyerbanks pagoPA"
  description  = "Product for buyerbanks pagoPA"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/buyerbanks_api/_base_policy.xml")
}

#####################################
## API buyerbanks                  ##
#####################################
locals {
  apim_buyerbanks_api = {
    # params for all api versions
    display_name          = "pagoPA buyerbanks API"
    description           = "API to support buyerbanks list update"
    path                  = "api/buyerbanks"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "buyerbanks_api" {

  name                = format("%s-buyerbanks-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_buyerbanks_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_buyerbanks_api_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-buyerbanks-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_buyerbanks_product.product_id]
  subscription_required = local.apim_buyerbanks_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.buyerbanks_api.id
  api_version           = "v1"
  service_url           = local.apim_buyerbanks_api.service_url

  description  = local.apim_buyerbanks_api.description
  display_name = local.apim_buyerbanks_api.display_name
  path         = local.apim_buyerbanks_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/buyerbanks_api/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = file("./api/buyerbanks_api/_base_policy.xml.tpl")
}
