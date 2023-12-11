##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_monitoring_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo-monitoring"
  display_name = "Nodo dei Pagamenti - Monitoring"
  description  = "Product for Nodo dei Pagamenti - Monitoring"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = var.apim_nodo_decoupler_enable ? templatefile("./api_product/nodo_pagamenti_api/decoupler/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short != "d" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short != "d" ? "10.1.128.255" : "0.0.0.0"
    base-url                 = azurerm_api_management_named_value.default_nodo_backend.value
    base-node-id             = azurerm_api_management_named_value.default_nodo_id.value
    is-nodo-auth-pwd-replace = false
    }) : templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", { # decoupler OFF
    address-range-from = var.env_short != "d" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short != "d" ? "10.1.128.255" : "0.0.0.0"
  })
}

######################
## NODO monitoring  ##
######################
locals {
  apim_nodo_monitoring_api = {
    display_name          = "Nodo monitoring"
    description           = "Nodo monitoring"
    path                  = "nodo-monitoring/monitoring"
    subscription_required = false
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_monitoring_api" {
  name                = format("%s-nodo-monitoring-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = local.apim_nodo_monitoring_api.display_name
  versioning_scheme   = "Segment"
}

module "apim_nodo_monitoring_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-monitoring-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_dei_pagamenti_monitoring_product.product_id]
  subscription_required = local.apim_nodo_monitoring_api.subscription_required

  version_set_id = azurerm_api_management_api_version_set.nodo_monitoring_api.id
  api_version    = "v1"

  description  = local.apim_nodo_monitoring_api.description
  display_name = local.apim_nodo_monitoring_api.display_name
  path         = local.apim_nodo_monitoring_api.path
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/monitoring/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host    = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
    service = module.apim_nodo_dei_pagamenti_monitoring_product.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/monitoring/v1/_base_policy.xml.tpl", {
    base-url                  = azurerm_api_management_named_value.default_nodo_backend.value
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}
