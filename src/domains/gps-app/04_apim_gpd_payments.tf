####################
## Local variables #
####################

locals {
  apim_gpd_payments_soap_api = {
    display_name          = "GPD Payments pagoPA - SOAP"
    description           = "SOAP API del servizio Payments per Gestione Posizione Debitorie"
    path                  = "gpd-payments/api"
    published             = true
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 1000
    service_url           = format("https://%s/pagopa-gpd-payments/partner", local.gps_hostname)
  }
  apim_gpd_payments_rest_external_api = {
    display_name          = "GPD Payments pagoPA - REST for Auth"
    description           = "REST API del servizio Payments per Gestione Posizione Debitorie - for Auth"
    path                  = "gpd/payments-receipts-service"
    published             = true
    subscription_required = true
    approval_required     = false
    subscriptions_limit   = 1000
    service_url           = null
  }
}

###################
## SOAP Products ##
###################

module "apim_gpd_payments_soap_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

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

# Associate the SOAP API with the product APIM for Node
resource "azurerm_api_management_product_api" "apim_api_gpd_payments_soap_product_nodo_api_v1" {

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  product_id = local.apim_x_node_product_id
  api_name   = azurerm_api_management_api.apim_api_gpd_payments_soap_api_v1.name
}

# Add policy API to paSendRTV2 for WISP dismantling
resource "azurerm_api_management_api_operation_policy" "paSendRT_v2_wisp_api_policy" {
  count               = var.create_wisp_converter ? 1 : 0
  api_name            = azurerm_api_management_api.apim_api_gpd_payments_soap_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  // GPD Payments pagoPA - SOAP.openapi
  operation_id = var.env_short == "d" ? "647f29ab3b3a67085861dd4e" : var.env_short == "u" ? "64803ea3affcab1af451559a" : "648084deed366019b015f1b8"

  #tfsec:ignore:GEN005
  xml_content = file("./api/payments-service/v1/soap/wisp-paSendRTV2.xml")
}


###################
## REST Products ##
###################

module "apim_gpd_payments_rest_external_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "gpd-payments-rest-aks"
  display_name = "GPD Payments pagoPA - REST for Auth"
  description  = "API Prodotto Payments gestione posizioni debitorie - REST for Auth"

  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name

  published             = local.apim_gpd_payments_rest_external_api.published
  subscription_required = local.apim_gpd_payments_rest_external_api.subscription_required
  approval_required     = local.apim_gpd_payments_rest_external_api.approval_required
  subscriptions_limit   = local.apim_gpd_payments_rest_external_api.subscriptions_limit

  policy_xml = file("./api_product/payments-service/external/_base_policy.xml")
}

##############
## REST API ##
##############

resource "azurerm_api_management_api_version_set" "api_gpd_payments_rest_external_api" {
  name                = format("%s-gpd-payments-rest-api-aks", var.env_short)
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_gpd_payments_rest_external_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_api_gpd_payments_rest_external_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-gpd-payments-rest-api-aks", var.env_short)
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_gpd_payments_rest_external_product.product_id, module.apim_gpd_integration_product.product_id, "technical_support_api"]
  subscription_required = local.apim_gpd_payments_rest_external_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_gpd_payments_rest_external_api.id
  api_version           = "v1"

  description  = local.apim_gpd_payments_rest_external_api.description
  display_name = local.apim_gpd_payments_rest_external_api.display_name
  path         = local.apim_gpd_payments_rest_external_api.path
  protocols    = ["https"]
  service_url  = local.apim_gpd_payments_rest_external_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/payments-service/v1/rest/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_gpd_payments_rest_external_product.product_id
  })

  xml_content = templatefile("./api/payments-service/v1/rest/_base_policy.xml", {
    hostname = local.gps_hostname
  })
}
