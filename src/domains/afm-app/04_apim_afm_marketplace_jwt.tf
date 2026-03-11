#################################
## Product AFM Marketplace JWT ##
#################################
locals {
  apim_afm_marketplace_service_api_jwt = {
    display_name          = "AFM Marketplace JWT pagoPA - marketplace of advanced fees management service API with JWT authentication"
    description           = "Marketplace API to support advanced fees management service with JWT authentication"
    path                  = "afm/marketplace-service"
    service_url           = null
  }
}

module "apim_afm_marketplace_jwt_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "afm-marketplace-jwt"
  display_name = local.apim_afm_marketplace_service_api_jwt.display_name
  description  = local.apim_afm_marketplace_service_api_jwt.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/marketplace/_base_policy_jwt.xml",{
    pagopa_tenant_id       = data.azurerm_client_config.current.tenant_id,
    apiconfig_fe_client_id = data.azuread_application.apiconfig-fe.application_id
  })
}
