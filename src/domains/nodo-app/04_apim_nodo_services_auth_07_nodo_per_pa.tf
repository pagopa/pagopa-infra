######################
## WS nodo per PA ##
######################
locals {
  apim_nodo_per_pa_api_auth_policy_file = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy.xml")
  nodoInviaRPT_v1_policy_file           = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy_nodoInviaRPT.xml")
  nodoInviaCarrelloRPT_v1_policy_file   = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy_nodoInviaCarrelloRPT.xml")
  nodoChiediCopiaRT_v1_policy_file      = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy_nodoChiediCopiaRT.xml")
  base_policy_nodoPerPa_routing_file    = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy_routing.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api_auth" {
  name                = "${var.env_short}-nodo-per-pa-api-auth-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Nodo per PA (AUTH 2.0)"
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_nodo_per_pa_api_v1_auth" {
  input = sha256(local.apim_nodo_per_pa_api_auth_policy_file)
}
module "apim_nodo_per_pa_api_v1_auth" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.nodo_per_pa_api_auth.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.nodo_per_pa_api_auth.id
  api_version    = "v1"

  description  = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
  display_name = azurerm_api_management_api_version_set.nodo_per_pa_api_auth.display_name
  path         = "nodo-auth-2/nodo-per-pa"
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/wsdl/auth/NodoPerPa.wsdl")
  wsdl_selector = {
    service_name  = "PagamentiTelematiciRPTservice"
    endpoint_name = "PagamentiTelematiciRPTPort"
  }

  xml_content = local.apim_nodo_per_pa_api_auth_policy_file

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}

###### nodoInviaRPT
resource "terraform_data" "sha256_nodoInviaRPT_v1_policy_auth" {
  input = sha256(local.nodoInviaRPT_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoInviaRPT_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "6352c3bcc257810f183b3984" : var.env_short == "u" ? "63e5237639519a0f7094b47e" : "63e5d8212a92e80448d38dff" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68357e4c0a23231b9031e44a" : ""

  #tfsec:ignore:GEN005
  xml_content = local.nodoInviaRPT_v1_policy_file
}

###### nodoInviaCarrelloRPT
resource "terraform_data" "sha256_nodoInviaCarrelloRPT_v1_policy_auth" {
  input = sha256(local.nodoInviaCarrelloRPT_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoInviaCarrelloRPT_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "6352c3bcc257810f183b3985" : var.env_short == "u" ? "63e5237639519a0f7094b47f" : "63e5d8212a92e80448d38e00" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68357e4c0a23231b9031e44b" : ""

  #tfsec:ignore:GEN005
  xml_content = local.nodoInviaCarrelloRPT_v1_policy_file
}

###### nodoChiediCopiaRT
resource "terraform_data" "sha256_nodoChiediCopiaRT_v1_policy_auth" {
  input = sha256(local.nodoChiediCopiaRT_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoChiediCopiaRT_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "6352c3bcc257810f183b3985" : var.env_short == "u" ? "63e5237639519a0f7094b47f" : "63e5d8212a92e80448d38e00" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68357e4c0a23231b9031e44c" : ""

  #tfsec:ignore:GEN005
  xml_content = local.nodoChiediCopiaRT_v1_policy_file
}

###### nodoChiediInformativaPSP
resource "terraform_data" "sha256_nodoChiediInformativaPSP_v1_policy_auth" {
  input = sha256(local.base_policy_nodoPerPa_routing_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoChiediInformativaPSP_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68357e4c0a23231b9031e44d" : ""

  #tfsec:ignore:GEN005
  xml_content = local.base_policy_nodoPerPa_routing_file
}

###### nodoPAChiediInformativaPA
resource "terraform_data" "sha256_nodoPAChiediInformativaPA_v1_policy_auth" {
  input = sha256(local.base_policy_nodoPerPa_routing_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoPAChiediInformativaPA_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68357e4c0a23231b9031e44e" : ""

  #tfsec:ignore:GEN005
  xml_content = local.base_policy_nodoPerPa_routing_file
}
