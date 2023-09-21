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
    base-url                  = "https://${local.fdr_hostname}/pagopa-fdr-nodo-service"
  })
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
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.fdr_hostname}/pagopa-fdr-nodo-service"
  })
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
  xml_content = templatefile("./api/fdr-fase1/nodoPerPa/v1/fdr_pagopa.xml.tpl", {
    is-fdr-nodo-pagopa-enable = var.apim_fdr_nodo_pagopa_enable
    base-url                  = "https://${local.fdr_hostname}/pagopa-fdr-nodo-service"
  })
}
