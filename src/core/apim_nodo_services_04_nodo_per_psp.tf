######################
## WS nodo per psp ##
######################
locals {
  apim_nodo_per_psp_api = {
    display_name          = "Nodo per PSP WS"
    description           = "Web services to support PSP in payment activations, defined in nodoPerPsp.wsdl"
    path                  = "nodo/nodo-per-psp"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_api" {
  name                = format("%s-nodo-per-psp-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_nodo_per_psp_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_api_v1" {
  name                  = format("%s-nodo-per-psp-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_api.description
  display_name = local.apim_nodo_per_psp_api.display_name
  path         = local.apim_nodo_per_psp_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPsp/v1/nodoPerPsp.wsdl")
    wsdl_selector {
      service_name  = "PagamentiTelematiciPspNodoservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_policy" {
  api_name            = azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPsp/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })
}



######################################
## WS nodo per psp richiesta avvisi ##
######################################
locals {
  apim_nodo_per_psp_richiesta_avvisi_api = {
    display_name          = "Nodo per PSP Richiesta Avvisi WS"
    description           = "Web services to support check of pending payments to PSP, defined in nodoPerPspRichiestaAvvisi.wsdl"
    path                  = "nodo/nodo-per-psp-richiesta-avvisi"
    subscription_required = var.nodo_pagamenti_subkey_required
    service_url           = null
  }
}

resource "azurerm_api_management_api_version_set" "nodo_per_psp_richiesta_avvisi_api" {
  name                = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
  resource_group_name = data.azurerm_resource_group.rg_api.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  display_name        = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
  versioning_scheme   = "Segment"
}

resource "azurerm_api_management_api" "apim_nodo_per_psp_richiesta_avvisi_api_v1" {
  name                  = format("%s-nodo-per-psp-richiesta-avvisi-api", var.env_short)
  api_management_name   = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name   = data.azurerm_resource_group.rg_api.name
  subscription_required = local.apim_nodo_per_psp_richiesta_avvisi_api.subscription_required
  version_set_id        = azurerm_api_management_api_version_set.nodo_per_psp_richiesta_avvisi_api.id
  version               = "v1"
  service_url           = local.apim_nodo_per_psp_richiesta_avvisi_api.service_url
  revision              = "1"

  description  = local.apim_nodo_per_psp_richiesta_avvisi_api.description
  display_name = local.apim_nodo_per_psp_richiesta_avvisi_api.display_name
  path         = local.apim_nodo_per_psp_richiesta_avvisi_api.path
  protocols    = ["https"]

  soap_pass_through = true

  import {
    content_format = "wsdl"
    content_value  = file("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/nodoPerPspRichiestaAvvisi.wsdl")
    wsdl_selector {
      service_name  = "RichiestaAvvisiservice"
      endpoint_name = "PPTPort"
    }
  }

}

resource "azurerm_api_management_api_policy" "apim_nodo_per_psp_richiesta_avvisi_policy" {
  api_name            = azurerm_api_management_api.apim_nodo_per_psp_richiesta_avvisi_api_v1.name
  api_management_name = data.azurerm_api_management.apim_migrated[0].name
  resource_group_name = data.azurerm_resource_group.rg_api.name

  xml_content = templatefile("./api/nodopagamenti_api/nodoPerPspRichiestaAvvisi/v1/_base_policy.xml.tpl", {
    is-nodo-decoupler-enabled = var.apim_nodo_decoupler_enable
  })

}
