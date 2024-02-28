##############################
## API BackOffice with ApiKey ##
##############################
locals {
  apim_selfcare_backoffice_external_api = {
    display_name = "Selfcare Backoffice External Product pagoPA"
    description  = "API for Backoffice External"
    path                  = "backoffice/external"
    subscription_required = true
    service_url           = null
  }
}


module "apim_selfcare_backoffice_external_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.7.0"

  product_id   = "selfcare-bo-external"
  display_name = local.apim_selfcare_backoffice_external_api.display_name
  description  = local.apim_selfcare_backoffice_external_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 10000

  policy_xml = file("./api_product/_base_policy.xml")
}

##############
## Api Vers ##
##############

resource "azurerm_api_management_api_version_set" "api_backoffice_external_api_version_set" {

  name                = format("%s-backoffice-external-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_selfcare_backoffice_external_api.display_name
  versioning_scheme   = "Segment"
}


##############
## OpenApi  ##
##############

module "apim_api_bizevents_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.7.0"

  name                  = format("%s-bizevents-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_selfcare_backoffice_external_product.product_id]
  subscription_required = local.apim_selfcare_backoffice_external_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_backoffice_external_api_version_set.id
  api_version           = "v1"

  description  = local.apim_selfcare_backoffice_external_api.description
  display_name = local.apim_selfcare_backoffice_external_api.display_name
  path         = local.apim_selfcare_backoffice_external_api.path
  protocols    = ["https"]
  service_url  = local.apim_selfcare_backoffice_external_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pagopa-backoffice-external/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/pagopa-backoffice-external/_base_policy.xml", {
    hostname = local.selfcare_hostname
  })

  api_operation_policies = [
    {
      operation_id = "getCreditorInstitutions",
      xml_content = templatefile("./api/pagopa-backoffice-external/_get_broker_institutions_policy.xml", {})
    },
  ]
}

