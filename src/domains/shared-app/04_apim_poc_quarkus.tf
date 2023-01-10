##############
## Products ##
##############

module "apim_poc_quarkus_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v4.0.0"

  product_id   = "poc-quarkus"
  display_name = "Reporting orgs enrollment - POC quarkus"
  description  = "PAGOPA Reporting orgs enrollment - POC quarkus"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  #TODO: update policy 
  published             = false
  subscription_required = false
  approval_required     = false 
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/_base_policy_poc.xml")
}

#########################################
##  API POC QUARKUS ORGS ENROLLMENT  ##
#########################################
locals {
  apim_poc_quarkus_service_api = {
    display_name          = "Reporting orgs enrollment - POC quarkus pagoPA - API"
    description           = "API to support quarkus POC"
    path                  = "shared/poc-quarkus-reporting-orgs-enrollment"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_poc_quarkus_api" {

  name                = format("%s-poc-quarkus-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_poc_quarkus_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_poc_quarkus_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v4.0.0"

  name                  = format("%s-poc-quarkus-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_poc_quarkus_product.product_id]
  subscription_required = local.apim_poc_quarkus_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_poc_quarkus_api.id
  api_version           = "v1"

  description  = local.apim_poc_quarkus_service_api.description
  display_name = local.apim_poc_quarkus_service_api.display_name
  path         = local.apim_poc_quarkus_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_poc_quarkus_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/iuv-generator-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/iuv-generator-service/v1/_base_policy.xml", {
    hostname = local.shared_hostname,
    service_name = "poc-quarkus"
  })
}
