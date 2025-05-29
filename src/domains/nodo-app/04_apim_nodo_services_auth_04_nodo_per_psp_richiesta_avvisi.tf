######################################
## WS Nodo per PSP Richiesta Avvisi ##
######################################
locals {
  auth_apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/base_policy.xml")
  auth_base_policy_nodoPerPspRichiestaAvvisi_routing_file    = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/base_policy_routing.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api_auth" {
  name                = "${var.env_short}-nodo-per-psp-richiesta-avvisi-api-auth-2" #TODO [FCADAC] remove 2
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = "Nodo per PSP Richiesta Avvisi (AUTH 2.0)" #TODO [FCADAC] remove 2.0
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_nodo_per_psp_richiesta_avvisi_api_v1_auth" {
  input = sha256(local.auth_apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file)
}
module "apim_nodo_per_psp_richiesta_avvisi_api_v1_auth" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name

  product_ids = [module.apim_nodo_dei_pagamenti_product_auth.product_id]

  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth.id
  api_version    = "v1"
  service_url    = null

  description  = "Web services to support check of pending payments to PSP, defined in NodoPerPspRichiestaAvvisi.wsdl 2.0" #TODO [FCADAC] remove 2.0
  display_name = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api_auth.display_name
  path         = "nodo-auth-2/nodo-per-psp-richiesta-avvisi" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/wsdl/auth/NodoPerPspRichiestaAvvisi.wsdl")
  wsdl_selector = {
    service_name  = "RichiestaAvvisiservice"
    endpoint_name = "PPTPort"
  }

  xml_content = local.auth_apim_nodo_per_psp_richiesta_avvisi_api_v1_policy_file

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}

###### nodoChiediNumeroAvviso
resource "terraform_data" "sha256_nodoChiediNumeroAvviso_v1_policy_auth" {
  input = sha256(local.auth_base_policy_nodoPerPspRichiestaAvvisi_routing_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoChiediNumeroAvviso_v1_policy_auth" {
  api_name            = module.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68388da20a23231b903260bc" : ""

  #tfsec:ignore:GEN005
  xml_content = local.auth_base_policy_nodoPerPspRichiestaAvvisi_routing_file
}

###### nodoChiediCatalogoServizi
resource "terraform_data" "sha256_nodoChiediCatalogoServizi_v1_policy_auth" {
  input = sha256(local.auth_base_policy_nodoPerPspRichiestaAvvisi_routing_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoChiediCatalogoServizi_v1_policy_auth" {
  api_name            = module.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "637608a0c257810fc0ecfe1c" : var.env_short == "u" ? "636cb7e439519a17ec9bf98b" : "63b6e2daea7c4a25440fdaa0" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "68388da20a23231b903260bd" : ""

  #tfsec:ignore:GEN005
  xml_content = local.auth_base_policy_nodoPerPspRichiestaAvvisi_routing_file
}
