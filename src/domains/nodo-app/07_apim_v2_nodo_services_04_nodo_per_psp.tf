#######################
### WS nodo per psp ##
#######################
#locals {
#  apim_nodo_per_psp_api = {
#    display_name          = "Nodo per PSP WS"
#    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
#    path                  = "nodo/nodo-per-psp"
#    subscription_required = var.nodo_pagamenti_subkey_required
#    service_url           = null
#  }
#}
#
#resource "azurerm_api_management_api_version_set" "nodo_per_psp_api" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                = format("%s-nodo-per-psp-api", var.env_short)
#  resource_group_name = local.pagopa_apim_v2_rg
#  api_management_name = local.pagopa_apim_v2_name
#  display_name        = local.apim_nodo_per_psp_api.display_name
#  versioning_scheme   = "Segment"
#}
#
#resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                  = format("%s-nodo-per-psp-api", var.env_short)
#  api_management_name   = local.pagopa_apim_v2_name
#  resource_group_name   = local.pagopa_apim_v2_rg
#  subscription_required = local.apim_nodo_per_psp_api.subscription_required
#  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api[0].id
#  version               = "v1"
#  service_url           = local.apim_nodo_per_psp_api.service_url
#  revision              = "1"
#
#  description  = local.apim_nodo_per_psp_api.description
#  display_name = local.apim_nodo_per_psp_api.display_name
#  path         = local.apim_nodo_per_psp_api.path
#  protocols    = ["https"]
#
#  soap_pass_through = true
#
#  import {
#    content_format = "wsdl"
#    content_value  = file("./apim_v2/api/nodopagamenti_api/nodoPerPsp/v1/nodoPerPsp.wsdl")
#    wsdl_selector {
#      service_name  = "PagamentiTelematiciPspNodoservice"
#      endpoint_name = "PPTPort"
#    }
#  }
#
#}
#
#resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  api_name            = azurerm_api_management_api.apim_nodo_per_psp_api_v1[0].name
#  api_management_name = local.pagopa_apim_v2_name
#  resource_group_name = local.pagopa_apim_v2_rg
#
#  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
#    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#  })
#}
#
#
#
#######################################
### WS nodo per psp richiesta avvisi ##
#######################################
#locals {
#  apim_nodo_per_psp_richiesta_avvisi_api = {
#    display_name          = "Nodo per PSP Richiesta Avvisi WS"
#    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
#    path                  = "nodo/nodo-per-psp-richiesta-avvisi"
#    subscription_required = var.nodo_pagamenti_subkey_required
#    service_url           = null
#  }
#}
#
#resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
#  resource_group_name = local.pagopa_apim_v2_rg
#  api_management_name = local.pagopa_apim_v2_name
#  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
#  versioning_scheme   = "Segment"
#}
#
#resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
#  api_management_name   = local.pagopa_apim_v2_name
#  resource_group_name   = local.pagopa_apim_v2_rg
#  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api.subscription_required
#  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api[0].id
#  version               = "v1"
#  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api.service_url
#  revision              = "1"
#
#  description  = local.apim_nodo_per_psp_richiesta_avvisi_api.description
#  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
#  path         = local.apim_nodo_per_psp_richiesta_avvisi_api.path
#  protocols    = ["https"]
#
#  soap_pass_through = true
#
#  import {
#    content_format = "wsdl"
#    content_value  = file("./apim_v2/api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/nodoPerPspRichiestaAvvisi.wsdl")
#    wsdl_selector {
#      service_name  = "RichiestaAvvisiservice"
#      endpoint_name = "PPTPort"
#    }
#  }
#
#}
#
#resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy" {
#  count = var.enabled_features.apim_v2 ? 1 : 0
#
#  api_name            = azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1[0].name
#  api_management_name = local.pagopa_apim_v2_name
#  resource_group_name = local.pagopa_apim_v2_rg
#
#  xml_content = templatefile("./apim_v2/api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
#    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#  })
#
#}
