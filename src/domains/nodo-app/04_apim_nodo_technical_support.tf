##############
## Product ##
##############
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

###############
##    API    ##
###############
locals {
  apim_technical_support_api = {
    display_name          = "Nodo Technical Support"
    description           = "API Assistenza del Nodo dei Pagamenti"
    path                  = "technical-support/nodo"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_nodo_technical_support_api" {
  name                = format("%s-technical-support-api", local.project)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_technical_support_api.display_name
  versioning_scheme   = "Segment"
}


module "api_nodo_technical_support_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"

  name                  = format("%s-technical-support-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_mock_ec_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_nodo_technical_support_api.id
  api_version           = "v1"

  description  = local.apim_technical_support_api.description
  display_name = local.apim_technical_support_api.display_name
  path         = local.apim_technical_support_api.path
  protocols    = ["https"]
  service_url  = local.apim_technical_support_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/technical-support-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
    service = data.azurerm_api_management_product.technical_support_api_product.product_id
  })

  xml_content = templatefile("./api/technical-support-service/v1/_base_policy.xml", {
    hostname = local.nodo_hostname
  })
}
