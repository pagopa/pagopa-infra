locals {

  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]

  # ENABLE PROD afert deploy
  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]) : local.action_groups_default
  # SEV3 -> No Opsgenie alert
  action_groups_sev3 = var.env_short == "p" ? concat(local.action_groups_default) : local.action_groups_default
  # action_groups = local.action_groups_default

  alert-node-for-psp = [
    {
      name = "activatePaymentNotice V1 and V2"
      operations = [ // activatePaymentNotice v1/v2 legacy/auth
        "p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fc",
        "p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa0",
        "p-node-for-psp-api;rev=1 - 63c559672a92e811a8f33a00",
        "p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa5"
      ]
      operations_flat = "'p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fc','p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa0','p-node-for-psp-api;rev=1 - 63c559672a92e811a8f33a00','p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa5'"
      faults = [
        "PPT_AUTENTICAZIONE", "PPT_SYSTEM_ERROR", "PPT_ERRORE_IDEMPOTENZA" # errori MINIMI da monitorare e far scattare alert
      ]
      faults_flat = "'PPT_AUTENTICAZIONE', 'PPT_SYSTEM_ERROR', 'PPT_ERRORE_IDEMPOTENZA'"
      soapreq     = "activatePaymentNoticeRes|activatePaymentNoticeV2Response"
    },
    {
      name = "sendPaymentOutcome V1 and V2"
      operations = [ // sendPaymentOutcome v1/v2 legacy/auth
        "p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fd",
        "p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa1",
        "p-node-for-psp-api;rev=1 - 63c559672a92e811a8f33a01",
        "p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa6"
      ]
      operations_flat = "'p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fd','p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa1','p-node-for-psp-api;rev=1 - 63c559672a92e811a8f33a01','p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa6'"
      faults = [
        "PPT_AUTENTICAZIONE", "PPT_SYSTEM_ERROR", "PPT_ERRORE_IDEMPOTENZA" # errori MINIMI da monitorare e far scattare alert
      ]
      faults_flat = "'PPT_AUTENTICAZIONE', 'PPT_SYSTEM_ERROR', 'PPT_ERRORE_IDEMPOTENZA'"
      soapreq     = "sendPaymentOutcomeRes|sendPaymentOutcomeV2Response"
    }
  ]

  // ********************************************
  // Not needed until WISP dismantlng is DISABLED 
  // ********************************************
  alert-nodo-per-pa = []
  # [
  #   {
  #     name = "nodoInviaRPT"
  #     operations = [ // nodoInviaRPT legacy/auth
  #       "p-nodo-per-pa-api;rev=1 - 62189aea2a92e81fa4f15ec6", "p-nodo-per-pa-api-auth;rev=1 - 63e5d8212a92e80448d38dff"
  #     ]
  #     faults = [
  #       // nothing for now
  #     ]
  #     soapreq = "nodoInviaRPTRisposta"
  #   },
  #   {
  #     name = "nodoInviaCarrelloRPT"
  #     operations = [ // nodoInviaCarrelloRPT legacy/auth
  #       "p-nodo-per-pa-api;rev=1 - 62189aea2a92e81fa4f15ec7", "p-nodo-per-pa-api-auth;rev=1 - 63e5d8212a92e80448d38e00"
  #     ]
  #     faults = [
  #       // nothing for now
  #     ]
  #     soapreq = "nodoInviaCarrelloRPTRisposta"
  #   },
  # ]
}


// Availability by fault-code on activatePaymentNotice and sendPaymentOutcome
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fault-code-availability" {
  for_each = var.env_short == "p" ? { for idx, alert in local.alert-node-for-psp : idx => alert } : {}

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-node-for-psp-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id

  description = "Availability Fault Code on ${each.value.name} operation of node-for-psp API. The monitored fault codes are ${each.value.faults_flat} The availability threshold is set to 97% Dashboard: https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/0287abc9-da26-40fa-b261-f1634ee649aa"
  enabled     = true
  query = (<<-QUERY
let threshold = 0.97;
requests
| where operation_Name in (${each.value.operations_flat})
| extend xml_resp = replace_regex(replace_regex(replace_regex(tostring(customDimensions["Response-Body"]), '</.{0,10}?:', '</'), '<.{0,10}?:', '<'), '${each.value.soapreq}', 'primitiva')
| extend json_resp=parse_xml(xml_resp)
| extend outcome = tostring(json_resp["Envelope"]["Body"]["primitiva"].outcome)
| extend faultCode = tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"].faultCode)
| summarize
Total=count(),
Success=countif(outcome == "OK" or faultCode !in (${each.value.faults_flat}))
by bin(timestamp, 5m)
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

# // Availability by fault-code on nodoInviaRPT and nodoInviaCarrelloRPT
# resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fault-code-availability-nodoInviaRPT" {
#   for_each = var.env_short == "p" ? { for idx, alert in local.alert-nodo-per-pa : idx => alert } : {}

#   resource_group_name = "dashboards"
#   name                = "pagopa-${var.env_short}-nodo-per-pa-api-fault-code-availability"
#   location            = var.location

#   action {
#     action_group           = local.action_groups
#     email_subject          = "Email Header"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id

#   description = "Availability Fault Code on ${each.value.name} operation of nodo-per-pa API. The monitored fault codes are ${each.value.faults} The availability threshold is set to 97% Dashboard https://portal.azure.com/?l=en.en-us#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourcegroups/dashboards/providers/microsoft.portal/dashboards/0287abc9-da26-40fa-b261-f1634ee649aa"
#   enabled = true
#   query = (<<-QUERY
# let threshold = 0.97;
# requests
# | where operation_Name in (${join(", ", each.value.operations)})
# | extend body_resp = replace_regex(tostring(customDimensions["Response-Body"]), '<url>.*?</url>', '')
# | extend xml_resp = replace_regex(replace_regex(replace_regex(replace_regex(body_resp, '</.{0,10}?:', '</'), '<.{0,10}?:', '<'), '${each.value.soapreq}', 'primitiva'),'esitoComplessivoOperazione','esito')
# | extend json_resp=parse_xml(xml_resp)
# | extend esito = tostring(json_resp["Envelope"]["Body"]["primitiva"].esito)
# | extend faultCode = tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"].faultCode)
# | extend faultCode = iff(isnotnull(faultCode) and faultCode != "", faultCode, tostring(json_resp["Envelope"]["Body"]["primitiva"]["listaErroriRPT"]["fault"].faultCode))
# | summarize
# Total=count(),
# Success=countif(esito == "OK"
# or faultCode !in (${join(", ", each.value.faults)}))
# by bin(timestamp, 5m)
# | extend availability=toreal(Success) / Total
# | where availability < threshold
# QUERY
#   )

#   # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
#   # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
#   severity    = 1
#   frequency   = 5
#   time_window = 10
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 2
#   }
# }


## Error alert on specific faultCode
locals {
  api_nodo_faultcode_alerts = var.env_short != "p" ? [] : [
    {
      faultcode : "PPT_ERRORE_IDEMPOTENZA",
      threshold : "10",
    },
  ]
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fault-code-specific-threshold" {
  for_each = { for c in local.api_nodo_faultcode_alerts : c.faultcode => c }


  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-node-specific-${each.value.faultcode}-fault-code-threshold"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "FaultCode ${each.value.faultcode} on activatePaymentNotice operation GreaterThan ${each.value.threshold}"
  enabled        = true
  query = (<<-QUERY
let threshold = ${each.value.threshold};
requests
| extend xml_resp = replace_regex(replace_regex(replace_regex(tostring(customDimensions["Response-Body"]), '</.{0,10}?:', '</'), '<.{0,10}?:', '<'), 'activatePaymentNoticeRes|sendPaymentOutcomeRes|verificaBollettinoRes|verifyPaymentNoticeRes|nodoVerificaRPT', 'primitiva')
| extend json_resp=parse_xml(xml_resp)
| extend resp_outcome = tostring(json_resp["Envelope"]["Body"]["primitiva"]["outcome"])
| extend faultCode= tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"]["faultCode"])
| extend originalFaultCode = case(
json_resp["Envelope"]["Body"]["primitiva"]["fault"]["originalFaultCode"] != "", tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"]["originalFaultCode"]),
extract("FaultCode PA: ([A-Z_]+)", 1, tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"]["description"])))
| where cloud_RoleName == "pagopa-p-apim West Europe"
| where operation_Name == "p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fc" or operation_Name == "p-node-for-psp-api-auth;rev=1 - 63b6e2daea7c4a25440fdaa0" // activatePaymentNotice v1 legacy or auth
| where resp_outcome != "OK" and faultCode == "${each.value.faultcode}"
| summarize Total=count() by bin(timestamp, 5m)
| where Total > threshold
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


# TODO REFINE

# ## If the number of fault codes of type PPT_ERRORE_EMESSO_DA_PAA increases, the alert is triggered. The alert takes into account how many PSPs are impacted.
# resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fault-pa-error-availability" {
#   resource_group_name = "dashboards"
#   name                = "pagopa-${var.env_short}-node-for-psp-api-errore-pa-availability"
#   location            = var.location

#   action {
#     action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie.id]
#     email_subject          = "Email Header"
#     custom_webhook_payload = "{}"
#   }
#   data_source_id = data.azurerm_application_insights.application_insights.id
#   description    = "Availability Fault Code PPT_ERRORE_EMESSO_DA_PAA node-for-psp <grafana-dashboard-on-application-code>" #todo
#   enabled        = true
#   query = (<<-QUERY
# let threshold = 0.80;
# let affected_psp = 5;
# requests
# | extend xml_resp = replace_regex(replace_regex(replace_regex(tostring(customDimensions["Response-Body"]), '</.{0,10}?:', '</'), '<.{0,10}?:', '<'), 'activatePaymentNoticeRes|sendPaymentOutcomeRes|verificaBollettinoRes|verifyPaymentNoticeRes|nodoVerificaRPT', 'primitiva')
# | extend json_resp=parse_xml(xml_resp)
# | extend xml_req = replace_regex(replace_regex(replace_regex(tostring(customDimensions["Request-Body"]), '</.{0,10}?:', '</'), '<.{0,10}?:', '<'), 'activatePaymentNoticeReq|sendPaymentOutcomeReq|verificaBollettinoReq|verifyPaymentNoticeReq|nodoVerificaRPT', 'primitiva')
# | extend json_req=parse_xml(xml_req)
# | extend operation = case(
# operation_Name == "p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fc", "activatePaymentNotice",
# "unknown")
# | extend idPSP = tostring(json_req["Envelope"]["Body"]["primitiva"].idPSP)
# | extend idBrokerPSP = case (
# strlen(json_req["Envelope"]["Body"]["primitiva"].idBrokerPSP) == 9, strcat("00", tostring(json_req["Envelope"]["Body"]["primitiva"].idBrokerPSP)),
# strlen(json_req["Envelope"]["Body"]["primitiva"].idBrokerPSP) == 10, strcat("0", tostring(json_req["Envelope"]["Body"]["primitiva"].idBrokerPSP)),
# tostring(json_req["Envelope"]["Body"]["primitiva"].idBrokerPSP))
# | extend resp_outcome = tostring(json_resp["Envelope"]["Body"]["primitiva"]["outcome"])
# | extend faultCode= tostring(json_resp["Envelope"]["Body"]["primitiva"]["fault"]["faultCode"])
# | where cloud_RoleName == "pagopa-p-apim West Europe"
# | where operation_Name == "p-node-for-psp-api;rev=1 - 61dedafc2a92e81a0c7a58fc" // activatePaymentNotice v1 legacy
# | summarize
# Total=count(),
# Success=countif(resp_outcome == "OK" or faultCode != "PPT_ERRORE_EMESSO_DA_PAA")
# by bin(timestamp, 5m), idPSP
# | extend availability=toreal(Success) / Total
# | where availability < threshold
# | summarize PSP=count() by bin(timestamp, 5m)
# | where PSP > affected_psp
#   QUERY
#   )

#   # https://learn.microsoft.com/en-us/azure/azure-monitor/best-practices-alerts#alert-severity
#   # Sev 1	Error	Degradation of performance or loss of availability of some aspect of an application or service. Requires attention but not immediate
#   severity    = 1
#   frequency   = 5
#   time_window = 10
#   trigger {
#     operator  = "GreaterThanOrEqual"
#     threshold = 2
#   }
# }
