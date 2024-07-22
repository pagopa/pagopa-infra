######################
## WS nodo for IO   ##
######################
locals {
  apim_node_for_io_api = {
    display_name          = "Node for IO WS"
    description           = "Web services to support activeIO, defined in nodeForIO.wsdl"
    path                  = "nodo/node-for-io"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "node_for_io_api" {
  name                = format("%s-nodo-for-io-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_node_for_io_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_node_for_io_api_v1" {
  name                  = format("%s-node-for-io-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_node_for_io_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.node_for_io_api.id
  version               = "v1"
  service_url           = local.apim_node_for_io_api.service_url
  revision              = "1"

  description  = local.apim_node_for_io_api.description
  display_name = local.apim_node_for_io_api.display_name
  path         = local.apim_node_for_io_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodeForIO/v1/nodeForIO.wsdl")
    wsdl_selector {
      service_name  = "nodeForIO_Service"
      endpoint_name = "nodeForIO_Port"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_node_for_io_policy" {
  api_name            = azurerm_api_management_api.apim_node_for_io_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodeForIO/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })

}

resource "azurerm_api_management_api_operation_policy" "activateIO_reservation_policy" {

  api_name            = azurerm_api_management_api.apim_node_for_io_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "61dc5018b78e981290d7c176" : var.env_short == "u" ? "61dedb1e72975e13800fd80f" : "61dedb1eea7c4a07cc7d47b8"

  #tfsec:ignore:GEN005
  xml_content = file("./api/nodopagamenti_api/nodeForIO/v1/activateIO_reservation_nm3.xml")
}
