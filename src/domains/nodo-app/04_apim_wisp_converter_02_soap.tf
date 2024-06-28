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

###############
## NODO      ##
###############

locals {
  nodoInviaRPT = {
    dev  = "6218976195aa0303ccfcf8fa"
    uat  = "62189aede0f4ba17a8eae8e9"
    prod = "62189aea2a92e81fa4f15ec6"
  }
  nodoInviaCarrelloRPT = {
    dev  = "6218976195aa0303ccfcf8fb"
    uat  = "62189aede0f4ba17a8eae8ea"
    prod = "62189aea2a92e81fa4f15ec7"
  }
}


# nodoInviaRPT
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

###############
## NODO-AUTH ##
###############
locals {
  nodoInviaRPT_auth = {
    dev  = "6352c3bcc257810f183b3984"
    uat  = "63e5237639519a0f7094b47e"
    prod = "63e5d8212a92e80448d38dff"
  }
  nodoInviaCarrelloRPT_auth = {
    dev  = "6352c3bcc257810f183b3985"
    uat  = "63e5237639519a0f7094b47f"
    prod = "63e5d8212a92e80448d38e00"
  }
}


# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaRPT_auth" {
  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaRPT_auth.dev : var.env_short == "u" ? local.nodoInviaRPT_auth.uat : local.nodoInviaRPT_auth.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}


# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaCarrelloRPT_auth" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaCarrelloRPT_auth.dev : var.env_short == "u" ? local.nodoInviaCarrelloRPT_auth.uat : local.nodoInviaCarrelloRPT_auth.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaCarrelloRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}

###############
## NODO-NDP  ##
###############
locals {
  nodoInviaRPT_ndp = {
    dev  = "63bff3b0c257811280ef760a"
    uat  = "63d1612239519a10d0113a06"
    prod = "63d93febf6c0271814e8909e"
  }
  nodoInviaCarrelloRPT_ndp = {
    dev  = "63bff3b0c257811280ef760b"
    uat  = "63d1612239519a10d0113a07"
    prod = "63d93febf6c0271814e8909f"
  }
}


# nodoInviaRPT
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaRPT_ndp" {
  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaRPT_ndp.dev : var.env_short == "u" ? local.nodoInviaRPT_ndp.uat : local.nodoInviaRPT_ndp.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}


# nodoInviaCarrelloRPT
resource "azurerm_api_management_api_operation_policy" "wisp_policy_nodoInviaCarrelloRPT_ndp" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? local.nodoInviaCarrelloRPT_ndp.dev : var.env_short == "u" ? local.nodoInviaCarrelloRPT_ndp.uat : local.nodoInviaCarrelloRPT_ndp.prod

  # the enable is managed through is-wisp-converter-enabled named value
  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPa/v1/wisp-converter/nodoInviaCarrelloRPT.xml.tpl", {
    is-nodo-decoupler-enabled    = var.apim_nodo_decoupler_enable,
    wisp-soap-converter-base-url = var.apim_nodo_decoupler_enable ? "https://${local.nodo_hostname}/wisp-soap-converter" : "https://${local.nodo_hostname}/wisp-soap-converter/webservices/input/"
  })
}
