resource "azurerm_resource_group" "monitor_rg" {
  name     = format("%s-monitor-rg", local.product)
  location = var.location

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-law", local.product)
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb
  reservation_capacity_in_gb_per_day = var.env_short == "p" ? 100 : null
  allow_resource_only_permissions = var.env_short != "p"

  tags = var.tags
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = format("%s-appinsights", local.product)
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  application_type    = "other"

  workspace_id = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = var.tags
}


resource "azurerm_monitor_action_group" "email" {
  name                = "PagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PagoPA"

  email_receiver {
    name                    = "sendtooperations"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "slack" {
  name                = "SlackPagoPA"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "SlackPagoPA"

  email_receiver {
    name                    = "sendtoslack"
    email_address           = data.azurerm_key_vault_secret.monitor_notification_slack_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "mo_email" {
  name                = "MoManagement"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PagoPA"

  email_receiver {
    name                    = "sendtomomanagement"
    email_address           = data.azurerm_key_vault_secret.monitor_mo_notification_email.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "pm_opsgenie" { # https://pagopa.atlassian.net/wiki/spaces/PPR/pages/647921690/PM
  count               = var.env_short == "p" ? 1 : 0
  name                = "PaymentManagerOpsgenie"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PMOpsgenie"

  webhook_receiver {
    name                    = "PMOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_pm_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = var.tags
}

resource "azurerm_monitor_action_group" "new_conn_srv_opsgenie" { # https://pagopa.atlassian.net/wiki/spaces/PPR/pages/647921720/Nuova+Connettivit
  count               = var.env_short == "p" ? 1 : 0
  name                = "NuovaConnettivitOpsgenie"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "NewConn"

  webhook_receiver {
    name                    = "Nuova+ConnettivitOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_new_conn_srv_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = var.tags
}

#
# Alerts
#
resource "azurerm_monitor_action_group" "error_action_group" {
  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = "${var.prefix}${var.env_short}error"
  short_name          = "${var.prefix}${var.env_short}error"

  email_receiver {
    name                    = "email"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_email.value
    use_common_alert_schema = true
  }

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_error_notification_slack.value
    use_common_alert_schema = true
  }

  tags = var.tags
}

#
# web availability test
#
locals {
  test_urls = [
    # api.env.platform.pagopa.it
    {
      host = join(".",
      compact(["api", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "/status-0123456789abcdef",
    },
    # portal.env.platform.pagopa.it
    {
      host = join(".",
      compact(["portal", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    },
    # management.env.platform.pagopa.it
    {
      host = join(".",
      compact(["management", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "/ServiceStatus",
    },
    # config.env.platform.pagopa.it
    {
      host = join(".",
      compact(["config", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    },
    # env.checkout.pagopa.it
    {
      host = join(".",
      compact([var.env_short != "p" ? lower(var.tags["Environment"]) : null, "checkout.pagopa.it"])),
      path = "",
    },
    # env.wisp2.pagopa.it
    {
      host = join(".",
      compact([var.env_short != "p" ? lower(var.tags["Environment"]) : null, "wisp2.pagopa.it"])),
      path = "",
    },
    # selfcare.env.platform.pagopa.it
    {
      host = join(".",
      compact(["selfcare", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    },
    # api.prf.platform.pagopa.it
    {
      host = "api.prf.platform.pagopa.it"
      path = "",
    },
    # wisp2.pagopa.gov.it
    {
      host = "wisp2.pagopa.gov.it",
      path = "",
    },
    # uat.wisp2.pagopa.gov.it
    {
      host = "uat.wisp2.pagopa.gov.it",
      path = "",
    },
    # status.pagopa.gov.it
    {
      host = "status.pagopa.gov.it",
      path = "",
    },
    # assets.cdn.platform.pagopa.it
    {
      host = "assets.cdn.platform.pagopa.it",
      path = "",
    },
    # wfesp.pagopa.gov.it
    {
      host = "wfesp.pagopa.gov.it",
      path = "",
    },
    # # forwarder[.env].platform.pagopa.it https://pagopa.atlassian.net/wiki/spaces/IQCGJ/pages/589005731/Certificati+forwarder+.env+.platform.pagopa.it+Nuova+Connettivit
    # {
    #   host = join(".",
    #   compact(["forwarder", var.env_short != "p" ? lower(var.tags["Environment"]) : null, "platform.pagopa.it"])),
    #   path = "",
    # },
  ]

  # actions grp
  actions_grp_default = [
    {
      action_group_id = azurerm_monitor_action_group.email.id,
    },
    {
      action_group_id = azurerm_monitor_action_group.slack.id,
    },
  ]
  # actions grp
  actions_grp_default_2 = [
      azurerm_monitor_action_group.email.id,
      azurerm_monitor_action_group.slack.id,
  ]
}

module "web_test_standard" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//application_insights_standard_web_test?ref=v8.29.0"

  for_each = { for v in local.test_urls : v.host => v if v != null }

  application_insights_action_group_ids = var.env_short == "p" ? concat([
   azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  ], local.actions_grp_default_2) : local.actions_grp_default_2
  application_insights_id = azurerm_application_insights.application_insights.id
  application_insights_resource_group = azurerm_application_insights.application_insights.resource_group_name
  https_endpoint = format("https://%s", each.value.host)
  https_endpoint_path = each.value.path
  https_probe_method = "GET"
  location = azurerm_resource_group.monitor_rg.location
  alert_name = "${each.value.host}-test-${azurerm_application_insights.application_insights.name}"
  retry_enabled = true
  replace_non_words_in_name = false
  validation_rules = {
    expected_status_code = 200
    ssl_cert_remaining_lifetime = 7
    ssl_check_enabled = true

  }
  request_follow_redirects = false
  request_parse_dependent_requests_enabled = false
  metric_severity = 1
  metric_frequency = "PT1M"
  alert_use_web_test_criteria = true


}


resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "SecurityLogs"
  target_resource_id         = format("/subscriptions/%s", data.azurerm_subscription.current.subscription_id)
  log_analytics_workspace_id = data.azurerm_key_vault_secret.sec_workspace_id[0].value
  storage_account_id         = data.azurerm_key_vault_secret.sec_storage_id[0].value

  log {
    category = "Administrative"
    enabled  = true
  }

  log {
    category = "Security"
    enabled  = true
  }

  log {
    category = "Alert"
    enabled  = true
  }

  log {
    category = "Autoscale"
    enabled  = false
  }

  log {
    category = "Policy"
    enabled  = false
  }

  log {
    category = "Recommendation"
    enabled  = false
  }

  log {
    category = "ResourceHealth"
    enabled  = false
  }

  log {
    category = "ServiceHealth"
    enabled  = false
  }
}
