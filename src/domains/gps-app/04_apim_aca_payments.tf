####################
## Local variables #
####################

locals {
  apim_aca_payments_soap_api = {
    display_name          = "ACA Payments pagoPA - SOAP"
    description           = "SOAP API del servizio Payments per Archivio Centralizzato Avvisi"
    path                  = "aca-payments/api"
    published             = true
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 1000
    service_url           = format("https://%s/pagopa-gpd-payments/partner", local.gps_hostname)
  }
}

##############
## SOAP API ##
##############

resource "azurerm_api_management_api_version_set" "api_aca_payments_soap_api" {
  name                = format("%s-api-aca-payments-soap-api", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_aca_payments_soap_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_api_aca_payments_soap_api_v1" {

  name                  = format("%s-api-aca-payments-soap-api", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_aca_payments_soap_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_aca_payments_soap_api.id
  version               = "v1"
  revision              = "1"

  description  = local.apim_aca_payments_soap_api.description
  display_name = local.apim_aca_payments_soap_api.display_name
  path         = local.apim_aca_payments_soap_api.path
  protocols    = ["https"]
  service_url  = local.apim_aca_payments_soap_api.service_url

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

# Associate the SOAP API with the product APIM for Node
resource "azurerm_api_management_product_api" "apim_api_aca_payments_soap_product_nodo_api_v1" {

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id = local.apim_x_node_product_id
  api_name   = azurerm_api_management_api.apim_api_aca_payments_soap_api_v1.name
}


resource "azurerm_api_management_api_policy" "apim_api_aca_payments_soap_policy" {
  api_name            = azurerm_api_management_api.apim_api_aca_payments_soap_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/aca-payments/v1/_base_policy.xml.tpl", {
    hostname = local.gps_hostname
  })
}