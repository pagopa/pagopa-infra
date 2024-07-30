############################
## 2. Nodo SYNC DEV       ##
############################

module "apim_nodo_sync_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-sync-dev"
  display_name = "product-nodo-sync-dev"
  description  = "product-nodo-sync-dev"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

resource "azurerm_api_management_api_version_set" "nodo_sync_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-sync-dev-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "Nodo OnCloud SYNC DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_sync_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-sync-dev-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_sync_dev_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_sync_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (sync) DEV"
  display_name = "NodeDeiPagamenti (sync) DEV"
  path         = "sync-dev/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/sync-dev/api/v1"
  })

}

############################
## 3. Nodo WFESP DEV      ##
############################

module "apim_nodo_wfesp_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-wfesp-dev"
  display_name = "product-nodo-wfesp-dev"
  description  = "product-nodo-wfesp-dev"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

resource "azurerm_api_management_api_version_set" "nodo_wfesp_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-wfesp-dev-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "Nodo OnCloud WFESP DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_wfesp_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-wfesp-dev-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_wfesp_dev_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_wfesp_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (wfesp) DEV"
  display_name = "NodeDeiPagamenti (wfesp) DEV"
  path         = "wfesp-dev/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/wfesp-dev/api/v1"
  })

}

############################
## 4. Nodo Fatturazione DEV ##
############################

module "apim_nodo_fatturazione_dev_product" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-fatturazione-dev"
  display_name = "product-nodo-fatturazione-dev"
  description  = "product-nodo-fatturazione-dev"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

resource "azurerm_api_management_api_version_set" "nodo_fatturazione_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  name                = format("%s-nodo-fatturazione-dev-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = "Nodo OnCloud FATTURAZIONE DEV"
  versioning_scheme   = "Segment"
}

module "apim_nodo_fatturazione_dev_api" {
  count  = var.env_short == "d" ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-fatturazione-dev-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_fatturazione_dev_product[0].product_id]
  subscription_required = false

  version_set_id = azurerm_api_management_api_version_set.nodo_fatturazione_dev_api[0].id
  api_version    = "v1"

  description  = "NodeDeiPagamenti (fatturazione) DEV"
  display_name = "NodeDeiPagamenti (fatturazione) DEV"
  path         = "fatturazione-dev/api"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/fatturazione-dev/api/v1"
  })

}

############################
## 5. Nodo Web-BO DEV     ##
############################

module "apim_nodo_web_bo_dev_product" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-web-bo-dev"
  display_name = "product-nodo-web-bo-dev"
  description  = "product-nodo-web-bo-dev"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

# resource "azurerm_api_management_api_version_set" "nodo_web_bo_api" {
#   count  = var.env_short == "p" ? 0 : 1

#   name                = format("%s-nodo-web-bo-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = "Nodo OnCloud WEB-BO"
#   versioning_scheme   = "Segment"
# }

module "apim_nodo_web_bo_dev_api" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-web-bo-dev-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_web_bo_dev_product[0].product_id]
  subscription_required = false

  # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
  # api_version    = "v1"

  description  = "Nodo OnCloud WEB-BO DEV" # "NodeDeiPagamenti (web-bo)"
  display_name = "Nodo OnCloud WEB-BO DEV" # "NodeDeiPagamenti (web-bo)"
  path         = "web-bo-dev"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/web-bo-dev"
    allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
    allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
    allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
    allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
    allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
    allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
    allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
    allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
    allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
    allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
  })

}

############################
## 6. Nodo Web-BO History DEV ##
############################

module "apim_nodo_web_bo_dev_product_history" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "product-nodo-web-bo-history-dev"
  display_name = "product-nodo-web-bo-history-dev"
  description  = "product-nodo-web-bo-history-dev"

  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
    address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
  })
}

# resource "azurerm_api_management_api_version_set" "nodo_web_bo_api" {
#   count  = var.env_short == "p" ? 0 : 1

#   name                = format("%s-nodo-web-bo-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = "Nodo OnCloud WEB-BO"
#   versioning_scheme   = "Segment"
# }

module "apim_nodo_web_bo_dev_api_history" {
  count = var.env_short == "d" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-web-bo-dev-api-history", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_web_bo_dev_product_history[0].product_id]
  subscription_required = false

  # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
  # api_version    = "v1"

  description  = "Nodo OnCloud WEB-BO history DEV" # "NodeDeiPagamenti (web-bo)"
  display_name = "Nodo OnCloud WEB-BO history DEV" # "NodeDeiPagamenti (web-bo)"
  path         = "web-bo-history-dev"
  protocols    = ["https"]

  service_url = null

  content_format = "openapi"
  content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history/v1/_NodoDeiPagamenti.openapi.json.tpl", {
    host = local.api_domain
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history/v1/_base_policy_dev.xml", {
    dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
    apim_base_path      = "/web-bo-history-dev"
    allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
    allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
    allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
    allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
    allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
    allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
    allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
    allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
    allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
    allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # NEXI VPN
  })

}
