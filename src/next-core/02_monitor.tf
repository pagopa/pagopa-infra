resource "azurerm_resource_group" "monitor_rg" {
  name     = format("%s-monitor-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                               = format("%s-law", local.product)
  location                           = azurerm_resource_group.monitor_rg.location
  resource_group_name                = azurerm_resource_group.monitor_rg.name
  sku                                = var.law_sku
  retention_in_days                  = var.law_retention_in_days
  daily_quota_gb                     = var.law_daily_quota_gb
  reservation_capacity_in_gb_per_day = var.env_short == "p" ? 100 : null
  allow_resource_only_permissions    = var.env_short != "p"

  tags = module.tag_config.tags

  lifecycle {
    ignore_changes = [
      sku
    ]
  }
}

# Azure Monitor Workspace
resource "azurerm_monitor_workspace" "monitor_workspace" {
  name                          = "${var.prefix}-${var.env_short}-monitor-workspace"
  resource_group_name           = "${var.prefix}-${var.env_short}-monitor-rg"
  location                      = var.location
  public_network_access_enabled = false
  tags                          = module.tag_config.tags
}

# Create workspace private DNS zone
resource "azurerm_private_dns_zone" "prometheus_dns_zone" {
  name                = "privatelink.${var.location}.prometheus.monitor.azure.com"
  resource_group_name = module.vnet.resource_group_name

  tags = module.tag_config.tags
}

# Create virtual network link for workspace private dns zone
resource "azurerm_private_dns_zone_virtual_network_link" "prometheus_dns_zone_vnet_link" {
  name                  = module.vnet.name
  resource_group_name   = module.vnet.resource_group_name
  virtual_network_id    = module.vnet.id
  private_dns_zone_name = azurerm_private_dns_zone.prometheus_dns_zone.name
  tags                  = module.tag_config.tags
}

resource "azurerm_private_endpoint" "monitor_workspace_private_endpoint" {
  name                = "${var.prefix}-monitor-workspace-pe"
  location            = azurerm_monitor_workspace.monitor_workspace.location
  resource_group_name = azurerm_monitor_workspace.monitor_workspace.resource_group_name
  subnet_id           = module.common_private_endpoint_snet.id

  private_service_connection {
    name                           = "monitorworkspaceconnection"
    private_connection_resource_id = azurerm_monitor_workspace.monitor_workspace.id
    is_manual_connection           = false
    subresource_names              = ["prometheusMetrics"]
  }

  private_dns_zone_group {
    name                 = "${var.prefix}-workspace-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.prometheus_dns_zone.id]
  }


  depends_on = [azurerm_monitor_workspace.monitor_workspace]

  tags = module.tag_config.tags
}

# Application insights

resource "azurerm_application_insights" "application_insights" {
  name                 = format("%s-appinsights", local.product)
  location             = azurerm_resource_group.monitor_rg.location
  resource_group_name  = azurerm_resource_group.monitor_rg.name
  application_type     = "other"
  daily_data_cap_in_gb = var.app_inisght_daily_data_cap_gb
  workspace_id         = azurerm_log_analytics_workspace.log_analytics_workspace.id

  tags = module.tag_config.tags
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

  tags = module.tag_config.tags
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

  tags = module.tag_config.tags
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

  tags = module.tag_config.tags
}

resource "azurerm_monitor_action_group" "pm_opsgenie" { # https://pagopa.atlassian.net/wiki/spaces/PPR/pages/647921690/PM
  count               = var.env_short == "p" ? 1 : 0
  name                = "PaymentManagerOpsgenie"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "PMOpsgenie"

  webhook_receiver {
    name                    = "PMOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.monitor_pm_opsgenie_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
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

  tags = module.tag_config.tags
}

resource "azurerm_monitor_action_group" "infra_opsgenie" { #
  count               = var.env_short == "p" ? 1 : 0
  name                = "InfraOpsgenie"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "InfrOpsgenie"

  webhook_receiver {
    name                    = "INFRAOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.opsgenie_infra_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}

resource "azurerm_monitor_action_group" "smo_opsgenie" { # pagoPA - Service Management and Operation - Reperibilità_SMO → https://pagopa.atlassian.net/wiki/x/TgA9XQ
  count               = var.env_short == "p" ? 1 : 0
  name                = "SmoOpsgenie"
  resource_group_name = azurerm_resource_group.monitor_rg.name
  short_name          = "SmoOpsgenie"

  webhook_receiver {
    name                    = "SmoOpsgenieWebhook"
    service_uri             = "https://api.opsgenie.com/v1/json/azure?apiKey=${data.azurerm_key_vault_secret.opsgenie_smo_webhook_key[0].value}"
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
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

  tags = module.tag_config.tags
}


resource "azurerm_monitor_action_group" "cert_pipeline_status" {
  resource_group_name = azurerm_resource_group.monitor_rg.name
  name                = "${var.prefix}${var.env_short}-cert-pipeline-status"
  short_name          = "${var.prefix}${var.env_short}cerst"

  email_receiver {
    name                    = "slack"
    email_address           = data.azurerm_key_vault_secret.alert_cert_pipeline_status_notification_slack.value
    use_common_alert_schema = true
  }

  tags = module.tag_config.tags
}

#
# web availability test
#
locals {
  test_urls = [
    # api.env.platform.pagopa.it
    {
      host = join(".",
      compact(["api", var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "/status-0123456789abcdef",
    },
    # portal.env.platform.pagopa.it
    {
      host = join(".",
      compact(["portal", var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    },
    # management.env.platform.pagopa.it
    {
      host = join(".",
      compact(["management", var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "/ServiceStatus",
    },
    # config.env.platform.pagopa.it
    {
      host = join(".",
      compact(["config", var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    },
    # env.checkout.pagopa.it
    {
      host = join(".",
      compact([var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "checkout.pagopa.it"])),
      path = "",
    },
    # env.wisp2.pagopa.it
    {
      host = join(".",
      compact([var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "wisp2.pagopa.it"])),
      path = "",
    },
    # selfcare.env.platform.pagopa.it
    {
      host = join(".",
      compact(["selfcare", var.env_short != "p" ? lower(module.tag_config.tags["Environment"]) : null, "platform.pagopa.it"])),
      path = "",
    }
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
  source = "./.terraform/modules/__v4__/application_insights_standard_web_test"

  for_each = { for v in concat(local.test_urls, var.monitor_env_test_urls) : v.host => v if v != null }

  application_insights_action_group_ids = var.env_short == "p" ? concat([
    azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  ], local.actions_grp_default_2) : local.actions_grp_default_2
  application_insights_id             = azurerm_application_insights.application_insights.id
  application_insights_resource_group = azurerm_application_insights.application_insights.resource_group_name
  https_endpoint                      = format("https://%s", each.value.host)
  https_endpoint_path                 = each.value.path
  https_probe_method                  = "GET"
  location                            = azurerm_resource_group.monitor_rg.location
  alert_name                          = "${each.value.host}-test-${azurerm_application_insights.application_insights.name}"
  retry_enabled                       = true
  replace_non_words_in_name           = false
  validation_rules = {
    expected_status_code        = 200
    ssl_cert_remaining_lifetime = 7
    ssl_check_enabled           = true

  }
  request_follow_redirects                 = false
  request_parse_dependent_requests_enabled = false
  metric_severity                          = 1
  metric_frequency                         = "PT1M"
  alert_use_web_test_criteria              = true
  alert_enabled                            = try(each.value.alert_enabled, true)

  tags = module.tag_config.tags

}


resource "azurerm_monitor_diagnostic_setting" "activity_log" {
  count                      = var.env_short == "p" ? 1 : 0
  name                       = "SecurityLogs"
  target_resource_id         = format("/subscriptions/%s", data.azurerm_subscription.current.subscription_id)
  log_analytics_workspace_id = data.azurerm_key_vault_secret.sec_workspace_id[0].value
  storage_account_id         = data.azurerm_key_vault_secret.sec_storage_id[0].value

  enabled_log {
    category = "Administrative"
  }

  enabled_log {
    category = "Security"
  }

  enabled_log {
    category = "Alert"
  }
}
