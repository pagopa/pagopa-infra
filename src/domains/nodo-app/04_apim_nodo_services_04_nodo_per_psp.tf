######################
## WS Nodo per PSP ##
######################
# locals {
#   apim_nodo_per_psp_api = {
#     display_name          = "Nodo per PSP WS"
#     description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
#     path                  = "nodo/nodo-per-psp"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_psp_api" {
#   name                = format("%s-nodo-per-psp-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_per_psp_api.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1" {
#   name                  = format("%s-nodo-per-psp-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_psp_api.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api.id
#   version               = "v1"
#   service_url           = local.apim_nodo_per_psp_api.service_url
#   revision              = "1"
#
#   description  = local.apim_nodo_per_psp_api.description
#   display_name = local.apim_nodo_per_psp_api.display_name
#   path         = local.apim_nodo_per_psp_api.path
#   protocols    = ["https"]
#
#   soap_pass_through = true
#
#   import {
#     content_format = "wsdl"
#     content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/nodoPerPsp.wsdl")
#     wsdl_selector {
#       service_name  = "PagamentiTelematiciPspNodoservice"
#       endpoint_name = "PPTPort"
#     }
#   }
#
# }
#
# resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy" {
#   api_name            = azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
#   })
# }



######################################
## WS Nodo per PSP Richiesta Avvisi ##
######################################
# locals {
#   apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/base_policy.xml")
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api" {
#   name                = "${var.env_short}-nodo-per-psp-richiesta-avvisi-api-2" #TODO [FCADAC] remove 2
#   resource_group_name = data.azurerm_api_management.apim.resource_group_name
#   api_management_name = data.azurerm_api_management.apim.name
#   display_name        = "Nodo per PSP Richiesta Avvisi 2.0"   #TODO [FCADAC] remove 2.0
#   versioning_scheme   = "Segment"
# }
#
# resource "terraform_data" "sha256_apim_nodo_per_psp_richiesta_avvisi_api_v1" {
#   input = sha256(local.apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file)
# }
# module "apim_nodo_per_pm_api_v1" {
#   source = "./.terraform/modules/__v3__/api_management_api"
#
#   name                  = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api.name
#   api_management_name   = data.azurerm_api_management.apim.name
#   resource_group_name   = data.azurerm_api_management.apim.resource_group_name
#
#   product_ids           = [module.apim_nodo_dei_pagamenti_product.product_id]
#
#   subscription_required = false
#
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api.id
#   api_version           = "v1"
#   service_url           = null
#
#   description  = "Web services to support check of pending payments to PSP, defined in NodoPerPspRichiestaAvvisi.wsdl 2.0" #TODO [FCADAC] remove 2.0
#   display_name = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api.display_name
#   path         = "nodo/nodo-per-psp-richiesta-avvisi"                 #TODO [FCADAC] remove 2
#   protocols    = ["https"]
#
#   content_format = "wsdl"
#   content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/wsdl/NodoPerPspRichiestaAvvisi.wsdl")
#   wsdl_selector = {
#     service_name  = "RichiestaAvvisiservice"
#     endpoint_name = "PPTPort"
#   }
#
#   xml_content = local.apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file
# }
