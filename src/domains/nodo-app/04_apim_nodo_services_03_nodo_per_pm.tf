# #########################
# ## WS Nodo per PM API ##
# #########################
locals {

  apim_nodo_per_pm_api_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPM/v1/base_policy.xml")
  closePayment_v1_policy_file   = file("./api/nodopagamenti_api/nodoPerPM/v1/base_policy_closePayment.xml")
  closePaymentV2_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPM/v2/base_policy_closePaymentV2.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api" {

  name                = "${var.env_short}-nodo-per-pm-api-2" #TODO [FCADAC] remove 2
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = "Nodo per Payment Manager API 2.0"   #TODO [FCADAC] remove 2.0
  versioning_scheme   = "Segment"
}

resource "terraform_data" "sha256_apim_nodo_per_pm_api_v1" {
  input = sha256(local.apim_nodo_per_pm_api_v1_policy_file)
}
module "apim_nodo_per_pm_api_v1" {
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = azurerm_api_management_api_version_set.nodo_per_pm_api.name
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name

  product_ids           = [module.apim_nodo_dei_pagamenti_product.product_id]

  subscription_required = false

  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v1"
  service_url           = null

  description  = "API to support Payment Manager 2.0" #TODO [FCADAC] remove 2.0
  display_name = azurerm_api_management_api_version_set.nodo_per_pm_api.display_name
  path         = "nodo-2/nodo-per-pm"                 #TODO [FCADAC] remove 2
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/swagger.json.tpl", {
    host    = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
    service = module.apim_nodo_dei_pagamenti_product.product_id
  })

  xml_content = local.apim_nodo_per_pm_api_v1_policy_file
}
