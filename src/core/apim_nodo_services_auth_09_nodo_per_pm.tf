##########################
## Nodo per PM API AUTH ## 
##########################
locals {
  apim_nodo_per_pm_api_auth = {
    display_name          = "Nodo per Payment Manager API (AUTH)"
    description           = "API to support Payment Manager"
    path                  = "nodo-auth/nodo-per-pm"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_auth" {

  name                = format("%s-nodo-per-pm-api-auth", local.project)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_nodo_per_pm_api_auth.display_name
  versioning_scheme   = "Segment"
}

#fetch technical support api product APIM product
data "azurerm_api_management_product" "technical_support_api_product" {
  product_id          = "technical_support_api"
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name
}

module "apim_nodo_per_pm_api_auth_v1" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v2.1.13"

  name                  = format("%s-nodo-per-pm-api-auth", local.project)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [data.azurerm_api_management_product.technical_support_api_product.product_id]
  subscription_required = local.apim_nodo_per_pm_api_auth.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api.id
  api_version           = "v1"
  service_url           = local.apim_nodo_per_pm_api_auth.service_url

  description  = local.apim_nodo_per_pm_api_auth.description
  display_name = local.apim_nodo_per_pm_api_auth.display_name
  path         = local.apim_nodo_per_pm_api_auth.path
  protocols    = ["https"]

  content_format = "swagger-json"
  
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_swagger_chk_pos_only.json.tpl", {
    host    = local.api_domain
    service = module.apim_nodo_dei_pagamenti_product.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}
