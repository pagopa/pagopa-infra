####################
## Local variables #
####################

locals {
  apim_gpd_payments_soap_api = {
    display_name          = "GPD Payments pagoPA - SOAP - aks"
    description           = "SOAP API del servizio Payments per Gestione Posizione Debitorie"
    # temporary path for migration purpose - the official one will be gpd-payments/api
    path                  = "gps/gpd-payments/api"
    published             = true
    subscription_required = false
    approval_required     = false
    subscriptions_limit   = 1000
    service_url           = format("https://%s/pagopa-gpd-payments/partner", local.gps_hostname)
  }
  apim_gpd_payments_rest_internal_api = {
    display_name = "GPD Payments pagoPA - REST - aks"
    description  = "REST API del servizio Payments per Gestione Posizione Debitorie"
    # temporary path for migration purpose - the official one will be gpd-payments/api
    path                  = "gps/gpd-payment-receipts/api"
    published             = true
    subscription_required = false
    approval_required     = false
    subscriptions_limit   = 1000
    service_url           = null
  }
}


###################
## SOAP Products ##
###################

module "apim_gpd_payments_soap_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id            = "gpd-payments-soap"
  display_name          = "GPD Payments pagoPA - SOAP - aks"
  description           = "API Prodotto Payments gestione posizioni debitorie - SOAP"

  resource_group_name   = local.pagopa_apim_rg
  api_management_name   = local.pagopa_apim_name

  published             = local.apim_gpd_payments_soap_api.published
  subscription_required = local.apim_gpd_payments_soap_api.subscription_required
  approval_required     = local.apim_gpd_payments_soap_api.approval_required
  subscriptions_limit   = local.apim_gpd_payments_soap_api.subscriptions_limit

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

###################
## REST Products ##
###################

module "apim_gpd_payments_rest_internal_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "product-gpd-payments-rest-aks"
  display_name = "GPD Payments pagoPA - REST - aks"
  description  = "Prodotto Payments gestione posizioni debitorie - REST"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = local.apim_gpd_payments_rest_internal_api.published
  subscription_required = local.apim_gpd_payments_rest_internal_api.subscription_required
  approval_required     = local.apim_gpd_payments_rest_internal_api.approval_required
  subscriptions_limit   = local.apim_gpd_payments_rest_internal_api.subscriptions_limit

  policy_xml = file("./api_product/payments-service/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_internal_api" {
  name                = format("%s-api-gpd-payments-rest-api-aks", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_gpd_payments_rest_internal_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_internal_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-gpd-payments-rest-api-aks", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_payments_rest_internal_product.product_id]
  subscription_required = local.apim_gpd_payments_rest_internal_api.subscription_required
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_internal_api.id
  service_url           = local.apim_gpd_payments_rest_internal_api.service_url

  description  = local.apim_gpd_payments_rest_internal_api.description
  display_name = local.apim_gpd_payments_rest_internal_api.display_name
  path         = local.apim_gpd_payments_rest_internal_api.path
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payments-service/v1/rest/internal/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payments-service/v1/rest/internal/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}

