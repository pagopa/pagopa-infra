###########################################
## Product GPD REPORTING ORGS ENROLLMENT ##
###########################################

locals {
  apim_reporting-orgs-enrollment_service_api = {
    display_name          = "GPD pagoPA - Reporting Orgs Enrollment"
    description           = "API to support Reporting orgs enrollment"
    path                  = "gps/gpd-reporting-orgs-enrollment/api"
    subscription_required = true
    service_url           = null
  }
}

##############
## Products ##
##############

module "apim_gpd_enrollment_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v4.0.0"

  product_id   = "gpd-reporting-orgs-enrollment"
  display_name = local.apim_reporting-orgs-enrollment_service_api.display_name
  description  = local.apim_reporting-orgs-enrollment_service_api.description

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = local.apim_reporting-orgs-enrollment_service_api.subscription_required
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/gpd-reporting-orgs-enrollment-service/_base_policy.xml")
}

#########
## API ##
#########

resource "azurerm_api_management_api_version_set" "api_gpd_enrollment_api" {

  name                = format("%s-reporting-orgs-enrollment-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_reporting-orgs-enrollment_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_gpd_enrollment_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v4.0.0"

  name                  = format("%s-reporting-orgs-enrollment-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_enrollment_product.product_id]
  subscription_required = local.apim_reporting-orgs-enrollment_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_enrollment_api.id
  api_version           = "v1"

  description  = local.apim_reporting-orgs-enrollment_service_api.description
  display_name = local.apim_reporting-orgs-enrollment_service_api.display_name
  path         = local.apim_reporting-orgs-enrollment_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_reporting-orgs-enrollment_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gpd-reporting-orgs-enrollment-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/gpd-reporting-orgs-enrollment-service/v1/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
