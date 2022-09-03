##############
## Products ##
##############

module "apim_debt_positions_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "debt-positions"
  display_name = "GPD Debt Positions for organizations"
  description  = "GPD Debt Positions for organizations"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#################
##    API GPS  ##
#################
locals {
  apim_debt_positions_service_api = {
    display_name          = "GPD pagoPA - Debt Positions service API for organizations"
    description           = "API to support Debt Positions service for organizations"
    path                  = "gpd/debt-positions-service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_debt_positions_api" {

  name                = format("%s-debt-positions-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_debt_positions_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_debt_positions_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-debt-positions-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_debt_positions_product.product_id]
  subscription_required = local.apim_debt_positions_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_debt_positions_api.id
  api_version           = "v1"

  description  = local.apim_debt_positions_service_api.description
  display_name = local.apim_debt_positions_service_api.display_name
  path         = local.apim_debt_positions_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_debt_positions_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/debt-position-services/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/debt-position-services/v1/_base_policy.xml", {
    env_short = var.env_short
  })
}
