locals {
  selfcare_services = [
    {
      name : "internal",
      base_path : "/backoffice/v1"
    },
    {
      name : "external-ec",
      base_path : "/backoffice/external/ec/v1"
      }, {
      name : "external-psp",
      base_path : "/backoffice/external/psp/v1"
    },
    {
      name : "helpdesk",
      base_path : "/backoffice/helpdesk/v1"
    }
  ]
}

#resource "azurerm_monitor_scheduled_query_rules_alert" "alert_pagopa-backoffice-responsetime" {
#  for_each            = { for c in local.selfcare_services : c.base_path => c }
#  resource_group_name = "dashboards"
#  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-${each.value.name}-responsetime @ _backoffice"
#  location            = var.location
#
#  action {
#    action_group           = var.env_short == "p" ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
#    email_subject          = "Backoffice Response Time"
#    custom_webhook_payload = "{}"
#  }
#
#  data_source_id = data.azurerm_api_management.apim.id
#  description    = "Response time for ${each.value.base_path} is less than or equal to 2s"
#  enabled        = true
#  query = (<<-QUERY
#let threshold = 2000;
#AzureDiagnostics
#| where url_s matches regex "${each.value.base_path}"
#| summarize
#    watermark=threshold,
#    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
#| where duration_percentile_95 > threshold
#  QUERY
#  )
#  severity    = 2
#  frequency   = 5
#  time_window = 10
#  trigger {
#    operator  = "GreaterThanOrEqual"
#    threshold = 2
#  }
#}


resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-availability" {
  for_each            = { for c in local.selfcare_services : c.base_path => c }
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-${each.value.name}-availability"
  location            = var.location

  action {
    action_group = var.env_short == "p" ? [
      data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id,
      data.azurerm_monitor_action_group.opsgenie[0].id
    ] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice Availability"
    custom_webhook_payload = "{}"
  }

  data_source_id = data.azurerm_api_management.apim.id
  description    = "Availability for ${each.value.base_path} is less than or equal to 99%"
  enabled        = true
  query = var.env_short == "p" ? (<<-QUERY
let threshold = 0.9;
AzureDiagnostics
| where url_s matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
| where Total > 10
  QUERY
    ) : (<<-QUERY
let threshold = 0.9;
ApiManagementGatewayLogs
| where Url matches regex "${each.value.base_path}"
| summarize
    Total=count(),
    Success=count(ResponseCode < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
| where Total > 10
  QUERY
  )
  severity    = 1
  frequency   = 10
  time_window = 10
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-brokerCiExport-cron-error" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-brokerCiExport-cron-error"
  location            = var.location

  action {
    # action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice error while running brokerCiExport cron"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error while running brokerCiExport cron, the process failed while attempting to extract and persist all CI associated to a broker"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "[Export-CI] - Error during brokerCiExport, process partially completed, the following brokers were not extracted/updated successfully"
    | order by timestamp desc
  QUERY
    , "pagopaselfcaremsbackofficebackend" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1 // Sev 2	Warning
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-brokerIbansExport-cron-error" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-brokerIbansExport-cron-error"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice error while running brokerIbansExport cron"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error while running brokerIbansExport cron, the process failed while attempting to extract and persist all Iban of CI associated to a broker"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "[Export IBANs] - Error during brokerIbansExport, process partially completed, the following brokers were not extracted/updated successfully"
    | order by timestamp desc
  QUERY
    , "pagopaselfcaremsbackofficebackend" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1 // Sev 2	Warning
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-brokerCiExport-cron-setup-error" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-brokerCiExport-cron-setup-error"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice error while extracting the list of brokers for brokerCiExport cron execution"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error while extracting the list of brokers necessary for brokerCiExport cron execution"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "[Export-CI] - An error occurred while extracting broker list, export aborted"
    | order by timestamp desc
  QUERY
    , "pagopaselfcaremsbackofficebackend" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1 // Sev 2	Warning
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert-pagopa-backoffice-brokerIbansExport-cron-setup-error" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-alert_pagopa-backoffice-brokerIbansExport-cron-setup-error"
  location            = var.location

  action {
    action_group           = can(data.azurerm_monitor_action_group.opsgenie[0]) ? [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id] : [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "Backoffice error while extracting the list of brokers for brokerIbansExport cron execution"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Error while extracting the list of brokers necessary for brokerIbansExport cron execution"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | where outerMessage contains "[Export IBANs] - An error occurred while extracting broker list, export aborted"
    | order by timestamp desc
  QUERY
    , "pagopaselfcaremsbackofficebackend" # from HELM's parameter WEBSITE_SITE_NAME
  )
  severity    = 1 // Sev 2	Warning
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}


resource "azurerm_monitor_scheduled_query_rules_alert" "alert_pagopa_backoffice_external_get_consents_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "alert-pagopa-backoffice-external-get-consents-availability"
  resource_group_name = "dashboards"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Backoffice-external] Service availability less than 99% in the last 15 minutes"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Service availability less than 99% in the last 15 minutes"
  enabled        = true
  #TO DO: tuning alert thresholds based 503 status code
  query = (<<-QUERY
AzureDiagnostics
| where url_s matches regex "https://api.platform.pagopa.it/backoffice/pagopa/services/v1/institutions/services/[^/]+/consents" and method_s == "GET"
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
    by Time = bin(TimeGenerated, 15m)
| extend availability=(toreal(Success) / Total) * 100
| where availability < 99
  QUERY
  )
  severity    = 1
  frequency   = 15
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "alert_pagopa_backoffice_frontend_consent_availability" {
  count = var.env_short == "p" ? 1 : 0

  name                = "alert-pagopa-backoffice-frontend-consent-availability"
  resource_group_name = "dashboards"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "[Selfcare-ms-backoffice-frontend] Service availability less than 99% in the last 15 minutes"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Service availability less than 99% in the last 15 minutes"
  enabled        = true
  #TO DO: tuning alert thresholds based 503 status code
  query = (<<-QUERY
AzureDiagnostics
| where (url_s matches regex "https://api.platform.pagopa.it/backoffice/v1/institutions/[^/]+/services/consents" and method_s == "GET") or 
(url_s matches regex "https://api.platform.pagopa.it/backoffice/v1/institutions/[^/]+/services/[^/]+/consent" and method_s == "PUT")
| summarize
    Total=count(),
    Success=countif(responseCode_d < 500)
    by Time = bin(TimeGenerated, 15m)
| extend availability=(toreal(Success) / Total) * 100
| where availability < 99
  QUERY
  )
  severity    = 1
  frequency   = 15
  time_window = 30
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 2
  }
}
