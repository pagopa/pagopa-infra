##################################
## WISP Converter - SOAP Action ##
## - nodoInviaRPT               ##
## - nodoInviaCarrelloRPT       ##
## The primitives belongs to    ##
## case "Other", so always      ##
## towards default backend url  ##
##################################

data "azurerm_resource_group" "rg_api" {
  name = "${local.product}-api-rg"
}

data "azurerm_api_management_api" "apim_nodo_per_pa_api_v1" {
  name                = "${var.env_short}-nodo-per-pa-api"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  revision            = "1"
}

locals {
  nodoInviaRPT = {
    dev  = "6218976195aa0303ccfcf8fa"
    uat  = ""
    prod = ""
  }
  nodoInviaCarrelloRPT = {
    dev  = "6218976195aa0303ccfcf8fb"
    uat  = ""
    prod = ""
  }
}


# nodoInviaRPT DEV
# nodoInviaRPT UAT
# nodoInviaRPT PRD
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaRPT" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaRPT.dev : var.env_short == "u" ? local.nodoInviaRPT.uat : local.nodoInviaRPT.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}


# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaCarrelloRPT" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaCarrelloRPT.dev : var.env_short == "u" ? local.nodoInviaCarrelloRPT.uat : local.nodoInviaCarrelloRPT.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaCarrelloRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}
