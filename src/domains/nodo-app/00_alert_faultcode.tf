locals {

  action_groups_default = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]

  # ENABLE PROD afert deploy
  action_groups = var.env_short == "p" ? concat(local.action_groups_default, [data.azurerm_monitor_action_group.opsgenie[0].id]) : local.action_groups_default
  # SEV3 -> No Opsgenie alert
  action_groups_sev3 = var.env_short == "p" ? concat(local.action_groups_default) : local.action_groups_default
  # action_groups = local.action_groups_default

}


## Responses that return OK and those with one of these error codes
## ["PPT_PAGAMENTO_IN_CORSO","PPT_PAGAMENTO_DUPLICATO", "PPT_STAZIONE_INT_PA_TIMEOUT","PPT_ATTIVAZIONE_IN_CORSO", "PPT_ERRORE_EMESSO_DA_PAA"]
## are considered positive. The others are considered failure.
## NB: In this case the fault code PPT_ERRORE_EMESSO_DA_PAA is considered as 'Success', because there is a dedicated alert for this type of error.
## Excluding this type of fault from OK group would complicate the definition of the general alert for fault codes like this.
resource "azurerm_monitor_scheduled_query_rules_alert" "alert-fault-code-availability" {
  count = var.env_short == "p" ? 1 : 0

  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-node-for-psp-api-fault-code-availability"
  location            = var.location

  action {
    action_group           = local.action_groups
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability Fault Code on activatePaymentNotice operation of node-for-psp API <grafana-dashboard-on-application-code>" #todo
  enabled        = true
  query = (<<-QUERY
let threshold = 0.97;
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
| summarize
Total=count(),
Success=countif(resp_outcome == "OK"
or faultCode in (
"PPT_SINTASSI_EXTRAXSD", "PPT_SINTASSI_XSD", "PPT_DOMINIO_SCONOSCIUTO", "PPT_STAZIONE_INT_PA_SCONOSCIUTA",                  // Errori dati contenuti nell'avviso
"PPT_STAZIONE_INT_PA_IRRAGGIUNGIBILE", "PPT_STAZIONE_INT_PA_TIMEOUT", "PPT_STAZIONE_INT_PA_ERRORE_RESPONSE",                // Errori imputabili all'EC
"PPT_IBAN_NON_CENSITO", "PAA_SINTASSI_EXTRAXSD", "PAA_SINTASSI_XSD", "PAA_ID_DOMINIO_ERRATO", "PAA_SYSTEM_ERROR"            // Errori imputabili all'EC
"PAA_ID_INTERMEDIARIO_ERRATO", "PAA_STAZIONE_INT_ERRATA", "PAA_ATTIVA_RPT_IMPORTO_NON_VALIDO", "PPT_ERRORE_EMESSO_DA_PAA",  // Errori imputabili all'EC
"PAA_PAGAMENTO_IN_CORSO", "PPT_PAGAMENTO_IN_CORSO", "PAA_PAGAMENTO_SCADUTO", "PAA_PAGAMENTO_SCONOSCIUTO",                   // Pagamento in corso, errori avviso
"PAA_PAGAMENTO_ANNULLATO", "PAA_PAGAMENTO_DUPLICATO", "PPT_PAGAMENTO_DUPLICATO",                                            // Avviso scaduto, sconosciuto, annullato, duplicato
"PPT_ATTIVAZIONE_IN_CORSO"                                                                                                  // Meccanismo di prenotazione delle attivazioni tramite verificatore
))
by bin(timestamp, 5m)
| extend availability=toreal(Success) / Total
| where (Total >= 100 and availability < threshold ) or (Total > 20 and Total < 100 and availability < 0.80)
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
