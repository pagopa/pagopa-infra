##############
## Products ##
##############

module "apim_nodo_dei_pagamenti_product_auth_wisp" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "nodo-auth-wisp"
  display_name = "Nodo dei Pagamenti WISP (Nuova Connettività)"
  description  = "Product for Nodo dei Pagamenti WISP (Nuova Connettività)"

  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name

  published             = true
  subscription_required = true
  approval_required     = false
  subscriptions_limit   = var.nodo_auth_subscription_limit


  policy_xml = var.apim_nodo_auth_decoupler_enable ? templatefile("./api_product/nodo_pagamenti_api/wisp_decoupler/base_policy.xml.tpl", { # decoupler ON
    address-range-from       = var.env_short == "p" ? "10.1.128.0" : "0.0.0.0"
    address-range-to         = var.env_short == "p" ? "10.1.128.255" : "0.0.0.0"
    is-nodo-auth-pwd-replace = true
  }) : file("./api_product/nodo_pagamenti_api/auth/_base_policy.xml") # decoupler OFF
}




resource "azurerm_api_management_api_version_set" "pm_per_nodo_api_wisp" {

  name                = "${local.project}-pm-per-nodo-api-wisp"
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "WISP Copy - PM per Nodo API"
  versioning_scheme   = "Segment"
}

module "apim_pm_per_nodo_v2_wisp" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = "${local.project}-pm-per-nodo-api-wisp"
  api_management_name   = module.apim.name
  resource_group_name   = azurerm_resource_group.rg_api.name
  product_ids           = [module.apim_nodo_dei_pagamenti_product_auth_wisp.product_id]
  subscription_required = local.apim_pm_per_nodo_api.subscription_required_v2
  version_set_id        = azurerm_api_management_api_version_set.pm_per_nodo_api_wisp.id
  api_version           = "v2"
  service_url           = local.apim_pm_per_nodo_api.service_url

  description  = "API PM for Nodo"
  display_name = "WISP Copy - PM per Nodo API"
  path         = "payment-manager/pm-per-nodo-wisp"
  protocols    = ["https"]

  content_format = "openapi"
  content_value = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_openapi.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/payment_manager_api/pm-per-nodo/v2/_base_policy.xml.tpl", {
    host                       = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name,
    ecommerce_ingress_hostname = var.ecommerce_ingress_hostname
  })
}

resource "azurerm_api_management_api_operation_policy" "sendpaymentoutcome_v2_wisp_policy" {

  api_name            = "${local.project}-pm-per-nodo-api-wisp-v2"
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
  operation_id        = "addUserReceipt"

  #tfsec:ignore:GEN005
  xml_content = file("./api/nodopagamenti_api/wisp/wisp-sendpaymentresult-outbound.xml")
}





resource "azurerm_api_management_api_version_set" "nodo_per_pm_api_ndp_wisp" {

  name                = format("%s-nodo-per-pm-api-ndp-wisp", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  display_name        = "WISP - Nodo per Payment Manager API NDP"
  versioning_scheme   = "Segment"
}

module "apim_nodo_per_pm_api_v2_ndp_wisp" {

  source = "git::https://github.com/pagopa/azurerm.git//api_management_api?ref=v1.0.90"

  name                  = format("%s-nodo-per-pm-api-ndp", local.project)
  resource_group_name   = azurerm_resource_group.rg_api.name
  api_management_name   = module.apim.name
  subscription_required = true
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_pm_api_ndp_wisp.id
  api_version           = "v2"
  service_url           = null

  description  = "API to support Payment Manager"
  display_name = "WISP - Nodo per Payment Manager API NDP"
  path         = "nodo-ndp/nodo-per-pm-wisp"
  protocols    = ["https"]

  content_format = "swagger-json"
  content_value = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_swagger.json.tpl", {
    host = azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name
  })

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPM/v2/_base_policy.xml.tpl", {
    base-url = "https://${azurerm_api_management_custom_domain.api_custom_domain.proxy[0].host_name}/nodo"
  })
}

resource "azurerm_api_management_api_operation_policy" "closepayment_v2_wisp_policy" {
  api_name            = format("%s-nodo-per-pm-api-ndp-v2", local.project)
  resource_group_name = azurerm_resource_group.rg_api.name
  api_management_name = module.apim.name
  operation_id        = "closePayment"
  xml_content         = file("api/nodopagamenti_api/wisp/wisp-closepayment-outbound.xml")
}




locals {

  api_nodo_product_auth_wisp = [
    azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name,
    #azurerm_api_management_api.apim_node_for_io_api_v1_auth.name,
    azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name,
    #azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name,
    #azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1_auth.name
  ]
}

resource "azurerm_api_management_product_api" "apim_nodo_dei_pagamenti_product_api_auth_wisp" {
  for_each = toset(local.api_nodo_product_auth_wisp)

  api_name            = each.key
  product_id          = module.apim_nodo_dei_pagamenti_product_auth_wisp.product_id
  api_management_name = module.apim.name
  resource_group_name = azurerm_resource_group.rg_api.name
}

# decoupler algorithm fragment
resource "azapi_resource" "decoupler_algorithm_wisp" {
  count = var.env_short == "d" ? 1 : 0

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-algorithm-wisp"
  parent_id = module.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Logic about NPD decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/wisp_decoupler/decoupler-algorithm-wisp.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

# fragment for managing outbound policy if primitive is activatePayment or activateIO
resource "azapi_resource" "decoupler_activate_outbound_wisp" {
  count = var.env_short == "d" ? 1 : 0

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "decoupler-activate-outbound-wisp"
  parent_id = module.apim.id

  body = jsonencode({
    properties = {
      description = "[WISP] Outbound logic for Activate primitive of NDP decoupler"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/wisp_decoupler/decoupler-activate-outbound-wisp.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}

resource "azapi_resource" "wisp_dismantling_sendrt" {

  type      = "Microsoft.ApiManagement/service/policyFragments@2022-04-01-preview"
  name      = "wisp-dismantling-sendrt"
  parent_id = module.apim.id

  body = jsonencode({
    properties = {
      description = "Sending RT request if required for WISP dismantling"
      format      = "rawxml"
      value       = file("./api_product/nodo_pagamenti_api/wisp_decoupler/wisp-dismantling-sendrt.xml")
    }
  })

  lifecycle {
    ignore_changes = [output]
  }
}