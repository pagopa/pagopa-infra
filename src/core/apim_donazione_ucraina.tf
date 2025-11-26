##############
## Products ##
##############

module "apim_donazioni_ucraina_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-donazioni"
  display_name = "Donazioni Ucraina"
  description  = "Donazioni Ucraina"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false # TO DISABLE
  approval_required     = false
  subscriptions_limit   = 1

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

##############
##    API   ##
##############

resource "azurerm_api_management_api_version_set" "api_donazioni_ucraina_api" {
  name                = format("%s-api-donazioni-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "DonazioniUcraina"
  versioning_scheme   = "Segment"
}


resource "azurerm_api_management_api" "apim_api_donazioni_ucraina_api" {
  name                  = format("%s-api-donazioni-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = false # TO DISABLE
  service_url           = null  // no BE
  version_set_id        = azurerm_api_management_api_version_set.api_donazioni_ucraina_api.id
  version               = "v1"
  revision              = "1"

  description  = "Donazioni Ucraina"
  display_name = "Donazioni Ucraina"
  path         = "donazioni/api"
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/paForNode/v1/paForNode.wsdl")
    wsdl_selector {
      service_name  = "paForNode_Service"
      endpoint_name = "paForNode_Port"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_node_for_donazioni_policy" {
  api_name            = resource.azurerm_api_management_api.apim_api_donazioni_ucraina_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = file("./api/nodopagamenti_api/paForNode/v1/_base_policy.xml")
}

resource "azurerm_api_management_api_operation_policy" "donazioni_verify_policy" {

  api_name            = resource.azurerm_api_management_api.apim_api_donazioni_ucraina_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "62288e2395aa0302946b0816" : var.env_short == "u" ? "6228a009e0f4ba13a4784890" : "6228bea3ea7c4a1b8c3fcf54"

  xml_content = file("./api/nodopagamenti_api/paForNode/v1/donazioni_ucraina_verify.xml")
}

resource "azurerm_api_management_api_operation_policy" "donazioni_activate_policy" {

  api_name            = resource.azurerm_api_management_api.apim_api_donazioni_ucraina_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "62288e2395aa0302946b0817" : var.env_short == "u" ? "6228a009e0f4ba13a4784891" : "6228bea3ea7c4a1b8c3fcf55"

  xml_content = file("./api/nodopagamenti_api/paForNode/v1/donazioni_ucraina_activate.xml")
}

resource "azurerm_api_management_api_operation_policy" "donazioni_sendrt_policy" {

  api_name            = resource.azurerm_api_management_api.apim_api_donazioni_ucraina_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "62288e2395aa0302946b0818" : var.env_short == "u" ? "6228a009e0f4ba13a4784892" : "6228bea3ea7c4a1b8c3fcf56"

  xml_content = file("./api/nodopagamenti_api/paForNode/v1/donazioni_ucraina_sendrt.xml")
}
