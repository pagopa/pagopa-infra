###################################################
## Product AFM Marketplace for Technical Support ##
###################################################
locals {
  apim_afm_marketplace_technical_support_api = {
    display_name          = "AFM Marketplace pagoPA - Technical Support API"
    description           = "Marketplace API for Technical Support"
    path                  = "afm/marketplace-technical-support"
    subscription_required = true
    service_url           = null
  }
}

#fetch technical support api product APIM product
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_api_version_set" "api_afm_marketplace_technical_support_api" {

  name                = format("%s-afm-marketplace-service-technical-support-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_afm_marketplace_technical_support_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_afm_marketplace_technical_support_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-marketplace-service-technical-support-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_afm_marketplace_technical_support_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_afm_marketplace_technical_support_api.id
  api_version           = "v1"

  description  = local.apim_afm_marketplace_technical_support_api.description
  display_name = local.apim_afm_marketplace_technical_support_api.display_name
  path         = local.apim_afm_marketplace_technical_support_api.path
  protocols    = ["https"]
  service_url  = local.apim_afm_marketplace_technical_support_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/marketplace-technical-support/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/marketplace-technical-support/v1/_base_policy.xml", {
    hostname = local.afm_hostname
  })
}
