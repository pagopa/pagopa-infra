####################
## Local variables #
####################

locals {
  apim_gpd_payments_rest_external_api = {
    display_name          = "GPD Payments pagoPA - REST for Auth"
    description           = "REST API del servizio Payments per Gestione Posizione Debitorie - for Auth"
    # temporary path for migration purpose - the official one will be payment-receipts/api
    path                  = "gps/gpd-payment-receipts-auth/api"
    subscription_required = true
    service_url           = null
  }
}


###################
## REST Products ##
###################

module "apim_gpd_payments_rest_external_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "gpd-payments-rest"
  display_name = "GPD Payments pagoPA - REST for Auth"
  description  = "API Prodotto Payments gestione posizioni debitorie - REST for Auth"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payments-service/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_external_api" {
  name                = format("%s-gpd-payments-rest-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_payments_rest_external_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_external_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-gpd-payments-rest-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_payments_rest_external_product.product_id]
  subscription_required = local.apim_gpd_payments_rest_external_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_external_api.id
  api_version           = "v1"

  description  = local.apim_gpd_payments_rest_external_api.description
  display_name = local.apim_gpd_payments_rest_external_api.display_name
  path         = local.apim_gpd_payments_rest_external_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_payments_rest_external_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payments-service/v1/rest/external/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payments-service/v1/rest/external/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
