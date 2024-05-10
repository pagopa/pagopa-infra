###################################################
## Product Api-Config iban for Technical Support ##
###################################################
locals {
  apim_apiconfig_iban_technical_support_api = {
    display_name          = "Api-Config iban pagoPA - Technical Support API"
    description           = "Api-Config iban API for Technical Support"
    path                  = "api-config/iban-technical-support"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_config_iban_technical_support_api" {

  name                = format("%s-api-config-iban-service-technical-support-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_config_iban_technical_support_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.5.0"

  name                  = format("%s-api-config-iban-service-technical-support-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_apiconfig_iban_technical_support_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_config_iban_technical_support_api.id
  api_version           = "v1"

  description  = local.apim_apiconfig_iban_technical_support_api.description
  display_name = local.apim_apiconfig_iban_technical_support_api.display_name
  path         = local.apim_apiconfig_iban_technical_support_api.path
  protocols    = ["https"]
  service_url  = local.apim_apiconfig_iban_technical_support_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/apiconfig_api/technical-support/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_api_config_auth_product.product_id
  })

  xml_content = templatefile("./api/apiconfig_api/technical-support/_base_policy.xml.tpl", {
    hostname    = local.apiconfig_core_locals.hostname
    origin      = "*"
    addMockResp = var.env_short != "d" ? "true" : "false"
  })
}