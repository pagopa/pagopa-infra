####################
## Local variables #
####################

locals {
  apim_pn_integration_rest_api = {
    display_name          = "Integrazione PN"
    description           = "REST API del servizio Payments per Gestione Posizione Debitorie - for Auth"
    published             = true
    subscription_required = true
    approval_required     = true
    subscriptions_limit   = 1000
    service_url           = null
    gpd_service = {
      display_name = "Integrazione PN GPD"
      description  = "REST API GPD per piattaforma notifiche"
      path         = "pn-integration/gpd/api"
    }
  }
}

###################
## REST Product ##
###################

module "apim_pn_integration_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "pn-integration"
  display_name = "PN Integration"
  description  = "Integrazione piattaforma notifiche"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = local.apim_pn_integration_rest_api.published
  subscription_required = local.apim_pn_integration_rest_api.subscription_required
  approval_required     = local.apim_pn_integration_rest_api.approval_required
  subscriptions_limit   = local.apim_pn_integration_rest_api.subscriptions_limit

  policy_xml = file("./api_product/pn-integration/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_pn_integration_api" {
  name                = format("%s-pn-integration-rest-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_pn_integration_rest_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_pn_integration_gpd_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.4.1"


  name                  = format("%s-pn-integration-gpd-api-aks", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_pn_integration_product.product_id]
  subscription_required = local.apim_pn_integration_rest_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_pn_integration_api.id
  api_version           = "v1"

  description  = local.apim_pn_integration_rest_api.gpd_service.description
  display_name = local.apim_pn_integration_rest_api.gpd_service.display_name
  path         = local.apim_pn_integration_rest_api.gpd_service.path
  protocols    = ["https"]
  service_url  = local.apim_pn_integration_rest_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/pn-integration/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_pn_integration_product.product_id
  })

  xml_content = templatefile("./api/pn-integration/_base_policy.xml", {
    hostname = "pagopa-${var.env_short}-app-gpd.azurewebsites.net"
  })
}
