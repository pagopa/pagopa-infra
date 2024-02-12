locals {
  api_nodo_auth_alerts = var.env_short != "p" ? [] : [
    // general
    # {
    #   operationId_s : ".*",
    #   primitiva : "general",
    #   sub_service : ".*",
    # },
    // Node for IO WS (AUTH)
    {
      operationId_s : "63b6e2da2a92e811a8f338ec",
      primitiva : "activateIOPayment",
      sub_service : "node-for-io",
    },
    // Node for PA WS (AUTH)
    {
      operationId_s : "63ff73adea7c4a1860530e3a",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "node-for-pa",
      response_time : 20000
    },
    {
      operationId_s : "63ff73adea7c4a1860530e3b",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "node-for-pa",
    },
    //  Nodo per PA WS (AUTH)
    {
      operationId_s : "63b6e2da2a92e811a8f338f8",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "nodo-per-pa",
      response_time : 20000
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338f9",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38dfd",
      primitiva : "nodoChiediStatoRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38dfe",
      primitiva : "nodoChiediListaPendentiRPT",
      sub_service : "nodo-per-pa",
      response_time : 20000,
    },
    {
      operationId_s : "63e5d8212a92e80448d38dff",
      primitiva : "nodoInviaRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38e00",
      primitiva : "nodoInviaCarrelloRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38e02",
      primitiva : "nodoChiediInformativaPSP",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38e03",
      primitiva : "nodoPAChiediInformativaPA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38e04",
      primitiva : "nodoChiediElencoQuadraturePA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "63e5d8212a92e80448d38e05",
      primitiva : "nodoChiediQuadraturaPA",
      sub_service : "nodo-per-pa",
    },
    // Nodo per PSP WS (AUTH)
    {
      operationId_s : "63b6e2da2a92e811a8f338fb",
      primitiva : "nodoVerificaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338fc",
      primitiva : "nodoAttivaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338fd",
      primitiva : "nodoInviaRT",
      sub_service : "nodo-per-psp",
      response_time : 20000
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338fe",
      primitiva : "nodoChiediInformativaPA",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338ff",
      primitiva : "nodoChiediTemplateInformativaPSP",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "63b6e2da2a92e811a8f33900",
      primitiva : "nodoChiediElencoQuadraturePSP",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "63b6e2da2a92e811a8f33901",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "nodo-per-psp",
      response_time : 20000
    },
    // Node for PSP WS (NM3) (AUTH)
    {
      operationId_s : "63b6e2daea7c4a25440fda9f",
      primitiva : "verifyPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa0",
      primitiva : "activatePaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa1",
      primitiva : "sendPaymentOutcome",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa2",
      primitiva : "verificaBollettino",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa3",
      primitiva : "demandPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa4",
      primitiva : "nodoChiediCatalogoServiziV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa5",
      primitiva : "activatePaymentNoticeV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63b6e2daea7c4a25440fdaa6",
      primitiva : "sendPaymentOutcomeV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63ff4f22aca2fd18dcc4a6f7",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "node-for-psp",
      response_time : 20000
    },
    {
      operationId_s : "63ff4f22aca2fd18dcc4a6f8",
      primitiva : "nodoChiediInformativaPA",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63ff4f22aca2fd18dcc4a6f9",
      primitiva : "nodoChiediTemplateInformativaPSP",
      sub_service : "node-for-psp",
    },
    // Nodo per PSP Richiesta Avvisi WS (AUTH)
    {
      operationId_s : "63b6e2da2a92e811a8f338ed",
      primitiva : "nodoChiediNumeroAvviso",
      sub_service : "nodo-per-psp-richiesta-avvisi",
      response_time : 20000
    },
    {
      operationId_s : "63b6e2da2a92e811a8f338ee",
      primitiva : "nodoChiediCatalogoServizi",
      sub_service : "nodo-per-psp-richiesta-avvisi",
    },
  ]

  api_nodo_alerts = var.env_short != "p" ? [] : [
    // general
    # {
    #   operationId_s : ".*",
    #   primitiva : "general",
    #   sub_service : ".*",
    # },
    // node-for-io
    {
      operationId_s : "61dedb1eea7c4a07cc7d47b8",
      primitiva : "activateIOPaymentReq",
      sub_service : "node-for-io",
    },
    // node-for-psp
    {
      operationId_s : "61dedafc2a92e81a0c7a58fb",
      primitiva : "verifyPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fc",
      primitiva : "activatePaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fd",
      primitiva : "sendPaymentOutcome",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58fe",
      primitiva : "verificaBollettino",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "62bb23bdea7c4a0f183fc065",
      primitiva : "demandPaymentNotice",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "62bb23bdea7c4a0f183fc066",
      primitiva : "nodoChiediCatalogoServiziV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63c559672a92e811a8f33a00",
      primitiva : "activatePaymentNoticeV2",
      sub_service : "node-for-psp",
    },
    {
      operationId_s : "63c559672a92e811a8f33a01",
      primitiva : "sendPaymentOutcomeV2",
      sub_service : "node-for-psp",
    },
    // nodo-per-pa
    {
      operationId_s : "61e9633dea7c4a07cc7d480d",
      primitiva : "nodoChiediElencoFlussiRendicontazione",
      sub_service : "nodo-per-pa",
      response_time : 20000
    },
    {
      operationId_s : "61e9633dea7c4a07cc7d480e",
      primitiva : "nodoChiediFlussoRendicontazione",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec4",
      primitiva : "nodoChiediStatoRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec5",
      primitiva : "nodoChiediListaPendentiRPT",
      sub_service : "nodo-per-pa",
      response_time : 20000
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec6",
      primitiva : "nodoInviaRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec7",
      primitiva : "nodoInviaCarrelloRPT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec8",
      primitiva : "nodoChiediCopiaRT",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ec9",
      primitiva : "nodoChiediInformativaPSP",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15eca",
      primitiva : "nodoPAChiediInformativaPA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ecb",
      primitiva : "nodoChiediElencoQuadraturePA",
      sub_service : "nodo-per-pa",
    },
    {
      operationId_s : "62189aea2a92e81fa4f15ecc",
      primitiva : "nodoChiediQuadraturaPA",
      sub_service : "nodo-per-pa",
    },
    // nodo-per-psp
    {
      operationId_s : "61dedafb2a92e81a0c7a58f5",
      primitiva : "nodoVerificaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "61dedafc2a92e81a0c7a58f6",
      primitiva : "nodoAttivaRPT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "61e9633eea7c4a07cc7d4811",
      primitiva : "nodoInviaFlussoRendicontazione",
      sub_service : "nodo-per-psp",
      response_time : 20000
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e77",
      primitiva : "nodoInviaRT",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e78",
      primitiva : "nodoChiediInformativaPA",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e79",
      primitiva : "nodoChiediTemplateInformativaPSP",
      sub_service : "nodo-per-psp",
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e7a",
      primitiva : "nodoChiediElencoQuadraturePSP",
      sub_service : "nodo-per-psp",
    },
    // nodo-per-psp-richiesta-avvisi
    {
      operationId_s : "6217ba1a2a92e81fa4f15e75",
      primitiva : "nodoChiediNumeroAvviso",
      sub_service : "nodo-per-psp-richiesta-avvisi",
      response_time : 20000
    },
    {
      operationId_s : "6217ba1b2a92e81fa4f15e76",
      primitiva : "nodoChiediCatalogoServizi",
      sub_service : "nodo-per-psp-richiesta-avvisi",
    },
  ]
}

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-responsetime" {
  for_each            = { for c in local.api_nodo_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodoapi-${each.value.primitiva}-responsetime"
  location            = var.location

  action {
    action_group           = local.action_groups_default
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time ${each.value.primitiva} ${each.value.sub_service} nodoapi-responsetime https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = format(<<-QUERY
let threshold = %d;
AzureDiagnostics
| where url_s matches regex "/nodo/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
QUERY
  , lookup(each.value, "response_time", "") != "" ? each.value.response_time : 8000)

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 2	Warning	A problem that doesn't include any current loss in availability or performance, although it has the potential to lead to more severe problems if unaddressed.
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-availability" {
  for_each            = { for c in local.api_nodo_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodoapi-${each.value.primitiva}-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability ${each.value.primitiva} ${each.value.sub_service} nodoapi-availability https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/nodo/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }

}

// PROD AzureDiagnostics url_s operationId_s
// UAT ApiManagementGatewayLogs Url OperationId
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-auth-responsetime" {
  for_each            = { for c in local.api_nodo_auth_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-auth-api-${each.value.primitiva}-responsetime"
  location            = var.location

  action {
    action_group           = local.action_groups_default
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Response time ${each.value.primitiva} ${each.value.sub_service} nodo-auth-api-responsetime https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = format(<<-QUERY
let threshold = %d;
AzureDiagnostics
| where url_s matches regex "/nodo-auth/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95)
    by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
QUERY
  , lookup(each.value, "response_time", "") != "" ? each.value.response_time : 8000)

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 2	Warning	A problem that doesn't include any current loss in availability or performance, although it has the potential to lead to more severe problems if unaddressed.
  severity    = 2
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-nodo-auth-availability" {
  for_each            = { for c in local.api_nodo_auth_alerts : c.operationId_s => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-nodo-auth-api-${each.value.primitiva}-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  # data_source_id = data.azurerm_application_insights.application_insights.id
  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability ${each.value.primitiva} ${each.value.sub_service} nodo-auth-api-availability https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/cbc97060-c05b-48b5-9962-2b229eaa53de and https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/2b9b319b-5e7d-4efe-aaba-613daef8e9fc"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/nodo-auth/${each.value.sub_service}/"
| where operationId_s matches regex "${each.value.operationId_s}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )

  # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
  # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
  severity    = 1
  frequency   = 5
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
