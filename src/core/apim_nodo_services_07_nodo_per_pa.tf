#####################################
## FdR moved in the related domain ##
#####################################

####################
## WS nodo per PA ##
####################
locals {
  apim_nodo_per_pa_api = {
    display_name          = "Nodo per PA WS"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "nodo/nodo-per-pa"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api" {
  name                = format("%s-nodo-per-pa-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_nodo_per_pa_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1" {
  name                  = format("%s-nodo-per-pa-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_pa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_pa_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_pa_api.description
  display_name = local.apim_nodo_per_pa_api.display_name
  path         = local.apim_nodo_per_pa_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy" {
  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}

# nodoInviaRPT x WISP dismantling
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_api_v1_policy" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf8fa" : var.env_short == "u" ? "62189aede0f4ba17a8eae8e9" : "62189aea2a92e81fa4f15ec6"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml")
}

resource "terraform_data" "sha256_nodoInviaRPT_api_v1_policy" {
  input = sha256(file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaRPT_policy.xml"))
}

# nodoInviaCarrelloRPT x WISP dismantling
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_api_v1_policy" {
  count = var.create_wisp_converter ? 1 : 0

  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf8fb" : var.env_short == "u" ? "62189aede0f4ba17a8eae8ea" : "62189aea2a92e81fa4f15ec7"
  xml_content         = file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml")
}

resource "terraform_data" "sha256_nodoInviaCarrelloRPT_api_v1_policy" {
  input = sha256(file("./api/nodopagamenti_api/nodoPerPa/v1/nodoInviaCarrelloRPT_policy.xml"))
}
