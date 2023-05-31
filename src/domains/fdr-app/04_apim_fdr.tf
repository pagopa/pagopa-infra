##############
## Products ##
##############

module "apim_fdr_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr"
  display_name = "FDR - Flussi di rendicontazione"
  description  = "Manage FDR ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service/_base_policy.xml")
}

#################
##    API fdr  ##
#################
locals {
  apim_fdr_service_api = {
    display_name          = "FDR - Flussi di rendicontazione"
    description           = "API to handle fdr"
    path                  = "fdr/service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_api" {

  name                = format("%s-fdr-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = format("%s-fdr-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product.product_id]
  subscription_required = local.apim_fdr_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api.id
  api_version           = "v1"

  description  = local.apim_fdr_service_api.description
  display_name = local.apim_fdr_service_api.display_name
  path         = local.apim_fdr_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-service/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product.product_id
  })

  xml_content = templatefile("./api/fdr-service/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}
