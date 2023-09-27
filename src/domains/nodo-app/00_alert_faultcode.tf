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
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Availability Fault Code on activatePaymentNotice operation of node-for-psp API <grafana-dashboard-on-application-code>" #todo
  enabled        = true
  query = (<<-QUERY
let threshold = 0.95;
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
Success=countif(resp_outcome == "OK" or faultCode in ("PPT_PAGAMENTO_IN_CORSO","PPT_PAGAMENTO_DUPLICATO", "PPT_STAZIONE_INT_PA_TIMEOUT","PPT_ATTIVAZIONE_IN_CORSO", "PPT_ERRORE_EMESSO_DA_PAA"))
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
