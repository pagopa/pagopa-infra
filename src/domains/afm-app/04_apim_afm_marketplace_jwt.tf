# named-values

#############################
## Product AFM Marketplace ##
#############################

resource "azurerm_api_management_api_version_set" "api_afm_marketplace_jwt_api" {

  name                = format("%s-afm-marketplace-service-jwt-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = "AFM Marketplace pagoPA JWT"
  versioning_scheme   = "Segment"
}


module "apim_api_afm_marketplace_jwt_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-afm-marketplace-service-jwt-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_afm_marketplace_product.product_id]
  subscription_required = false
  version_set_id        = azurerm_api_management_api_version_set.api_afm_marketplace_jwt_api.id
  api_version           = "v1"

  description  = "Marketplace JWT Auth"
  display_name = "AFM Marketplace pagoPA JWT"
  path         = "afm/marketplace-auth"
  protocols    = ["https"]
  service_url  = local.apim_afm_marketplace_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/marketplace-service/jwt_v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/marketplace-service/jwt_v1/_base_policy.xml", {
    hostname               = local.afm_hostname
    pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id
    apiconfig_fe_client_id = data.azuread_application.apiconfig-fe.application_id
  })
}



