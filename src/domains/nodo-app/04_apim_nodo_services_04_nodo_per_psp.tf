######################
## WS Nodo per PSP ##
######################
locals {
  apim_nodo_per_psp_api_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPsp/v1/base_policy.xml")
  base_policy_nodoPerPsp_routing_file  = file("./api/nodopagamenti_api/nodoPerPsp/v1/base_policy_routing.xml")

}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api" {
  name                = "${var.env_short}-nodo-per-psp-api-2" #TODO [FCADAC] remove 2
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = "Nodo per PSP 2.0" #TODO [FCADAC] remove 2.0
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_nodo_per_psp_api_v1" {
  input = sha256(local.apim_nodo_per_psp_api_v1_policy_file)
}
module "apim_nodo_per_psp_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = azurerm_api_management_api_version_set.nodo_per_psp_api.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_nodo_dei_pagamenti_product.product_id]

  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_per_psp_api.id
  api_version    = "v1"
  service_url    = null

  description  = "Web services to support PSP in payment activations, defined in NodoPerPsp.wsdl" #TODO [FCADAC] remove 2.0
  display_name = azurerm_api_management_api_version_set.nodo_per_psp_api.display_name
  path         = "nodo-2/nodo-per-psp" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/wsdl/NodoPerPsp.wsdl")
  wsdl_selector = {
    service_name  = "PagamentiTelematiciPspNodoservice"
    endpoint_name = "PPTPort"
  }

  xml_content = local.apim_nodo_per_psp_api_v1_policy_file

  api_operation_policies = [
    {
      operation_id = "nodoChiediInformativaPA",
      xml_content = local.base_policy_nodoPerPsp_routing_file
    },
    {
      operation_id = "nodoChiediTemplateInformativaPSP",
      xml_content = local.base_policy_nodoPerPsp_routing_file
    }
  ]

  depends_on = [
    module.apim_nodo_dei_pagamenti_product
  ]
}

###### nodoChiediInformativaPA
resource "terraform_data" "sha256_nodoChiediInformativaPA_v1_policy" {
  input = sha256(local.base_policy_nodoPerPsp_routing_file)
}

###### nodoChiediTemplateInformativaPSP
resource "terraform_data" "sha256_nodoChiediTemplateInformativaPSP_v1_policy" {
  input = sha256(local.base_policy_nodoPerPsp_routing_file)
}
