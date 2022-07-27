##############
## Products ##
##############

module "apim_gps_donation_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "gpsdonation"
  display_name = "GPS Donation Service"
  description  = "Servizio per gestire le donazioni"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = false
  subscription_required = false
  approval_required     = false
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/donation-service/_base_policy.xml")
}

#################
##    API GPS  ##
#################
locals {
  apim_gps_donation_service_api = {
    display_name          = "GPS Donation Service"
    description           = "API to handle donation for GPS"
    path                  = "gps/donation-service"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_gps_donation_api" {

  name                = format("%s-gps-donation-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_gps_donation_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_gps_donation_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-gps-donation-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gps_donation_product.product_id]
  subscription_required = local.apim_gps_donation_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gps_donation_api.id
  api_version           = "v1"

  description  = local.apim_gps_donation_service_api.description
  display_name = local.apim_gps_donation_service_api.display_name
  path         = local.apim_gps_donation_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_gps_donation_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/gps-donation-service/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/gps-donation-service/v1/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
