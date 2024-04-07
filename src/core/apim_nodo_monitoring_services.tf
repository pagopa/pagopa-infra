##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_monitoring_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v7.76.0"

  product_id   = "nodo-monitoring"
  display_name = "Nodo dei Pagamenti - Monitoring"
  description  = "Product for Nodo dei Pagamenti - Monitoring"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = false
  approval_required     = false

  policy_xml = templatefile("./api_product/nodo_pagamenti_api/monitoring/base_policy.xml.tpl", {
    base-url = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"

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
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v7.76.0"

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
    host    = azurerm_api_management_custom_domain.api_custom_domain.gateway[0].host_name
    service = module.apim_nodo_dei_pagamenti_monitoring_product.product_id
  })

  xml_content = templatefile("./api/nodopagamenti_api/monitoring/v1/_base_policy.xml.tpl", {
    base-url     = var.env_short == "p" ? "https://{{ip-nodo}}" : "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}"
    allowed_ip_1 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[0]  # PagoPA on prem VPN
    allowed_ip_2 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[1]  # PagoPA on prem VPN DR
    allowed_ip_3 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[8]  # NEXI VPN
    allowed_ip_4 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[9]  # NEXI VPN
    allowed_ip_5 = var.app_gateway_allowed_paths_pagopa_onprem_only.ips[10] # NEXI VPN
  })
}
