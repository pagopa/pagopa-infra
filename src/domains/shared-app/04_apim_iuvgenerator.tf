##############
## Products ##
##############

module "apim_iuvgenerator_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.6.0"

  product_id   = "iuvgenerator"
  display_name = "IUV Generator pagoPA"
  description  = "Prodotto Generatore IUV"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy.xml")
}

#########################
##  API IUV GENERATOR  ##
#########################
locals {
  apim_iuvgenerator_service_api = {
    display_name          = "IUV Generator pagoPA - API"
    description           = "API to support IUV generator service"
    path                  = "shared/iuv-generator-service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_iuvgenerator_api" {

  name                = format("%s-iuv-generator-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_iuvgenerator_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_iuvgenerator_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.6.0"

  name                  = format("%s-iuv-generator-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_iuvgenerator_product.product_id]
  subscription_required = local.apim_iuvgenerator_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_iuvgenerator_api.id
  api_version           = "v1"

  description  = local.apim_iuvgenerator_service_api.description
  display_name = local.apim_iuvgenerator_service_api.display_name
  path         = local.apim_iuvgenerator_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_iuvgenerator_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/iuv-generator-service/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_iuvgenerator_product.product_id
  })

  xml_content = templatefile("./api/iuv-generator-service/v1/_base_policy.xml", {
    hostname = local.iuvgenerator_hostname
  })
}
