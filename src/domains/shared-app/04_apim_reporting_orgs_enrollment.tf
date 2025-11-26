###########################################
## Product POC REPORTING ORGS ENROLLMENT ##
###########################################

locals {
  apim_poc_service_api = {
    display_name          = "Reporting orgs enrollment - POC pagoPA"
    description           = "API to support POC"
    path                  = "shared/poc/reporting-orgs-enrollment"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############

module "apim_poc_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "poc"
  display_name = local.apim_poc_service_api.display_name
  description  = local.apim_poc_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_poc_service_api.subscription_required
  approval_required     = false

  policy_xml = file("./api_product/_base_policy.xml")
}

#########
## API ##
#########

resource "azurerm_api_management_api_version_set" "api_poc_api" {

  name                = format("%s-poc-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_poc_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_poc_api_v1" {
  count  = var.env_short == "d" ? 1 : 0
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-poc-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_poc_product[0].product_id]
  subscription_required = local.apim_poc_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_poc_api.id
  api_version           = "v1"

  description  = local.apim_poc_service_api.description
  display_name = local.apim_poc_service_api.display_name
  path         = local.apim_poc_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_poc_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/poc-reporting-orgs-enrollment/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/poc-reporting-orgs-enrollment/_base_policy.xml", {
    hostname = local.shared_hostname
  })
}
