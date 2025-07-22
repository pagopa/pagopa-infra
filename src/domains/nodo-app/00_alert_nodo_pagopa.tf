locals {
  operation_psp_map_entries = [
    // nodo node-for-psp
    ["63b6e2daea7c4a25440fdaa0", "activatePaymentNotice"],
    ["63b6e2daea7c4a25440fdaa1", "sendPaymentOutcome"],
    ["63b6e2daea7c4a25440fdaa2", "verificaBollettino"],
    ["63b6e2daea7c4a25440fdaa3", "demandPaymentNotice"],
    ["63b6e2daea7c4a25440fdaa4", "nodoChiediCatalogoServiziV2"],
    ["63b6e2daea7c4a25440fdaa5", "activatePaymentNoticeV2"],
    ["63b6e2daea7c4a25440fdaa6", "sendPaymentOutcomeV2"],

    // nodo auth node-for-psp
    ["61dedafc2a92e81a0c7a58fc", "activatePaymentNotice"],
    ["61dedafc2a92e81a0c7a58fd", "sendPaymentOutcome"],
    ["61dedafc2a92e81a0c7a58fe", "verificaBollettino"],
    ["62bb23bdea7c4a0f183fc065", "demandPaymentNotice"],
    ["62bb23bdea7c4a0f183fc066", "nodoChiediCatalogoServiziV2"],
    ["63c559672a92e811a8f33a00", "activatePaymentNoticeV2"],
    ["63c559672a92e811a8f33a01", "sendPaymentOutcomeV2"],

    // nodo nodo-per-psp
    ["63b6e2da2a92e811a8f338fb", "nodoVerificaRPT"],
    ["63b6e2da2a92e811a8f338fc", "nodoAttivaRPT"],
    ["63b6e2da2a92e811a8f338fd", "nodoInviaRT"],
    ["63b6e2da2a92e811a8f338fe", "nodoChiediInformativaPA"],
    ["63b6e2da2a92e811a8f338ff", "nodoChiediTemplateInformativaPSP"],
    ["63b6e2da2a92e811a8f33900", "nodoChiediElencoQuadraturePSP"],
    ["63b6e2daea7c4a25440fda9f", "verifyPaymentNotice"],
    ["63ff4f22aca2fd18dcc4a6f8", "nodoChiediInformativaPA"],
    ["63ff4f22aca2fd18dcc4a6f9", "nodoChiediTemplateInformativaPSP"],

    // nodo auth nodo-per-psp
    ["61dedafb2a92e81a0c7a58f5", "nodoVerificaRPT"],
    ["61dedafc2a92e81a0c7a58f6", "nodoAttivaRPT"],
    ["6217ba1b2a92e81fa4f15e77", "nodoInviaRT"],
    ["6217ba1b2a92e81fa4f15e78", "nodoChiediInformativaPA"],
    ["6217ba1b2a92e81fa4f15e79", "nodoChiediTemplateInformativaPSP"],
    ["6217ba1b2a92e81fa4f15e7a", "nodoChiediElencoQuadraturePSP"],
    ["63b6e2daea7c4a25440fda9f", "verifyPaymentNotice"],

    // nodo nodo-per-psp-richiesta-avvisi
    ["63b6e2da2a92e811a8f338ed", "nodoChiediNumeroAvviso"],
    ["63b6e2da2a92e811a8f338ee", "nodoChiediCatalogoServizi"],

    // nodo auth nodo-per-psp-richiesta-avvisi
    ["6217ba1a2a92e81fa4f15e75", "nodoChiediNumeroAvviso"],
    ["6217ba1b2a92e81fa4f15e76", "nodoChiediCatalogoServizi"]

  ],
  operation_pa_map_entries = [
    // nodo auth nodo-per-pa
    ["63e5d8212a92e80448d38dfd", "nodoChiediStatoRPT"], // todo only DWISP remove it?
    ["63e5d8212a92e80448d38dfe", "nodoChiediListaPendentiRPT"], // todo only DWISP remove it?
    ["63e5d8212a92e80448d38dff", "nodoInviaRPT"], // todo only DWISP remove it?
    ["63e5d8212a92e80448d38e00", "nodoInviaCarrelloRPT"], // todo only DWISP remove it?
    ["63e5d8212a92e80448d38e02", "nodoChiediInformativaPSP"], // todo PSP?
    ["63e5d8212a92e80448d38e03", "nodoPAChiediInformativaPA"],
    ["63e5d8212a92e80448d38e05", "nodoChiediQuadraturaPA"],

    // nodo nodo-per-pa
    ["62189aea2a92e81fa4f15ec4", "nodoChiediStatoRPT"], // todo only DWISP remove it?
    ["62189aea2a92e81fa4f15ec5", "nodoChiediListaPendentiRPT"], // todo only DWISP remove it?
    ["62189aea2a92e81fa4f15ec6", "nodoInviaRPT"], // todo only DWISP remove it?
    ["62189aea2a92e81fa4f15ec7", "nodoInviaCarrelloRPT"], // todo only DWISP remove it?
    ["62189aea2a92e81fa4f15ec8", "nodoChiediCopiaRT"],
    ["62189aea2a92e81fa4f15ec9", "nodoChiediInformativaPSP"], // todo PSP?
    ["62189aea2a92e81fa4f15eca", "nodoPAChiediInformativaPA"],
    ["62189aea2a92e81fa4f15ecb", "nodoChiediQuadraturaPA"]
  ]
}

locals {
  operation_psp_map_rows = join(",\n        ", [
    for entry in local.operation_psp_map_entries :
    "\"${entry[0]}\", \"${entry[1]}\""
  ]),
  operation_pa_map_rows = join(",\n        ", [
    for entry in local.operation_pa_map_entries :
    "\"${entry[0]}\", \"${entry[1]}\""
  ])
}

resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_psp_api_availability_alert" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagoapa-psp-api-availability"
  location            = var.location

  action {
    action_group  = local.action_groups
    email_subject = "Nodo PagoPA PSP API Availability Alert"
    webhook_properties = {}
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Alert when any PagoPA Nodo PSP operation API falls below 99% availability."
  enabled        = true

  severity    = 1
  frequency   = 5
  time_window = 5
  query       = <<-EOT
    let threshold = 0.99;
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.operation_psp_map_rows}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 100));
    AzureDiagnostics
    | where TimeGenerated > ago(5m)
    | where backendUrl_s == "https://weuprod.nodo.internal.platform.pagopa.it/nodopagamenti/webservices/input"
    | where url_s matches regex "nodo(-auth){0,1}/((nodo-per-psp))" or url_s matches regex "nodo(-auth){0,1}/((node-for-psp))"
    | where operationId_s in (operationIds)
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by bin(TimeGenerated, 5m), operationId_s
    | extend availability = toreal(Success) / Total
    | where availability < threshold
    | join kind=inner (operationMap) on operationId_s
    | project TimeGenerated, apiName, operationId_s, availability, Total, Success
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "nodo_pagopa_pa_api_availability_alert" {
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-pagoapa-pa-api-availability"
  location            = var.location

  action {
    action_group  = local.action_groups
    email_subject = "Nodo PagoPA PA API Availability Alert"
    webhook_properties = {}
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Alert when any PagoPA Nodo PA operation API falls below 99% availability."
  enabled        = true

  severity    = 1
  frequency   = 5
  time_window = 5
  query       = <<-EOT
    let threshold = 0.99;
    let operationMap = datatable(operationId_s: string, apiName: string)
    [
        ${local.operation_pa_map_rows}
    ];
    let operationIds = toscalar(operationMap | summarize make_list(operationId_s, 100));
    AzureDiagnostics
    | where TimeGenerated > ago(5m)
    | where backendUrl_s == "https://weuprod.nodo.internal.platform.pagopa.it/nodopagamenti/webservices/input"
    | where url_s matches regex "nodo(-auth){0,1}/((nodo-per-pa))" or url_s matches regex "nodo(-auth){0,1}/((node-for-pa))"
    | where operationId_s in (operationIds)
    | summarize
        Total = count(),
        Success = countif(todouble(responseCode_d) < 500)
        by bin(TimeGenerated, 5m), operationId_s
    | extend availability = toreal(Success) / Total
    | where availability < threshold
    | join kind=inner (operationMap) on operationId_s
    | project TimeGenerated, apiName, operationId_s, availability, Total, Success
  EOT
  trigger {
    operator  = "GreaterThan"
    threshold = 0
  }
}
