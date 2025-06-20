locals{
    app_name = "gpd-rtp"
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-rtp-error-json" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-rtp-error-json"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-rtp-error-json"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "gpd-rtp error JsonProcessingException"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where outerMessage contains "Payment option message is not a processable JSON"
  QUERY
    , local.app_name
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 10
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-rtp-error-generic" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-rtp-error-generic"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-rtp-error-generic"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "gpd-rtp error GenericException"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where outerMessage contains "Something was wrong"
  QUERY
    , local.app_name
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 5
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-rtp-error-rtp-message-not-sent" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-rtp-error-rtp-message-not-sent"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-rtp-error-rtp-message-not-sent"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "gpd-rtp error RTP_MESSAGE_NOT_SENT"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where outerMessage contains "The RTP message has not been sent to eventhub"
  QUERY
    , local.app_name
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-rtp-error-redis-cache-not-updated" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-rtp-error-redis-cache-not-updated"
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-rtp-error-redis-cache-not-updated"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "gpd-rtp error REDIS_CACHE_NOT_UPDATED"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where outerMessage contains "Cache is empty or not updated"
  QUERY
    , local.app_name
  )
  severity    = 2 // Sev 2	Warning
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}

resource "azurerm_monitor_scheduled_query_rules_alert" "gpd-rtp-error-message-sent-to-dead-letter" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-gpd-rtp-error-message-sent-to-dead-letter"
  location            = var.location

  action {
    action_group = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie[0].id, data.azurerm_monitor_action_group.smo_opsgenie[0].id]
    # action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id]
    email_subject          = "gpd-rtp-error-message-sent-to-dead-letter"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "gpd-rtp message sent to dead letter"
  enabled        = true
  query = format(<<-QUERY
  exceptions
    | where cloud_RoleName == "%s"
    | order by timestamp desc
    | where outerMessage contains "New Message in DeadLetter"
  QUERY
    , local.app_name
  )
  severity    = 1
  frequency   = 15
  time_window = 15
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }
}