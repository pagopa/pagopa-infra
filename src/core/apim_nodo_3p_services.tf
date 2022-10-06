############################
## Nodo PPT LMI        ##
############################


module "apim_nodo_ppt_lmi_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-ppt-lmi"
  display_name = "product-nodo-ppt-lmi"
  description  = "product-nodo-ppt-lmi"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_ppt_lmi_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-ppt-lmi-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud PPT LMI"
  versioning_scheme   = "Segment"
}

module "apim_nodo_ppt_lmi_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-ppt-lmi-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_ppt_lmi_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_ppt_lmi_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (ppt-lmi)"
  display_name = "NodeDeiPagamenti (ppt-lmi)"
  path         = "ppt-lmi/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/ppt-lmi/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/ppt-lmi/api/v1"
  })

}


############################
## Nodo SYNC              ##
############################

module "apim_nodo_sync_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-sync"
  display_name = "product-nodo-sync"
  description  = "product-nodo-sync"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_sync_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-sync-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud SYNC"
  versioning_scheme   = "Segment"
}

module "apim_nodo_sync_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-sync-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_sync_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_sync_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (sync)"
  display_name = "NodeDeiPagamenti (sync)"
  path         = "sync/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/sync/api/v1"
  })

}

############################
## Nodo WFESP            ##
############################

module "apim_nodo_wfesp_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-wfesp"
  display_name = "product-nodo-wfesp"
  description  = "product-nodo-wfesp"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_wfesp_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-wfesp-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud WFESP"
  versioning_scheme   = "Segment"
}

module "apim_nodo_wfesp_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-wfesp-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_wfesp_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_wfesp_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (wfesp)"
  display_name = "NodeDeiPagamenti (wfesp)"
  path         = "wfesp/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/wfesp/api/v1"
  })

}

############################
## Nodo Fatturazione      ##
############################

module "apim_nodo_fatturazione_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-fatturazione"
  display_name = "product-nodo-fatturazione"
  description  = "product-nodo-fatturazione"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

resource "azurerm_api_management_api_version_set" "nodo_fatturazione_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-fatturazione-api", var.env_short)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "Nodo OnCloud FATTURAZIONE"
  versioning_scheme   = "Segment"
}

module "apim_nodo_fatturazione_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-fatturazione-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_fatturazione_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_fatturazione_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (fatturazione)"
  display_name = "NodeDeiPagamenti (fatturazione)"
  path         = "fatturazione/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/fatturazione/api/v1"
  })

}

############################
## Nodo Web-BO            ##
############################

module "apim_nodo_web_bo_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-web-bo"
  display_name = "product-nodo-web-bo"
  description  = "product-nodo-web-bo"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = file("./api_product/nodo_pagamenti_api/_base_policy.xml")
}

# resource "azurerm_api_management_api_version_set" "nodo_web_bo_api" {
#   count = var.env_short == "d" ? 1 : 0

#   name                = format("%s-nodo-web-bo-api", var.env_short)
#   resource_group_name = azurerm_resource_group.rg_api.name
#   api_management_name = module.apim.name
#   display_name        = "Nodo OnCloud WEB-BO"
#   versioning_scheme   = "Segment"
# }

module "apim_nodo_web_bo_api" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-web-bo-api", var.env_short)
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_web_bo_product.product_id]
  subscription_required = false

  # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
  # api_version    = "v1"

  description  = "Nodo OnCloud WEB-BO" # "NodeDeiPagamenti (web-bo)"
  display_name = "Nodo OnCloud WEB-BO" # "NodeDeiPagamenti (web-bo)"
  path         = "web-bo"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_base_policy.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/web-bo"
    allowed_ip          = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]
  })

}
