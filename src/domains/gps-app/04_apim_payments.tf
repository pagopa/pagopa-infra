####################
## Local variables #
####################

locals {
  apim_gpd_payments_rest_api = {
    display_name          = "GPD Payments pagoPA - REST"
    description           = "REST API del servizio Payments per Gestione Posizione Debitorie"
    # temporary path for migration purpose - the official one will be payment-receipts/api
    path                  = "gps/payment-receipts/api"
    subscription_required = true
    service_url           = null
  }
  apim_gpd_payments_soap_api = {
    display_name          = "GPD Payments pagoPA - SOAP"
    description           = "SOAP API del servizio Payments per Gestione Posizione Debitorie"
    # temporary path for migration purpose - the official one will be gpd-payments/api
    path                  = "gps/gpd-payments/api"
    subscription_required = true
    service_url           = null
  }
}


###################
## SOAP Products ##
###################

module "apim_gpd_payments_soap_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "gpd-payments-soap"
  display_name = "GPD Payments pagoPA - SOAP"
  description  = "API Prodotto Payments gestione posizioni debitorie - SOAP"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = true
  subscription_required = true
  approval_required     = true
  # subscriptions_limit   = 1000

  policy_xml = file("./api_product/payments-service/_base_policy.xml")
}


###################
## REST Products ##
###################

module "apim_gpd_payments_rest_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "gpd-payments-rest"
  display_name = "GPD Payments pagoPA - REST"
  description  = "API Prodotto Payments gestione posizioni debitorie - REST"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payments-service/_base_policy.xml")
}


##############
## SOAP API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_soap_api" {
  name                = format("%s-api-gpd-payments-soap-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_payments_soap_api.display_name
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_gpd_payments_soap_api_v1" {

  name                  = format("%s-api-gpd-payments-soap-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_gpd_payments_soap_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_soap_api.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_gpd_payments_soap_api.description
  display_name = local.apim_gpd_payments_soap_api.display_name
  path         = local.apim_gpd_payments_soap_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_payments_soap_api.service_url

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/payments-service/v1/soap/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}


##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_api" {
  name                = format("%s-gpd-payments-rest-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_payments_rest_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-gpd-payments-rest-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_payments_rest_product.product_id]
  subscription_required = local.apim_gpd_payments_rest_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_api.id
  api_version           = "v1"

  description  = local.apim_gpd_payments_rest_api.description
  display_name = local.apim_gpd_payments_rest_api.display_name
  path         = local.apim_gpd_payments_rest_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_payments_rest_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payments-service/v1/rest/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payments-service/v1/rest/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
