#################
##    API pagopa ##
#################
locals {
  apim_backoffice_apiConfig_api = {
    display_name          = "PagoPA backoffice ApiConfig for auth "
    description           = "API to manage PSP and EC configurations"
    path                  = "backoffice/apiconfig/auth"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_backoffice_apiConfig_api" {

  name                = "${var.env_short}-pagopa-backoffice-apiConfig-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_backoffice_apiConfig_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_backoffice_apiConfig_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = "${local.product}-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_backoffice_apiConfig_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_backoffice_apiConfig_api.id
  api_version           = "v1"

  description  = local.apim_backoffice_apiConfig_api.description
  display_name = local.apim_backoffice_apiConfig_api.display_name
  path         = local.apim_backoffice_apiConfig_api.path
  protocols    = ["https"]
  service_url  = local.apim_backoffice_apiConfig_api.service_url

  content_format = "openapi"
  content_value  = templatefile("./api/pagopa-api-config/v1/_openapi.json.tpl", {
    host     = local.selfcare_hostname
    basePath = "selfcare"
  })

  xml_content = templatefile("./api/pagopa-api-config/v1/_base_policy.xml", {
    hostname = local.selfcare_hostname
    origin   = local.selfcare_fe_hostname
  })
}
