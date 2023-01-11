resource "azurerm_resource_group" "monitor_rg" {
  name     = format("%s-monitor-rg", local.project)
  location = var.location

  tags = var.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = format("%s-law", local.project)
  location            = azurerm_resource_group.monitor_rg.location
  resource_group_name = azurerm_resource_group.monitor_rg.name
  sku                 = var.law_sku
  retention_in_days   = var.law_retention_in_days
  daily_quota_gb      = var.law_daily_quota_gb

  tags = var.tags
}

# Application insights
resource "azurerm_application_insights" "application_insights" {
  name                = format("%s-appinsights", local.project)
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
  ]
}

module "web_test_api" {
  source = "git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview?ref=v2.19.1"

  for_each = { for v in local.test_urls : v.host => v if v != null }

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = format("%s-test", each.value.host)
  location                          = azurerm_resource_group.monitor_rg.location
  resource_group                    = azurerm_resource_group.monitor_rg.name
  application_insight_name          = azurerm_application_insights.application_insights.name
  application_insight_id            = azurerm_application_insights.application_insights.id
  request_url                       = format("https://%s%s", each.value.host, each.value.path)
  ssl_cert_remaining_lifetime_check = 7

  actions = [
    {
      action_group_id = azurerm_monitor_action_group.email.id,
    },
    {
      action_group_id = azurerm_monitor_action_group.slack.id,
    },
  ]
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
