##############
## Products ##
##############

module "apim_fdr_product" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_product?ref=v6.3.0"

  product_id   = "fdr"
  display_name = "FDR - Flussi di rendicontazione"
  description  = "Manage FDR ( aka \"Flussi di Rendicontazione\" ) exchanged between PSP and EC"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = true
  subscriptions_limit   = 1000

  policy_xml = file("./api_product/fdr-service/_base_policy.xml")
}

#################
##    API fdr  ##
#################
locals {
  apim_fdr_service_api = {
    display_name          = "FDR - Flussi di rendicontazione"
    description           = "FDR - Flussi di rendicontazione"
    path                  = "fdr/service"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "api_fdr_api" {

  name                = "${var.env_short}-fdr-service-api"
  resource_group_name = local.pagopa_apim_rg
  api_management_name = local.pagopa_apim_name
  display_name        = local.apim_fdr_service_api.display_name
  versioning_scheme   = "Segment"
}


module "apim_api_fdr_api_v1" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//api_management_api?ref=v6.3.0"

  name                  = "${local.project}-fdr-service-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  product_ids           = [module.apim_fdr_product.product_id]
  subscription_required = local.apim_fdr_service_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.api_fdr_api.id
  api_version           = "v1"

  description  = local.apim_fdr_service_api.description
  display_name = local.apim_fdr_service_api.display_name
  path         = local.apim_fdr_service_api.path
  protocols    = ["https"]
  service_url  = local.apim_fdr_service_api.service_url

  content_format = "openapi"
  content_value = templatefile("./api/fdr-service/v1/_openapi.json.tpl", {
    host    = local.apim_hostname
    service = module.apim_fdr_product.product_id
  })

  xml_content = templatefile("./api/fdr-service/v1/_base_policy.xml.tpl", {
    hostname = local.hostname
  })
}

# nodoChiediElencoFlussiRendicontazione DEV 6218976195aa0303ccfcf901
# nodoChiediElencoFlussiRendicontazione UAT 61e96321e0f4ba04a49d1285
# nodoChiediElencoFlussiRendicontazione PRD 61e9633dea7c4a07cc7d480d
resource "azurerm_api_management_api_operation_policy" "fdr_pagpo_policy_nodoChiediElencoFlussiRendicontazione" { # 

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf901" : var.env_short == "u" ? "61e96321e0f4ba04a49d1285" : "61e9633dea7c4a07cc7d480d"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodoPerPa/v1/fdr_pagopa.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.apim_nodo_per_pa_api.fdr_hostname}/pagopa-fdr-nodo-service"
  })
}

# Fdr pagoPA legacy 
# nodoChiediFlussoRendicontazione DEV 6218976195aa0303ccfcf902
# nodoChiediFlussoRendicontazione UAT 61e96321e0f4ba04a49d1286
# nodoChiediFlussoRendicontazione PRD 61e9633dea7c4a07cc7d480e
resource "azurerm_api_management_api_operation_policy" "fdr_pagpo_policy_nodoChiediFlussoRendicontazione" { # 

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf902" : var.env_short == "u" ? "61e96321e0f4ba04a49d1286" : "61e9633dea7c4a07cc7d480e"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/nodoPerPa/v1/fdr_pagopa.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.apim_nodo_per_pa_api.fdr_hostname}/pagopa-fdr-nodo-service"
  })
}

resource "azurerm_api_management_api_operation_policy" "fdr_policy" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  operation_id        = var.env_short == "d" ? "61e9630cb78e981290d7c74c" : var.env_short == "u" ? "61e96321e0f4ba04a49d1280" : "61e9633eea7c4a07cc7d4811"

  xml_content = templatefile("./api/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.apim_nodo_per_pa_api.fdr_hostname}/pagopa-fdr-nodo-service"

  })
}

resource "azurerm_api_management_named_value" "fdrcontainername" {
  name                = "fdrcontainername"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrcontainername"
  value               = data.azurerm_storage_container.fdr_rend_flow.name
}

resource "azurerm_api_management_named_value" "fdrsaname" {
  name                = "fdrsaname"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_resource_group.rg_api.name
  display_name        = "fdrsaname"
  value               = data.azurerm_storage_account.fdr_flows_sa.name
}