##############
## Products ##
##############

module "apim_fdr_nodo_dei_pagamenti_legacy_product" {
  source = "git::https://github.com/pagopa/azurerm.git//api_management_product?ref=v1.0.90"

  product_id   = "fdr-legacy"
  display_name = "FdR Legacy - Nodo dei Pagamenti"
  description  = "FdR Legacy - Nodo dei Pagamenti"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/nodoPerPa/_base_policy.xml")

}

locals {

  api_fdr_product = [
    azurerm_api_management_api.apim_fdr_per_pa_api_v1.name,
  ]

}

resource "azurerm_api_management_product_api" "apim_fdr_nodo_dei_pagamenti_product_api" {
  for_each = toset(local.api_fdr_product)

  api_name            = each.key
  product_id          = module.apim_fdr_nodo_dei_pagamenti_legacy_product.product_id
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

}


###############################
## WS FDR nodo legacy per PA ##
###############################
locals {
  apim_fdr_per_pa_api = {
    display_name          = "Nodo per PA Fdr Legacy WS"
    description           = "Web services to support PA in payment activations, defined in nodoPerPa.wsdl"
    path                  = "fdr-legacy/nodo-per-pa"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "fdr_per_pa_api" {
  name                = "${var.env_short}-fdr-per-pa-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_fdr_per_pa_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_fdr_per_pa_api_v1" {
  name                  = "${var.env_short}-fdr-per-pa-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_fdr_per_pa_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.fdr_per_pa_api.id
  version               = "v1"
  service_url           = local.apim_fdr_per_pa_api.service_url
  revision              = "1"

  description  = local.apim_fdr_per_pa_api.description
  display_name = local.apim_fdr_per_pa_api.display_name
  path         = local.apim_fdr_per_pa_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodoPerPa/v1/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_fdr_per_pa_policy" {
  api_name            = resource.azurerm_api_management_api.apim_fdr_per_pa_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = templatefile("./api/nodoPerPa/v1/_base_policy.xml.tpl", {
    base-url = "http://{{aks-lb-nexi}}{{base-path-nodo-oncloud}}/webservices/input"
  })
}
