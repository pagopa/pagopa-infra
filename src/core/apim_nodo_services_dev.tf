# ##############
# ## Products ##
# ##############
#
# module "apim_nodo_dei_pagamenti_product_dev" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "nodo-dev"
#   display_name = "Nodo dei Pagamenti (DEV)"
#   description  = "Product for Nodo dei Pagamenti"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = var.nodo_pagamenti_subkey_required
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#   })
# }
#
# locals {
#
#   api_nodo_product_dev = var.env_short == "d" ? [
#     azurerm_api_management_api.apim_node_for_psp_api_v1_dev[0].name,
#     azurerm_api_management_api.apim_nodo_per_psp_api_v1_dev[0].name,
#     azurerm_api_management_api.apim_node_for_io_api_v1_dev[0].name,
#     azurerm_api_management_api.apim_nodo_per_pa_api_v1_dev[0].name,
#   ] : []
#
# }
#
# resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_dev" {
#   for_each = toset(local.api_nodo_product_dev)
#
#   api_name            = each.key
#   product_id          = module.apim_nodo_dei_pagamenti_product_dev[0].product_id
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
# }
#
# ############################
# ## WS node for psp (NM3) ##
# ############################
# locals {
#   apim_node_for_psp_api_dev = {
#     display_name          = "Node for PSP WS (NM3) (DEV)"
#     description           = "Web services to support PSP in payment activations, defined in nodeForPsp.wsdl"
#     path                  = "nodo-dev/node-for-psp"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "node_for_psp_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-node-for-psp-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_node_for_psp_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_node_for_psp_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                  = format("%s-node-for-psp-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_node_for_psp_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.node_for_psp_api_dev[0].id
#   version               = "v1"
#   service_url           = local.apim_node_for_psp_api_dev.service_url
#   revision              = "1"
#
#   description  = local.apim_node_for_psp_api_dev.description
#   display_name = local.apim_node_for_psp_api_dev.display_name
#   path         = local.apim_node_for_psp_api_dev.path
#   protocols    = ["https"]
#
#   soap_pass_through = true
#
#   import {
#     content_format = "wsdl"
#     content_value  = file("./api/nodopagamenti_api/nodeForPsp/v1/nodeForPsp.wsdl")
#     wsdl_selector {
#       service_name  = "nodeForPsp_Service"
#       endpoint_name = "nodeForPsp_Port"
#     }
#   }
#
# }
#
# resource "azurerm_api_management_api_policy" "apim_node_for_psp_policy_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = azurerm_api_management_api.apim_node_for_psp_api_v1_dev[0].name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodeForPsp/v1/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# ################################
# # NOT USED in DEV NEXI only SIT
# ################################
#
# # resource "azurerm_api_management_api_operation_policy" "nm3_activate_verify_policy_dev" {
#
# #   api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1_dev[0].name
# #   api_management_name = module.apim[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   operation_id        = var.env_short == "d" ? "61d70973b78e982064458676" : var.env_short == "u" ? "61dedb1872975e13800fd7ff" : "61dedafc2a92e81a0c7a58fc"
#
# #   #tfsec:ignore:GEN005
# #   xml_content = file("./api/nodopagamenti_api/nodeForPsp/v1/activate_nm3.xml")
# # }
#
# # resource "azurerm_api_management_api_operation_policy" "nm3_activate_v2_verify_policy" { # activatePaymentNoticeV2 verificatore
#
# #   api_name            = resource.azurerm_api_management_api.apim_node_for_psp_api_v1.name
# #   api_management_name = module.apim[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   operation_id        = var.env_short == "d" ? "637601f8c257810fc0ecfe06" : var.env_short == "u" ? "636e6ca51a11929386f0b101" : "TODO"
#
# #   #tfsec:ignore:GEN005
# #   xml_content = file("./api/nodopagamenti_api/nodeForPsp/v2/activate_nm3.xml")
# # }
#
# ######################
# ## WS nodo per psp ##
# ######################
# locals {
#   apim_nodo_per_psp_api_dev = {
#     display_name          = "Nodo per PSP WS (DEV)"
#     description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
#     path                  = "nodo-dev/nodo-per-psp"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_psp_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-per-psp-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_per_psp_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                  = format("%s-nodo-per-psp-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_psp_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api_dev[0].id
#   version               = "v1"
#   service_url           = local.apim_nodo_per_psp_api_dev.service_url
#   revision              = "1"
#
#   description  = local.apim_nodo_per_psp_api_dev.description
#   display_name = local.apim_nodo_per_psp_api_dev.display_name
#   path         = local.apim_nodo_per_psp_api_dev.path
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
# resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = azurerm_api_management_api.apim_nodo_per_psp_api_v1_dev[0].name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
#
# ######################################
# ## WS nodo per psp richiesta avvisi ##
# ######################################
# locals {
#   apim_nodo_per_psp_richiesta_avvisi_api_dev = {
#     display_name          = "Nodo per PSP Richiesta Avvisi WS (DEV)"
#     description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
#     path                  = "nodo-dev/nodo-per-psp-richiesta-avvisi"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-per-psp-richiesta-avvisi-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                  = format("%s-nodo-per-psp-richiesta-avvisi-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_dev[0].id
#   version               = "v1"
#   service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.service_url
#   revision              = "1"
#
#   description  = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.description
#   display_name = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.display_name
#   path         = local.apim_nodo_per_psp_richiesta_avvisi_api_dev.path
#   protocols    = ["https"]
#
#   soap_pass_through = true
#
#   import {
#     content_format = "wsdl"
#     content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/nodoPerPspRichiestaAvvisi.wsdl")
#     wsdl_selector {
#       service_name  = "RichiestaAvvisiservice"
#       endpoint_name = "PPTPort"
#     }
#   }
#
# }
#
# resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_dev[0].name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
#
# }
#
#
# ######################
# ## WS nodo for IO   ##
# ######################
# locals {
#   apim_node_for_io_api_dev = {
#     display_name          = "Node for IO WS (DEV)"
#     description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
#     path                  = "nodo-dev/node-for-io"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "node_for_io_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-for-io-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_node_for_io_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_node_for_io_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                  = format("%s-node-for-io-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_node_for_io_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.node_for_io_api_dev[0].id
#   version               = "v1"
#   service_url           = local.apim_node_for_io_api_dev.service_url
#   revision              = "1"
#
#   description  = local.apim_node_for_io_api_dev.description
#   display_name = local.apim_node_for_io_api_dev.display_name
#   path         = local.apim_node_for_io_api_dev.path
#   protocols    = ["https"]
#
#   soap_pass_through = true
#
#   import {
#     content_format = "wsdl"
#     content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/nodeForIO.wsdl")
#     wsdl_selector {
#       service_name  = "nodeForIO_Service"
#       endpoint_name = "nodeForIO_Port"
#     }
#   }
#
# }
#
# resource "azurerm_api_management_api_policy" "apim_node_for_io_policy_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = azurerm_api_management_api.apim_node_for_io_api_v1_dev[0].name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
#
# }
#
# # resource "azurerm_api_management_api_operation_policy" "activateIO_reservation_policy_dev" {
#
# #   api_name            = resource.azurerm_api_management_api.apim_node_for_io_api_v1_dev[0].name
# #   api_management_name = module.apim[0].name
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   operation_id        = var.env_short == "d" ? "61dc5018b78e981290d7c176" : var.env_short == "u" ? "61dedb1e72975e13800fd80f" : "61dedb1eea7c4a07cc7d47b8"
#
# #   #tfsec:ignore:GEN005
# #   xml_content = file("./api/nodopagamenti_api/nodeForIO/v1/activateIO_reservation_nm3.xml")
# # }
#
# ############################
# ## WS psp for node (NM3) ##
# ############################
# #locals {
# #  apim_psp_for_node_api_dev = {
# #    display_name          = "PSP for Node WS (NM3) (DEV)"
# #    description           = "Web services to support payment transaction started on any PagoPA client, defined in pspForNode.wsdl"
# #    path                  = "nodo-dev/psp-for-node"
# #    subscription_required = var.nodo_pagamenti_subkey_required
# #    service_url           = null
# #  }
# #}
# #
# #resource "azurerm_api_management_api_version_set" "psp_for_node_api_dev" {
# #  count = var.env_short == "d" ? 1 : 0
# #
# #  name                = format("%s-psp-for-node-api-dev", var.env_short)
# #  resource_group_name = data.azurerm_resource_group.rg_api.name
# #  api_management_name = module.apim[0].name
# #  display_name        = local.apim_psp_for_node_api_dev.display_name
# #  versioning_scheme   = "Segment"
# #}
# #
# #resource "azurerm_api_management_api" "apim_psp_for_node_api_v1_dev" {
# #  count = var.env_short == "d" ? 1 : 0
# #
# #  name                  = format("%s-psp-for-node-api-dev", var.env_short)
# #  api_management_name   = module.apim[0].name
# #  resource_group_name   = data.azurerm_resource_group.rg_api.name
# #  subscription_required = local.apim_psp_for_node_api_dev.subscription_required
# #  version_set_id        = azurerm_api_management_api_version_set.psp_for_node_api_dev[0].id
# #  version               = "v1"
# #  service_url           = local.apim_psp_for_node_api_dev.service_url
# #  revision              = "1"
# #
# #  description  = local.apim_psp_for_node_api_dev.description
# #  display_name = local.apim_psp_for_node_api_dev.display_name
# #  path         = local.apim_psp_for_node_api_dev.path
# #  protocols    = ["https"]
# #
# #  soap_pass_through = true
# #
# #  import {
# #    content_format = "wsdl"
# #    content_value  = file("./api/nodopagamenti_api/pspForNode/v1/pspForNode.wsdl")
# #    wsdl_selector {
# #      service_name  = "pspForNode_Service"
# #      endpoint_name = "pspForNode_Port"
# #    }
# #  }
# #
# #}
# #
# #resource "azurerm_api_management_api_policy" "apim_psp_for_node_policy_dev" {
# #  count = var.env_short == "d" ? 1 : 0
# #
# #  api_name            = azurerm_api_management_api.apim_psp_for_node_api_v1_dev[0].name
# #  api_management_name = module.apim[0].name
# #  resource_group_name = data.azurerm_resource_group.rg_api.name
# #
# #  xml_content = file("./api/nodopagamenti_api/pspForNode/v1/_base_policy.xml")
# #}
#
#
# ######################
# ## WS nodo per PA ##
# ######################
# locals {
#   apim_nodo_per_pa_api_dev = {
#     display_name          = "Nodo per PA WS (DEV)"
#     description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
#     path                  = "nodo-dev/nodo-per-pa"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-per-pa-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_per_pa_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# resource "azurerm_api_management_api" "apim_nodo_per_pa_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                  = format("%s-nodo-per-pa-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_pa_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_pa_api_dev[0].id
#   version               = "v1"
#   service_url           = local.apim_nodo_per_pa_api_dev.service_url
#   revision              = "1"
#
#   description  = local.apim_nodo_per_pa_api_dev.description
#   display_name = local.apim_nodo_per_pa_api_dev.display_name
#   path         = local.apim_nodo_per_pa_api_dev.path
#   protocols    = ["https"]
#
#   soap_pass_through = true
#
#   import {
#     content_format = "wsdl"
#     content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/NodoPerPa.wsdl")
#     wsdl_selector {
#       service_name  = "PagamentiTelematiciRPTservice"
#       endpoint_name = "PagamentiTelematiciRPTPort"
#     }
#   }
#
# }
#
# resource "azurerm_api_management_api_policy" "apim_nodo_per_pa_policy_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = azurerm_api_management_api.apim_nodo_per_pa_api_v1_dev[0].name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# ######################
# ## Nodo per PM API  ##
# ######################
# locals {
#   apim_nodo_per_pm_api_dev = {
#     display_name          = "Nodo per Payment Manager API (DEV)"
#     description           = "API to support Payment Manager"
#     path                  = "nodo-dev/nodo-per-pm"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-per-pm-api-dev", local.project)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_per_pm_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# module "apim_nodo_per_pm_api_v1_dev" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"
#
#   name                  = format("%s-nodo-per-pm-api-dev", local.project)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_pm_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_dev[0].id
#   api_version           = "v1"
#   service_url           = local.apim_nodo_per_pm_api_dev.service_url
#
#   description  = local.apim_nodo_per_pm_api_dev.description
#   display_name = local.apim_nodo_per_pm_api_dev.display_name
#   path         = local.apim_nodo_per_pm_api_dev.path
#   protocols    = ["https"]
#
#   content_format = "swagger-json"
#   content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
#     host    = local.api_domain
#     service = module.apim_nodo_dei_pagamenti_product_dev[0].product_id
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# resource "azurerm_api_management_api_operation_policy" "close_payment_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = format("%s-nodo-per-pm-api-dev-v1", local.project)
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   operation_id        = "closePayment"
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# resource "azurerm_api_management_api_operation_policy" "parked_list_api_v1_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   api_name            = format("%s-nodo-per-pm-api-dev-v1", local.project)
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   operation_id        = "parkedList"
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_add_v1_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# module "apim_nodo_per_pm_api_v2_dev" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"
#
#   name                  = format("%s-nodo-per-pm-api-dev", local.project)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   subscription_required = local.apim_nodo_per_pm_api_dev.subscription_required
#   version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_dev[0].id
#   api_version           = "v2"
#   service_url           = local.apim_nodo_per_pm_api_dev.service_url
#
#   description  = local.apim_nodo_per_pm_api_dev.description
#   display_name = local.apim_nodo_per_pm_api_dev.display_name
#   path         = local.apim_nodo_per_pm_api_dev.path
#   protocols    = ["https"]
#
#   content_format = "swagger-json"
#   content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_base_policy_dev.xml.tpl", {
#     is-nodo-decoupler-enabled = false
#   })
# }
#
# ######################
# ## NODO monitoring  ##
# ######################
# locals {
#   apim_nodo_monitoring_api_dev = {
#     display_name          = "Nodo monitoring (DEV)"
#     description           = "Nodo monitoring"
#     path                  = "nodo-dev-monitoring/monitoring"
#     subscription_required = var.nodo_pagamenti_subkey_required
#     service_url           = null
#   }
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_monitoring_api_dev" {
#   count = var.env_short == "d" ? 1 : 0
#
#   name                = format("%s-nodo-monitoring-api-dev", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = local.apim_nodo_monitoring_api_dev.display_name
#   versioning_scheme   = "Segment"
# }
#
# module "apim_nodo_monitoring_api_dev" {
#   count  = var.env_short == "d" ? 1 : 0
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-monitoring-api-dev", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_dei_pagamenti_product_dev[0].product_id]
#   subscription_required = local.apim_nodo_monitoring_api_dev.subscription_required
#
#   version_set_id = azurerm_api_management_api_version_set.nodo_monitoring_api_dev[0].id
#   api_version    = "v1"
#
#   description  = local.apim_nodo_monitoring_api_dev.description
#   display_name = local.apim_nodo_monitoring_api_dev.display_name
#   path         = local.apim_nodo_monitoring_api_dev.path
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/monitoring/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host    = local.api_domain
#     service = module.apim_nodo_dei_pagamenti_product_dev[0].product_id
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/monitoring/v1/_base_policy.xml.tpl", {
#     base-url     = "{{default-nodo-backend-dev-nexi}}"
#     allowed_ip_1 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
#     allowed_ip_2 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
#     allowed_ip_3 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
#     allowed_ip_4 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
#     allowed_ip_5 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[10] # NEXI VPN
#   })
# }
