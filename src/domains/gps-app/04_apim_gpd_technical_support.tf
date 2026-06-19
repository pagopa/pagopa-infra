#########################
# GPD TECHNICAL SUPPORT #
#########################

locals {
  apim_gpd_technical_support_api = {
    display_name          = "GPD Technical Support"
    description           = "Technical support APIs for GPD"
    path                  = "gpd-technical-support"
    subscription_required = true
    service_url           = format("https://%s/gpd-technical-support", local.gps_hostname)
  }
}

resource "azurerm_api_management_api_version_set" "api_gpd_technical_support_api" {
  name                = format("%s-api-gpd-technical-support-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_technical_support_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_technical_support_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-api-gpd-technical-support-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_gpd_technical_support_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_technical_support_api.id
  api_version           = "v1"

  description  = local.apim_gpd_technical_support_api.description
  display_name = local.apim_gpd_technical_support_api.display_name
  path         = local.apim_gpd_technical_support_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_technical_support_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd-technical-support/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/gpd-technical-support/v1/_base_policy.xml.tpl", {
    hostname = local.gps_hostname
  })
}