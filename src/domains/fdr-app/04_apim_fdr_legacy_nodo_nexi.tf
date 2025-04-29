##############
## Products ##
##############

module "apim_fdr_nodo_dei_pagamenti_legacy_product" {
  source = "./.terraform/modules/__v3__/api_management_product"

  product_id   = "fdr-legacy"
  display_name = "FdR Legacy - Nodo dei Pagamenti"
  description  = "FdR Legacy - Nodo dei Pagamenti"

  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  published             = true
  subscription_required = true
  approval_required     = false

  policy_xml = file("./api_product/fdr-legacy/_base_policy.xml")

}

locals {

  api_fdr_product = [
    azurerm_api_management_api.apim_fdr_per_pa_api_v1.name,
    azurerm_api_management_api.apim_fdr_per_psp_api_v1.name,
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
## WS FDR nodo legacy        ##
###############################
locals {
  apim_fdr_legacy_api = {
    display_name_per_pa   = "Nodo per PA Fdr Legacy WS"
    display_name_per_psp  = "Nodo per PSP Fdr Legacy WS"
    description           = "Web services to support payment activations"
    path                  = "fdr-legacy"
    subscription_required = true
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "fdr_per_pa_api" {
  name                = "${var.env_short}-fdr-per-pa-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_fdr_legacy_api.display_name_per_pa
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api_version_set" "fdr_per_psp_api" {
  name                = "${var.env_short}-fdr-per-psp-api"
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg
  display_name        = local.apim_fdr_legacy_api.display_name_per_psp
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_fdr_per_pa_api_v1" {
  name                  = "${var.env_short}-fdr-per-pa-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_fdr_legacy_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.fdr_per_pa_api.id
  version               = "v1"
  service_url           = local.apim_fdr_legacy_api.service_url
  revision              = "1"

  description  = local.apim_fdr_legacy_api.description
  display_name = local.apim_fdr_legacy_api.display_name_per_pa
  path         = local.apim_fdr_legacy_api.path
  protocols = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value = file("./api/fdr-legacy/v1/NodoPerPa.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciRPTservice"
      endpoint_name = "PagamentiTelematiciRPTPort"
    }
  }
}

resource "azurerm_api_management_api" "apim_fdr_per_psp_api_v1" {
  name                  = "${var.env_short}-fdr-per-psp-api"
  api_management_name   = local.pagopa_apim_name
  resource_group_name   = local.pagopa_apim_rg
  subscription_required = local.apim_fdr_legacy_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.fdr_per_psp_api.id
  version               = "v1"
  service_url           = local.apim_fdr_legacy_api.service_url
  revision              = "1"

  description  = local.apim_fdr_legacy_api.description
  display_name = local.apim_fdr_legacy_api.display_name_per_psp
  path         = local.apim_fdr_legacy_api.path
  protocols = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value = file("./api/fdr-legacy/v1/NodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }
}

resource "azurerm_api_management_api_policy" "apim_fdr_per_pa_policy" {
  api_name            = azurerm_api_management_api.apim_fdr_per_pa_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/fdr-legacy/v1/_base_policy.xml")
}

resource "azurerm_api_management_api_policy" "apim_fdr_per_psp_policy" {
  api_name            = azurerm_api_management_api.apim_fdr_per_psp_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = file("./api/fdr-legacy/v1/_base_policy.xml")
}
