######################################
### FdR moved in the related domain ##
######################################
#
#####################
### WS nodo per PA ##
#####################
#locals {
#  apim_nodo_per_pa_api = {
#    display_name          = "Nodo per PA WS"
#    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
#    path                  = "nodo/nodo-per-pa"
#    subscription_required = var.nodo_pagamenti_subkey_required
#    service_url           = null
#  }
#}
#
#resource "azurerm_api_management_api_version_set" "nodo_per_pa_api" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                = format("%s-nodo-per-pa-api", var.env_short)
#  resource_group_name = local.pagopa_apim_v2_rg
#  api_management_name = local.pagopa_apim_v2_name
#  display_name        = local.apim_nodo_per_pa_api.display_name
#  versioning_scheme   = "Segment"
#}
#
#resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                  = format("%s-nodo-per-pa-api", var.env_short)
#  api_management_name   = local.pagopa_apim_v2_name
#  resource_group_name   = local.pagopa_apim_v2_rg
#  subscription_required = local.apim_nodo_per_pa_api.subscription_required
#  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api[0].id
#  version               = "v1"
#  service_url           = local.apim_nodo_per_pa_api.service_url
#  revision              = "1"
#
#  description  = local.apim_nodo_per_pa_api.description
#  display_name = local.apim_nodo_per_pa_api.display_name
#  path         = local.apim_nodo_per_pa_api.path
#  protocols    = ["https"]
#
#  soap_pass_through = true
#
#  import {
#    content_format = "wsdl"
#    content_value  = file("./apim_v2/api/nodopagamenti_api/nodoPerPa/v1/NodoPerPa.wsdl")
#    wsdl_selector {
#      service_name  = "PagamentiTelematiciRPTservice"
#      endpoint_name = "PagamentiTelematiciRPTPort"
#    }
#  }
#}
#
#resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1[0].name
#  api_management_name = local.pagopa_apim_v2_name
#  resource_group_name = local.pagopa_apim_v2_rg
#
#  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPa/v1/_base_policy.xml.tpl", {
#    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#  })
#}
