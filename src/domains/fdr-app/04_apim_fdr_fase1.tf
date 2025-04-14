# FdR pagoPA legacy

resource "azurerm_api_management_named_value" "ftp_organization" {
  name                = "ftp-organization"
  api_management_name = data.azurerm_api_management.apim.name
  resource_group_name = data.azurerm_api_management.apim.resource_group_name
  display_name        = "ftp-organization"
  value               = var.ftp_organization
}


#########
## PSP ##
#########

# nodoInviaFlussoRendicontazione DEV 61e9630cb78e981290d7c74c
# nodoInviaFlussoRendicontazione UAT 61e96321e0f4ba04a49d1280
# nodoInviaFlussoRendicontazione PRD 61e9633eea7c4a07cc7d4811
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoInviaFlussoRendicontazione" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? "61e9630cb78e981290d7c74c" : var.env_short == "u" ? "61e96321e0f4ba04a49d1280" : "61e9633eea7c4a07cc7d4811"

  xml_content = templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoInviaFlussoRendicontazione" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

#########
## PA ##
#########

# nodoChiediFlussoRendicontazione DEV 6218976195aa0303ccfcf902
# nodoChiediFlussoRendicontazione UAT 61e96321e0f4ba04a49d1286
# nodoChiediFlussoRendicontazione PRD 61e9633dea7c4a07cc7d480e

resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediFlussoRendicontazione" { #

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf902" : var.env_short == "u" ? "61e96321e0f4ba04a49d1286" : "61e9633dea7c4a07cc7d480e"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediFlussoRendicontazione" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

# nodoChiediElencoFlussiRendicontazione DEV 6218976195aa0303ccfcf901
# nodoChiediElencoFlussiRendicontazione UAT 61e96321e0f4ba04a49d1285
# nodoChiediElencoFlussiRendicontazione PRD 61e9633dea7c4a07cc7d480d
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione" { #

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1.resource_group_name
  operation_id        = var.env_short == "d" ? "6218976195aa0303ccfcf901" : var.env_short == "u" ? "61e96321e0f4ba04a49d1285" : "61e9633dea7c4a07cc7d480d"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}
