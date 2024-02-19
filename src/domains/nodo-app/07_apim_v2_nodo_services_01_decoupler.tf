###############
## Decoupler ##
###############
# named value containing primitive names for routing algorithm
resource "azurerm_api_management_named_value" "node_decoupler_primitives" {
  name                = "node-decoupler-primitives"
  api_management_name = local.pagopa_apim_v2_name
  resource_group_name = local.pagopa_apim_v2_rg
  display_name        = "node-decoupler-primitives"
  value               = var.node_decoupler_primitives
}

# convert configuration from JSON to XML
resource "null_resource" "decoupler_configuration_from_json_2_xml" {

  triggers = {
    "changes-in-config-decoupler" : sha1(file("./apim_v2/api_product/nodo_pagamenti_api/decoupler/cfg/${var.env}/decoupler_configuration.json"))
  }
  provisioner "local-exec" {
    command = "sh ./apim_v2/api_product/nodo_pagamenti_api/decoupler/cfg/decoupler_configurator.sh ${var.env}"
  }
}


# fragment for loading configuration inside policy
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "azapi_resource" "decoupler_configuration" {

  depends_on = [null_resource.decoupler_configuration_from_json_2_xml]

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-configuration"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "Configuration of NDP decoupler"
      format      = "rawxml"
      value       = file("./apim_v2/api_product/nodo_pagamenti_api/decoupler/cfg/${var.env}/decoupler-configuration.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# decoupler algorithm fragment
resource "azapi_resource" "decoupler_algorithm" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-algorithm"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "Logic about NPD decoupler"
      format      = "rawxml"
      value       = file("./apim_v2/api_product/nodo_pagamenti_api/decoupler/decoupler-algorithm.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing outbound policy if primitive is activatePayment or activateIO
resource "azapi_resource" "decoupler_activate_outbound" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-activate-outbound"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "Outbound logic for Activate primitive of NDP decoupler"
      format      = "rawxml"
      value       = file("./apim_v2/api_product/nodo_pagamenti_api/decoupler/decoupler-activate-outbound.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "azapi_resource" "on_erro_soap_handler" {
  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "onerror-soap-req"
  parent_id = data.azurerm_api_management.apim_v2.id

  body = jsonencode({
    properties = {
      description = "On error SOAP request"
      format      = "rawxml"
      value       = file("./apim_v2/api_product/nodo_pagamenti_api/on_error_soap_req.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

