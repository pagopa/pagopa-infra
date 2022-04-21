###################
## SOAP Products ##
###################

module "apim_gpd_payments_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-gpd-payments"
  display_name = "GPD Payments pagoPA - SOAP"
  description  = "Prodotto Payments gestione posizioni debitorie - SOAP"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/gpd/payments/soap/_base_policy.xml")
}

##############
## SOAP API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_api" {
  name                = format("%s-api-gpd-payments-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Payments"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_gpd_payments_api" {
  name                  = format("%s-api-gpd-payments-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  subscription_required = false
  service_url           = format("https://%s/partner", module.payments_app_service.default_site_hostname)
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_api.id
  version               = "v1"
  revision              = "1"

  description  = "SOAP API Payments per Gestione Posizione Debitorie"
  display_name = "GPD Payments pagoPA"
  path         = "gpd-payments/api"
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/gpd_api/payments/v1/soap/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}

###################
## REST Products ##
###################

module "apim_gpd_payments_rest_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.84"

  product_id   = "product-gpd-payments-rest"
  display_name = "GPD Payments pagoPA - REST"
  description  = "Prodotto Payments gestione posizioni debitorie - REST"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/gpd/payments/rest/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_api" {
  name                = format("%s-api-gpd-payments-rest-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Payment Receipts"
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-api-gpd-payments-rest-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_gpd_payments_rest_product.product_id]
  subscription_required = false
  api_version           = "v1"
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_api.id
  service_url           = format("https://%s", module.payments_app_service.default_site_hostname)

  description  = "REST API Payments per Gestione Posizione Debitorie"
  display_name = "GPD Payments pagoPA - REST"
  path         = "payment-receipts/api"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/gpd_api/payments/v1/rest/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/gpd_api/payments/v1/rest/_base_policy.xml", {
    origin = format("https://%s.%s.%s", var.cname_record_name, var.dns_zone_prefix, var.external_domain)
  })
}
