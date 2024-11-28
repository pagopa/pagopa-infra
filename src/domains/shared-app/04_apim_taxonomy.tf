##############
## Products ##
##############

module "apim_taxonomy_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "taxonomy"
  display_name = "Taxonomy"
  description  = "Taxonomy"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = false
  approval_required     = false
  subscriptions_limit   = 0

  policy_xml = file("./api_product/taxonomy/_base_policy.xml")
}

######################
##    API taxonomy  ##
######################
locals {
  apim_taxonomy_service_api = {
    display_name          = "Taxonomy"
    description           = "Taxonomy"
    path                  = "taxonomy/service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_taxonomy_api" {
  name                = "${var.env_short}-taxonomy-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_taxonomy_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_taxonomy_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = "${local.project}-taxonomy-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_taxonomy_product.product_id]
  subscription_required = local.apim_taxonomy_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_taxonomy_api.id
  api_version           = "v1"

  description  = local.apim_taxonomy_service_api.description
  display_name = local.apim_taxonomy_service_api.display_name
  path         = local.apim_taxonomy_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_taxonomy_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/taxonomy/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_taxonomy_product.product_id
  })

  xml_content = templatefile("./api/taxonomy/v1/_base_policy.xml.tpl", {
    hostname = "${module.taxonomy_function.name}.azurewebsites.net"
  })
}
