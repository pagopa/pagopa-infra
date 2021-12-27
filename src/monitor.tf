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

## web availabolity test
locals {

  test_urls = [
    {
      host = trimsuffix(azurerm_dns_a_record.dns_a_api.fqdn, "."),
      path = "",
    },
    {
      host = trimsuffix(azurerm_dns_a_record.dns_a_portal.fqdn, "."),
      path = "",
    },
    {
      host = trimsuffix(azurerm_dns_a_record.dns_a_management.fqdn, "."),
      path = "/ServiceStatus",
    },
    length(module.api_config_fe_cdn.*.fqdn) == 0 ? null : {
      host = module.api_config_fe_cdn[0].fqdn,
      path = "",
    },
    length(module.checkout_cdn.*.fqdn) == 0 ? null : {
      host = module.checkout_cdn[0].fqdn,
      path = "",
    },
  ]

}

module "web_test_api" {
  for_each = { for v in local.test_urls : v.host => v if v != null }
  source   = "git::https://github.com/pagopa/azurerm.git//application_insights_web_test_preview?ref=v2.0.18"

  subscription_id                   = data.azurerm_subscription.current.subscription_id
  name                              = format("%s-test", each.value.host)
  location                          = azurerm_resource_group.monitor_rg.location
  resource_group                    = azurerm_resource_group.monitor_rg.name
  application_insight_name          = azurerm_application_insights.application_insights.name
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
