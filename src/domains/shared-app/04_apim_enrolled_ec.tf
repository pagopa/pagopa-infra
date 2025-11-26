locals {
  apim_enrolled_orgs_api = {
    display_name          = "Enrolled EC on services - API"
    description           = "Enrolled EC on services - API"
    path                  = "enrolled"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############
module "apim_enrolled_orgs_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "enrolled-orgs"
  display_name = "Enrolled EC on services - API"
  description  = "Enrolled EC on services - API"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 5 # now only for PN

  policy_xml = file("./api_product/_base_policy_internet.xml")
}

data "azurerm_api_management_product" "apim_pn_integration_product" {
  product_id          = "pn-integration"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
}

resource "azurerm_api_management_api_version_set" "api_enrolled_orgs_api" {

  name                = format("%s-enrolled-orgs-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_enrolled_orgs_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_enrolled_orgs_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-enrolled-orgs-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_enrolled_orgs_product.product_id, data.azurerm_api_management_product.apim_pn_integration_product.product_id]
  subscription_required = local.apim_enrolled_orgs_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_enrolled_orgs_api.id
  api_version           = "v1"

  description  = local.apim_enrolled_orgs_api.description
  display_name = local.apim_enrolled_orgs_api.display_name
  path         = local.apim_enrolled_orgs_api.path
  protocols    = ["https"]
  service_url  = local.apim_enrolled_orgs_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/enrolled-orgs/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/enrolled-orgs/v1/_base_policy.xml", {
    hostname = local.authorizer_config_hostname
  })
}
