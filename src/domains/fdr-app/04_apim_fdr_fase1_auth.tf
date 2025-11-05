# FdR pagoPA legacy AUTH

#########
## PSP ##
#########

# nodoInviaFlussoRendicontazione DEV 6352c3bdc257810f183b399c
# nodoInviaFlussoRendicontazione UAT 636cbcb7451c1c01c4186a0b
# nodoInviaFlussoRendicontazione PRD 63b6e2da2a92e811a8f33901
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth" {

  api_name            = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_psp_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "6352c3bdc257810f183b399c" : var.env_short == "u" ? "636cbcb7451c1c01c4186a0b" : "63b6e2da2a92e811a8f33901"

  xml_content = templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

# ENG
# nodoInviaFlussoRendicontazione DEV 63fc7fce3b3a670f709d79e9
# nodoInviaFlussoRendicontazione UAT 63fcb0f539519a2c40fd431a
# nodoInviaFlussoRendicontazione PRD 63ff4f22aca2fd18dcc4a6f7
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth_eng" {

  api_name            = data.azurerm_api_management_api.apim_node_for_psp_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_node_for_psp_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_node_for_psp_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "63fc7fce3b3a670f709d79e9" : var.env_short == "u" ? "63fcb0f539519a2c40fd431a" : "63ff4f22aca2fd18dcc4a6f7"

  xml_content = templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoInviaFlussoRendicontazione_auth_eng" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPsp/v1/fdr_nodoinvia_flussorendicontazione_flow.xml", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}
#########
## PA ##
#########

# nodoChiediFlussoRendicontazione DEV 6352c3bcc257810f183b398c
# nodoChiediFlussoRendicontazione UAT 636cb7e9451c1c01c4186999
# nodoChiediFlussoRendicontazione PRD 63b6e2da2a92e811a8f338f9
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth" { #

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "6352c3bcc257810f183b398c" : var.env_short == "u" ? "636cb7e9451c1c01c4186999" : "63b6e2da2a92e811a8f338f9"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

# nodoChiediFlussoRendicontazione DEV 63fc79f63b3a670f709d79c4
# nodoChiediFlussoRendicontazione UAT 63f85b45451c1c1f24639434
# nodoChiediFlussoRendicontazione PRD 63ff73adea7c4a1860530e3b
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth_eng" { #

  api_name            = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "63fc79f63b3a670f709d79c4" : var.env_short == "u" ? "63f85b45451c1c1f24639434" : "63ff73adea7c4a1860530e3b"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediFlussoRendicontazione_auth_eng" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediFlussoRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

# nodoChiediElencoFlussiRendicontazione DEV 6352c3bcc257810f183b398b
# nodoChiediElencoFlussiRendicontazione UAT 636cb7e9451c1c01c4186998
# nodoChiediElencoFlussiRendicontazione PRD 63b6e2da2a92e811a8f338f8
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth" { #

  api_name            = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_nodo_per_pa_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "6352c3bcc257810f183b398b" : var.env_short == "u" ? "636cb7e9451c1c01c4186998" : "63b6e2da2a92e811a8f338f8"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}

# nodoChiediElencoFlussiRendicontazione DEV 63fc79f53b3a670f709d79c3
# nodoChiediElencoFlussiRendicontazione UAT 63f85b45451c1c1f24639433
# nodoChiediElencoFlussiRendicontazione PRD 63ff73adea7c4a1860530e3a
resource "azurerm_api_management_api_operation_policy" "fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth_eng" {
  api_name            = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.name
  api_management_name = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.api_management_name
  resource_group_name = data.azurerm_api_management_api.apim_node_for_pa_api_v1_auth.resource_group_name
  operation_id        = var.env_short == "d" ? "63fc79f53b3a670f709d79c3" : var.env_short == "u" ? "63f85b45451c1c1f24639433" : "63ff73adea7c4a1860530e3a"

  #tfsec:ignore:GEN005
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  })
}

# fragment sha
# https://github.com/hashicorp/terraform-provider-azurerm/issues/17016#issuecomment-1314991599
# https://learn.microsoft.com/en-us/azure/templates/microsoft.apimanagement/2022-04-01-preview/service/policyfragments?pivots=deployment-language-terraform
resource "terraform_data" "sha256_fdr_pagopa_policy_nodoChiediElencoFlussiRendicontazione_auth_eng" {
  input = sha256(templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa_nodoChiediElencoFlussiRendicontazione.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.hostname}/pagopa-fdr-nodo-service"
  }))
}
