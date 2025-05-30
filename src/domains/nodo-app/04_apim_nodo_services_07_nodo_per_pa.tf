####################
## WS nodo per PA ##
####################
locals {
  apim_nodo_per_pa_api_policy_file = file("./api/nodopagamenti_api/nodoPerPa/v1/base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_per_pa_api" {
  name                = "${var.env_short}-nodo-per-pa-api-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Nodo per PA 2.0"
  versioning_scheme   = "Segment"
}


resource "terraform_data" "sha256_apim_nodo_per_pa_api_v1" {
  input = sha256(local.apim_nodo_per_pa_api_policy_file)
}

module "apim_nodo_per_pa_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.nodo_per_pa_api.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.nodo_per_pa_api.id
  api_version    = "v1"

  description  = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
  display_name = azurerm_api_management_api_version_set.nodo_per_pa_api.display_name
  path         = "nodo-2/nodo-per-pa"
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodoPerPa/v1/wsdl/NodoPerPa.wsdl")
  wsdl_selector = {
    service_name  = "PagamentiTelematiciRPTservice"
    endpoint_name = "PagamentiTelematiciRPTPort"
  }

  xml_content = local.apim_nodo_per_pa_api_policy_file

  api_operation_policies = [
    {
      operation_id = "nodoPAChiediInformativaPA"
      xml_content = local.base_policy_nodoPerPa_routing_file
    },
    {
      operation_id = "nodoChiediInformativaPSP"
      xml_content = local.base_policy_nodoPerPa_routing_file
    },
    {
      operation_id = "nodoChiediListaPendentiRPT"
      xml_content = local.nodoChiediListaPendentiRPT_v1_policy_file
    },
    {
      operation_id = "nodoChiediStatoRPT"
      xml_content = local.nodoChiediStatoRPT_v1_policy_file
    },
    {
      operation_id = "nodoChiediCopiaRT"
      xml_content = local.nodoChiediCopiaRT_v1_policy_file
    },
    {
      operation_id = "nodoInviaCarrelloRPT"
      xml_content = local.nodoInviaCarrelloRPT_v1_policy_file
    },
    {
      operation_id = "nodoInviaRPT"
      xml_content = local.nodoInviaRPT_v1_policy_file
    },

  ]

  depends_on = [
    module.apim_nodo_dei_pagamenti_product
  ]
}

###### nodoInviaRPT
resource "terraform_data" "sha256_nodoInviaRPT_v1_policy" {
  input = sha256(local.nodoInviaRPT_v1_policy_file)
}

###### nodoInviaCarrelloRPT
resource "terraform_data" "sha256_nodoInviaCarrelloRPT_v1_policy" {
  input = sha256(local.nodoInviaCarrelloRPT_v1_policy_file)
}

###### nodoChiediCopiaRT
resource "terraform_data" "sha256_nodoChiediCopiaRT_v1_policy" {
  input = sha256(local.nodoChiediCopiaRT_v1_policy_file)
}

###### nodoChiediStatoRPT
resource "terraform_data" "sha256_nodoChiediStatoRPT_v1_policy" {
  input = sha256(local.nodoChiediStatoRPT_v1_policy_file)
}

###### nodoChiediInformativaPSP
resource "terraform_data" "sha256_nodoChiediInformativaPSP_v1_policy" {
  input = sha256(local.base_policy_nodoPerPa_routing_file)
}

###### nodoPAChiediInformativaPA
resource "terraform_data" "sha256_nodoPAChiediInformativaPA_v1_policy" {
  input = sha256(local.base_policy_nodoPerPa_routing_file)
}
