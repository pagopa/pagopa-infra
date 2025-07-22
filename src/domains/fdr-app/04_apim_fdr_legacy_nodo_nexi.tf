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

  depends_on = [
    azurerm_api_management_api.apim_fdr_per_pa_api_v1,
    azurerm_api_management_api.apim_fdr_per_psp_api_v1
  ]

}


###############################
## WS FDR nodo legacy        ##
###############################
locals {
  apim_fdr_legacy_api = {
    display_name_per_pa   = "Nodo per PA Fdr Legacy WS"
    display_name_per_psp  = "Nodo per PSP Fdr Legacy WS"
    description           = "Web services to support payment activations"
    path                  = "fdr-legacy/nodo-per-pa"
    path_psp              = "fdr-legacy/nodo-per-psp"
    subscription_required = true
    service_url           = null
  }
}

# Apim version set for FDR SOAP PA and PSP legacy

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

# FDR SOAP PA and PSP legacy
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
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/fdr-legacy/v1/NodoPerPa.wsdl")
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
  path         = local.apim_fdr_legacy_api.path_psp
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/fdr-legacy/v1/NodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }
}

# policy to go to NDP-NEXI
resource "azurerm_api_management_api_policy" "apim_fdr_per_pa_policy" {
  api_name            = azurerm_api_management_api.apim_fdr_per_pa_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = templatefile("./api/fdr-legacy/v1/_base_policy.xml", {
    alternative-nodo-backend = var.env_short == "p" ? "https://10.79.20.34" : (var.env_short == "u" ? "http://10.70.74.200/nodo-uat" : "http://10.70.66.200/nodo-sit")
  })
}

resource "azurerm_api_management_api_policy" "apim_fdr_per_psp_policy" {
  api_name            = azurerm_api_management_api.apim_fdr_per_psp_api_v1.name
  api_management_name = local.pagopa_apim_name
  resource_group_name = local.pagopa_apim_rg

  xml_content = templatefile("./api/fdr-legacy/v1/_base_policy.xml", {
    alternative-nodo-backend = var.env_short == "p" ? "https://10.79.20.34" : (var.env_short == "u" ? "http://10.70.74.200/nodo-uat" : "http://10.70.66.200/nodo-sit")
  })
}
