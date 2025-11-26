###############
## Decoupler ##
###############
# named value containing primitive names for routing algorithm
resource "azurerm_api_management_named_value" "node_decoupler_primitives" {
  name                = "node-decoupler-primitives"
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "node-decoupler-primitives"
  value               = var.node_decoupler_primitives
}

# convert configuration from JSON to XML
resource "null_resource" "decoupler_configuration_from_json_2_xml" {

  triggers = {
    "changes-in-config-decoupler" : sha1(file("./api_product/nodo_pagamenti_api/decoupler/cfg/${var.env}/decoupler_configuration.json"))
  }
  provisioner "local-exec" {
    command = "sh ./api_product/nodo_pagamenti_api/decoupler/cfg/decoupler_configurator.sh ${var.env}"
  }
}


# fragment for loading configuration inside policy
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_decoupler_configuration" {
  input = sha256(file("./api_product/nodo_pagamenti_api/decoupler/cfg/${var.env}/decoupler-configuration.xml"))
}
resource "azapi_resource" "decoupler_configuration" {

  depends_on = [null_resource.decoupler_configuration_from_json_2_xml]

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-configuration"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "Configuration of NDP decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/decoupler/cfg/${var.env}/decoupler-configuration.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# decoupler algorithm fragment
resource "terraform_data" "sha256_decoupler_algorithm" {
  input = sha256(file("./api_product/nodo_pagamenti_api/decoupler/decoupler-algorithm.xml"))
}
resource "azapi_resource" "decoupler_algorithm" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-algorithm"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "Logic about NPD decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/decoupler/decoupler-algorithm.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing inbound policy if primitive is activatePaymentV2
resource "terraform_data" "sha256_decoupler_activate_inbound" {
  input = sha256(file("./api_product/nodo_pagamenti_api/decoupler/decoupler-activate-inbound.xml"))
}
resource "azapi_resource" "decoupler_activate_inbound" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-activate-inbound"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "Inbound logic for Activate primitive of NDP decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/decoupler/decoupler-activate-inbound.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing outbound policy if primitive is activatePayment or activateIO
resource "terraform_data" "sha256_decoupler_activate_outbound" {
  input = sha256(file("./api_product/nodo_pagamenti_api/decoupler/decoupler-activate-outbound.xml"))
}
resource "azapi_resource" "decoupler_activate_outbound" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-activate-outbound"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "Outbound logic for Activate primitive of NDP decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/decoupler/decoupler-activate-outbound.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

locals {
  on_error_soap_file = templatefile("./api_product/nodo_pagamenti_api/on_error_soap_req.xml", {
    ndphost_variable = file("./api_product/nodo_pagamenti_api/env/${var.env}/ndphost_header.xml")
  })
}

resource "terraform_data" "sha256_on_erro_soap_handler" {
  input = sha256(file("./api_product/nodo_pagamenti_api/on_error_soap_req.xml"))
}
resource "azapi_resource" "on_erro_soap_handler" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "onerror-soap-req"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "On error SOAP request"
      format      = "rawxml"
      value       = local.on_error_soap_file
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing outbound policy for nodoInviaRPT and nodoInviaCarrelloRPT
resource "terraform_data" "sha256_nodoinviarpt_wisp_nodoinviacarrellorpt_outbound_policy" {
  input = sha256(file("./api/nodopagamenti_api/nodoPerPa/v1/wisp_nodoInviaRPT_nodoInviaCarrelloRPT_outbound_policy.xml"))
}
resource "azapi_resource" "wisp_nodoinviarpt_nodoinviacarrellorpt_outbound_policy" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "wisp-nodoinviarpt-nodoinviacarrellorpt-outbound"
  parent_id = data.azurerm_api_management.apim_migrated[0].id

  body = jsonencode({
    properties = {
      description = "Outbound policy for nodoInviaRPT / nodoInviaCarrelloRPT regarding WISP"
      format      = "rawxml"
      value       = file("./api/nodopagamenti_api/nodoPerPa/v1/wisp_nodoInviaRPT_nodoInviaCarrelloRPT_outbound_policy.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}
