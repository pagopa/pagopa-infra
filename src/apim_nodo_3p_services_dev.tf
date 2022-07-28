############################
## Nodo PPT LMI DEV      ##
############################


module "apim_nodo_ppt_lmi_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-nodo-ppt-lmi-dev"
  display_name = "product-nodo-ppt-lmi-dev"
  description  = "product-nodo-ppt-lmi-dev"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_ppt_lmi_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-ppt-lmi-dev-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud PPT LMI DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_ppt_lmi_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-nodo-ppt-lmi-dev-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_ppt_lmi_dev_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_ppt_lmi_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (ppt-lmi-dev)"
  display_name = "NodeDeiPagamenti (ppt-lmi-dev)"
  path         = "ppt-lmi-dev/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/ppt-lmi-dev/api/v1"
  })

}


############################
## Nodo SYNC DEV          ##
############################

module "apim_nodo_sync_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.16"

  product_id   = "product-nodo-sync-dev"
  display_name = "product-nodo-sync-dev"
  description  = "product-nodo-sync-dev"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_sync_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-sync-dev-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud SYNC DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_sync_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.16"

  name                  = format("%s-nodo-sync-dev-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_sync_dev_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_sync_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (sync) DEV"
  display_name = "NodeDeiPagamenti (sync) DEV "
  path         = "sync/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/sync/api/v1"
  })

}
