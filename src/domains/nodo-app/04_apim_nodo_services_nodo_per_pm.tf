# #########################
# ## WS  Nodo per PM API ##
# #########################
locals {
  closePayment_v1_policy_file   = file("./api/nodopagamenti_api/nodoPerPM/v1/base_policy_closePayment.xml")
  closePaymentV2_v1_policy_file = file("./api/nodopagamenti_api/nodoPerPM/v2/base_policy_closePaymentV2.xml")

  api_domain = format("api.%s.%s", var.apim_dns_zone_prefix, var.external_domain)
  apim_nodo_per_pm_api = {
    display_name          = "Nodo per Payment Manager API 2.0"   #TODO [FCADAC] remove 2.0
    description           = "API to support Payment Manager 2.0" #TODO [FCADAC] remove 2.0
    path                  = "nodo-2/nodo-per-pm"                 #TODO [FCADAC] remove 2
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api" {

  name                = format("%s-nodo-per-pm-api-2", local.project) #TODO [FCADAC] remove 2
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  api_management_name = data.azurerm_api_management.apim.name
  display_name        = local.apim_nodo_per_pm_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v1" {
  #source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"
  source = "./.terraform/modules/__v3__/api_management_api"

  name                  = format("%s-nodo-per-pm-api", local.project)
  api_management_name   = data.azurerm_api_management.apim.name
  resource_group_name   = data.azurerm_api_management.apim.resource_group_name
  product_ids           = [module.apim_nodo_dei_pagamenti_product.product_id]
  subscription_required = local.apim_nodo_per_pm_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api.service_url

  description  = local.apim_nodo_per_pm_api.description
  display_name = local.apim_nodo_per_pm_api.display_name
  path         = local.apim_nodo_per_pm_api.path
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger.json.tpl", {
    host    = local.api_domain
    service = module.apim_nodo_dei_pagamenti_product.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}
