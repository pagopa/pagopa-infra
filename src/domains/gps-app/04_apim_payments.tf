locals {
  apim_payments_receipts_service_api = {
    display_name          = "GPD pagoPA - Payments Receipts service API for organizations"
    description           = "API to support payments receipts service for organizations"
    # temporary path for migration purpose - the official one will be gpd/payments-receipts-service
    path                  = "gps/gpd-payments-receipts-service"
    subscription_required = true
    service_url           = null
  }
  apim_payments_receipts_api = {
    display_name          = "GPD Payments pagoPA - REST"
    description           = "REST API Payments per Gestione Posizione Debitorie"
    # temporary path for migration purpose - the official one will be payment-receipts/api
    path                  = "gps/payment-receipts/api"
    subscription_required = true
    service_url           = null
  }
}

########################
# GPD-GPS INTERNAL USE #
########################

###################
## SOAP Products ##
###################

##############
## SOAP API ##
##############

###################
## REST Products ##
###################

module "apim_gpd_payments_rest_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "product-gpd-payments-rest"
  display_name = "GPD Payments pagoPA - REST"
  description  = "Prodotto Payments gestione posizioni debitorie - REST"

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

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_api" {
  name                = format("%s-api-gpd-payments-rest-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_payments_receipts_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-gpd-payments-rest-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_payments_rest_product.product_id]
  subscription_required = local.apim_payments_receipts_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_api.id
  api_version           = "v1"

  description  = local.apim_payments_receipts_api.description
  display_name = local.apim_payments_receipts_api.display_name
  path         = local.apim_payments_receipts_api.path
  protocols    = ["https"]
  service_url  = local.apim_payments_receipts_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payments-service/v1/rest/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payments-service/v1/rest/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}

########################
# GPD-GPS EXTERNAL USE #
########################

##############
## Products ##
##############

module "apim_payments_receipts_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v2.18.3"

  product_id   = "payments-receipts"
  display_name = "GPD Payments Receipts for organizations"
  description  = "GPD Payments Receipts for organizations"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/payments-service/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "api_payments_receipts_api" {

  name                = format("%s-payments-receipts-service-api", var.env_short)
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_payments_receipts_service_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_payments_receipts_api_v1" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.18.3"

  name                  = format("%s-payments-receipts-service-api", local.project)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_payments_receipts_product.product_id]
  subscription_required = local.apim_payments_receipts_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_payments_receipts_api.id
  api_version           = "v1"

  description  = local.apim_payments_receipts_service_api.description
  display_name = local.apim_payments_receipts_service_api.display_name
  path         = local.apim_payments_receipts_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_payments_receipts_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payments-receipts/v1/_openapi.json.tpl", {
    host = local.apim_hostname
  })

  xml_content = templatefile("./api/payments-receipts/v1/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
