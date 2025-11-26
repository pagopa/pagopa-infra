#################################################
## API ecommerce healthcheck service            ##
#################################################
locals {
  apim_ecommerce_healthcheck_service_api = {
    display_name          = "eCommerce pagoPA - healthcheck API"
    description           = "API to support ecommerce healthcheck"
    path                  = "ecommerce-healthcheck"
    subscription_required = true
    service_url           = null
  }
}

# Healthcheck service APIs
resource "azurerm_api_management_api_version_set" "ecommerce_healthcheck_api" {
  name                = "${local.project}-healtcheck-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_ecommerce_healthcheck_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_ecommerce_healthcheck_api_v1" {
  source = "./.terraform/modules/__v4__/api_management_api"

  name                  = "${local.project}-healtcheck-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = ["pagoPAPlatformStatusPage"]
  subscription_required = local.apim_ecommerce_healthcheck_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.ecommerce_healthcheck_api.id
  api_version           = "v1"

  description  = local.apim_ecommerce_healthcheck_service_api.description
  display_name = local.apim_ecommerce_healthcheck_service_api.display_name
  path         = local.apim_ecommerce_healthcheck_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_ecommerce_healthcheck_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/ecommerce-healthcheck/v1/_openapi.json.tpl", {
    hostname = local.apim_hostname
  })

  xml_content = templatefile("./api/ecommerce-healthcheck/v1/_base_policy.xml.tpl", {
    hostname = local.ecommerce_hostname
  })
}
