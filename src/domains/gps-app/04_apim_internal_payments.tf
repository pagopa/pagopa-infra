####################
## Local variables #
####################

locals {
  apim_gpd_payments_soap_api = {
    display_name          = "GPD Payments pagoPA - SOAP"
    description           = "SOAP API del servizio Payments per Gestione Posizione Debitorie"
    path                  = "gpd-payments/api"
    published             = true
    subscription_required = false
    approval_required     = false
    subscriptions_limit   = 0
    service_url           = format("https://%s/pagopa-gpd-payments/partner", local.gps_hostname)
  }
}


###################
## SOAP Products ##
###################

module "apim_gpd_payments_soap_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.4.1"

  product_id   = "gpd-payments-soap"
  display_name = "GPD Payments pagoPA - SOAP"
  description  = "API Prodotto Payments gestione posizioni debitorie - SOAP"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

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

# Associate the SOAP API with the product
resource "azurerm_api_management_product_api" "apim_api_gpd_payments_soap_product_api_v1" {

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id = module.apim_gpd_payments_soap_product.product_id
  api_name   = azurerm_api_management_api.apim_api_gpd_payments_soap_api_v1.name
}
