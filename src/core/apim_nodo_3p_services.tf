############################
## 2. Nodo SYNC           ##
############################

# module "apim_nodo_sync_product" {
#   count  = var.env_short == "p" ? 0 : 1
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "product-nodo-sync"
#   display_name = "product-nodo-sync"
#   description  = "product-nodo-sync"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#   })
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_sync_api" {
#   count = var.env_short == "p" ? 0 : 1
#
#   name                = format("%s-nodo-sync-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = "Nodo OnCloud SYNC"
#   versioning_scheme   = "Segment"
# }
#
# module "apim_nodo_sync_api" {
#   count  = var.env_short == "p" ? 0 : 1
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-sync-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_sync_product[0].product_id]
#   subscription_required = false
#
#   version_set_id = azurerm_api_management_api_version_set.nodo_sync_api[0].id
#   api_version    = "v1"
#
#   description  = "NodeDeiPagamenti (sync)"
#   display_name = "NodeDeiPagamenti (sync)"
#   path         = "sync/api"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/sync/v1/_base_policy.xml", {
#     dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/sync/api/v1"
#   })
#
# }

############################
## 3. Nodo WFESP          ##
############################

# module "apim_nodo_wfesp_product" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "product-nodo-wfesp"
#   display_name = "product-nodo-wfesp"
#   description  = "product-nodo-wfesp"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     # address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     # address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#     address-range-from = "0.0.0.0"
#     address-range-to   = "0.0.0.0"
#   })
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_wfesp_api" {
#
#   name                = format("%s-nodo-wfesp-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = "Nodo OnCloud WFESP"
#   versioning_scheme   = "Segment"
# }
#
#
# # UAT   https://wfesp.test.pagopa.gov.it/redirect  (ex followed by /wpl02 )
# # PROD  https://wfesp.pagopa.gov.it/redirect (ex followed by /wpl05 )
#
# module "apim_nodo_wfesp_api" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-wfesp-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_wfesp_product.product_id]
#   subscription_required = false
#
#   version_set_id = azurerm_api_management_api_version_set.nodo_wfesp_api.id
#   # api_version    = "v1"
#
#   description  = "NodeDeiPagamenti (wfesp)"
#   display_name = "NodeDeiPagamenti (wfesp)"
#   path         = "redirect"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/wfesp/v1/_base_policy.xml", {
#     dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/redirect"
#     #    TODO prod is a variant in this case!
#     base-url = var.env_short == "p" ? "http://10.79.20.23:81" : "{{schema-ip-nexi}}{{base-path-wfesp}}"
#   })
#
# }

############################
## 4. Nodo Fatturazione   ##
############################

# module "apim_nodo_fatturazione_product" {
#   count  = var.env_short == "p" ? 0 : 1
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "product-nodo-fatturazione"
#   display_name = "product-nodo-fatturazione"
#   description  = "product-nodo-fatturazione"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     address-range-from = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
#     address-range-to   = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
#   })
# }
#
# resource "azurerm_api_management_api_version_set" "nodo_fatturazione_api" {
#   count = var.env_short == "p" ? 0 : 1
#
#   name                = format("%s-nodo-fatturazione-api", var.env_short)
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   display_name        = "Nodo OnCloud FATTURAZIONE"
#   versioning_scheme   = "Segment"
# }
#
# module "apim_nodo_fatturazione_api" {
#   count  = var.env_short == "p" ? 0 : 1
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-fatturazione-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_fatturazione_product[0].product_id]
#   subscription_required = false
#
#   version_set_id = azurerm_api_management_api_version_set.nodo_fatturazione_api[0].id
#   api_version    = "v1"
#
#   description  = "NodeDeiPagamenti (fatturazione)"
#   display_name = "NodeDeiPagamenti (fatturazione)"
#   path         = "fatturazione/api"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/fatturazione/v1/_base_policy.xml", {
#     dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/fatturazione/api/v1"
#   })
#
# }

############################
## 5. Nodo Web-BO         ##
############################

# module "apim_nodo_web_bo_product" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "product-nodo-web-bo"
#   display_name = "product-nodo-web-bo"
#   description  = "product-nodo-web-bo"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     address-range-from = "0.0.0.0"
#     address-range-to   = "0.0.0.0"
#   })
# }
#
# # resource "azurerm_api_management_api_version_set" "nodo_web_bo_api" {
# #   count  = var.env_short == "p" ? 0 : 1
#
# #   name                = format("%s-nodo-web-bo-api", var.env_short)
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   api_management_name = data.azurerm_api_management.apim_migrated[0].name
# #   display_name        = "Nodo OnCloud WEB-BO"
# #   versioning_scheme   = "Segment"
# # }
#
# module "apim_nodo_web_bo_api" {
#   count = var.env_short != "p" ? 1 : 0
#
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-web-bo-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_web_bo_product.product_id]
#   subscription_required = false
#
#   # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
#   # api_version    = "v1"
#
#   description  = "Nodo OnCloud WEB-BO" # "NodeDeiPagamenti (web-bo)"
#   display_name = "Nodo OnCloud WEB-BO" # "NodeDeiPagamenti (web-bo)"
#   path         = "bo-nodo"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_base_policy.xml", {
#     # dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     dns_pagopa_platform = var.env_short != "u" ? "uat.wisp2.pagopa.gov.it" : format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/bo-nodo"
#     allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
#     allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
#     allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
#     allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
#     allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
#     allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
#     allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
#     allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
#     allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
#     allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
#   })
# }
#
#
# module "apim_nodo_web_bo_api_onprem" {
#   count = var.env_short == "p" ? 1 : 0
#
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-web-bo-onprem-api", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_web_bo_product.product_id]
#   subscription_required = false
#
#   # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
#   # api_version    = "v1"
#
#   description  = "Nodo OnPrem WEB-BO" # "NodeDeiPagamenti (web-bo)"
#   display_name = "Nodo OnPrem WEB-BO" # "NodeDeiPagamenti (web-bo)"
#   path         = "bo-nodo"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-on-prem/v1/_base_policy.xml", {
#     dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/bo-nodo"
#     allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
#     allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
#     allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
#     allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
#     allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
#     allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
#     allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
#     allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
#     allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
#     allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
#   })
#
# }
#
# ############################
# ## 6. Nodo Web-BO History ##
# ############################
#
# module "apim_nodo_web_bo_product_history" {
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"
#
#   product_id   = "product-nodo-web-bo-history"
#   display_name = "product-nodo-web-bo-history"
#   description  = "product-nodo-web-bo-history"
#
#   api_management_name = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name = data.azurerm_resource_group.rg_api.name
#
#   published             = true
#   subscription_required = false
#   approval_required     = false
#
#   policy_xml = templatefile("./api_product/nodo_pagamenti_api/_base_policy.xml", {
#     address-range-from = "0.0.0.0"
#     address-range-to   = "0.0.0.0"
#   })
# }
#
# # resource "azurerm_api_management_api_version_set" "nodo_web_bo_api" {
# #   count  = var.env_short == "p" ? 0 : 1
#
# #   name                = format("%s-nodo-web-bo-api", var.env_short)
# #   resource_group_name = data.azurerm_resource_group.rg_api.name
# #   api_management_name = data.azurerm_api_management.apim_migrated[0].name
# #   display_name        = "Nodo OnCloud WEB-BO"
# #   versioning_scheme   = "Segment"
# # }
#
# module "apim_nodo_web_bo_api_history" {
#   count = var.env_short != "p" ? 1 : 0
#
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-web-bo-api-history", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_web_bo_product_history.product_id]
#   subscription_required = false
#
#   # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
#   # api_version    = "v1"
#
#   description  = "Nodo OnCloud WEB-BO history" # "NodeDeiPagamenti (web-bo)"
#   display_name = "Nodo OnCloud WEB-BO history" # "NodeDeiPagamenti (web-bo)"
#   path         = "bo-nodo-history"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history/v1/_base_policy.xml", {
#     # dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     dns_pagopa_platform = var.env_short != "u" ? "uat.wisp2.pagopa.gov.it" : format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/bo-nodo-history"
#     allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
#     allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
#     allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
#     allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
#     allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
#     allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
#     allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
#     allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
#     allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
#     allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
#   })
#
# }
#
# module "apim_nodo_web_bo_api_onprem_history" {
#   count = var.env_short == "p" ? 1 : 0
#
#   source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"
#
#   name                  = format("%s-nodo-web-bo-onprem-api-history", var.env_short)
#   api_management_name   = data.azurerm_api_management.apim_migrated[0].name
#   resource_group_name   = data.azurerm_resource_group.rg_api.name
#   product_ids           = [module.apim_nodo_web_bo_product_history.product_id]
#   subscription_required = false
#
#   # version_set_id = azurerm_api_management_api_version_set.nodo_web_bo_api[0].id
#   # api_version    = "v1"
#
#   description  = "Nodo OnPrem WEB-BO history" # "NodeDeiPagamenti (web-bo)"
#   display_name = "Nodo OnPrem WEB-BO history" # "NodeDeiPagamenti (web-bo)"
#   path         = "bo-nodo-history"
#   protocols    = ["https"]
#
#   service_url = null
#
#   content_format = "openapi"
#   content_value = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history/v1/_NodoDeiPagamenti.openapi.json.tpl", {
#     host = local.api_domain
#   })
#
#   xml_content = templatefile("./api/nodopagamenti_api/nodoServices/web-bo-history-on-prem/v1/_base_policy.xml", {
#     dns_pagopa_platform = format("api.%s.%s", var.dns_zone_prefix, var.external_domain),
#     apim_base_path      = "/bo-nodo-history"
#     allowed_ip_1        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
#     allowed_ip_2        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
#     allowed_ip_3        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[3]  # Softlab L1 Pagamenti VPN
#     allowed_ip_4        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[4]  # Softlab L1 Pagamenti VPN
#     allowed_ip_5        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[5]  # Softlab L1 Pagamenti VPN
#     allowed_ip_6        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[6]  # Softlab L1 Pagamenti VPN
#     allowed_ip_7        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[7]  # Softlab L1 Pagamenti VPN
#     allowed_ip_8        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
#     allowed_ip_9        = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
#     allowed_ip_11       = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[11] # Softlab L1 Pagamenti VPN backup
#   })
#
# }
