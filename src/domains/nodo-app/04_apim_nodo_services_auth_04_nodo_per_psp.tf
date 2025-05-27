######################
## WS nodo per PSP ##
######################
locals {
  apim_nodo_per_psp_api_auth_policy_file  = file("./api/nodopagamenti_api/nodoPerPsp/v1/base_policy.xml")
  nodoInviaRT_v1_policy_file              = file("./api/nodopagamenti_api/nodoPerPsp/v1/base_policy_nodoInviaRT.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api_auth" {
  name                = "${var.env_short}-nodo-per-psp-api-auth-2" #TODO [FCADAC] remove 2
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "Nodo per PSP (AUTH 2.0)"
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_nodo_per_psp_api_v1_auth" {
  input = sha256(local.apim_nodo_per_psp_api_auth_policy_file)
}
module "apim_nodo_per_psp_api_v1_auth" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.nodo_per_psp_api_auth.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth.product_id]
  subscription_required = true

  version_set_id = azurerm_api_management_api_version_set.nodo_per_psp_api_auth.id
  api_version    = "v1"

  description  = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
  display_name = azurerm_api_management_api_version_set.nodo_per_psp_api_auth.display_name
  path         = "nodo-auth-2/nodo-per-psp" #TODO [FCADAC] remove 2
  protocols    = ["https"]

  service_url = null

  api_type = "soap"

  content_format = "wsdl"
  content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/wsdl/auth/NodoPerPsp.wsdl")
  wsdl_selector = {
    service_name  = "PagamentiTelematiciPspNodoservice"
    endpoint_name = "PPTPort"
  }

  xml_content = local.apim_nodo_per_psp_api_auth_policy_file

  depends_on = [
    module.apim_nodo_dei_pagamenti_product_auth
  ]
}

# ###### nodoInviaRT
resource "terraform_data" "sha256_nodoInviaRT_v1_policy_auth" {
  input = sha256(local.nodoInviaRT_v1_policy_file)
}
resource "azurerm_api_management_api_operation_policy" "nodoInviaRT_v1_policy_auth" {
  api_name            = module.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  # operation_id          = var.env_short == "d" ? "6352c3bcc257810f183b3985" : var.env_short == "u" ? "63e5237639519a0f7094b47f" : "63e5d8212a92e80448d38e00" #TODO [FCADAC] replace
  operation_id = var.env_short == "d" ? "6835d2860a23231b9031f98a" : ""

  #tfsec:ignore:GEN005
  xml_content = local.nodoInviaRT_v1_policy_file
}
