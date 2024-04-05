locals {

  node_forwarder_app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", azurerm_application_insights.application_insights.instrumentation_key)
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    ApplicationInsightsAgent_EXTENSION_VERSION      = "~3"
    DiagnosticServices_EXTENSION_VERSION            = "~3"
    InstrumentationEngine_EXTENSION_VERSION         = "disabled"
    SnapshotDebugger_EXTENSION_VERSION              = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled"
    XDT_MicrosoftApplicationInsights_Mode           = "recommended"
    XDT_MicrosoftApplicationInsights_PreemptSdk     = "disabled"
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE                 = true
    # Spring Environment
    DEFAULT_LOGGING_LEVEL = var.node_forwarder_logging_level
    APP_LOGGING_LEVEL     = var.node_forwarder_logging_level
    JAVA_OPTS             = "-Djavax.net.debug=ssl:handshake" // mTLS debug

    # Cert configuration
    CERTIFICATE_CRT = data.azurerm_key_vault_secret.certificate_crt_node_forwarder.value
    CERTIFICATE_KEY = data.azurerm_key_vault_secret.certificate_key_node_forwarder.value

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

  }


}

resource "azurerm_resource_group" "node_forwarder_rg" {
  name     = format("%s-node-forwarder-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host the node forwarder
module "node_forwarder_snet" {
  source                                         = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.76.0"
  name                                           = format("%s-node-forwarder-snet", local.project)
  address_prefixes                               = var.cidr_subnet_node_forwarder
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "node_forwarder_app_service" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.76.0"

  vnet_integration    = false
  resource_group_name = azurerm_resource_group.node_forwarder_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-node-forwarder", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.node_forwarder_tier
  plan_sku_size = var.node_forwarder_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-node-forwarder", local.project)
  client_cert_enabled = false
  always_on           = var.node_forwarder_always_on
  linux_fx_version    = format("DOCKER|%s/pagopanodeforwarder:%s", module.container_registry.login_server, "latest")
  health_check_path   = "/actuator/info"

  app_settings = local.node_forwarder_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.node_forwarder_snet.id

  tags = var.tags
}

module "node_forwarder_slot_staging" {
  count = var.env_short != "d" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.76.0"

  # App service plan
  app_service_plan_id = module.node_forwarder_app_service.plan_id
  app_service_id      = module.node_forwarder_app_service.id
  app_service_name    = module.node_forwarder_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.node_forwarder_rg.name
  location            = var.location

  always_on         = true
  linux_fx_version  = format("DOCKER|%s/pagopanodeforwarder:%s", module.container_registry.login_server, "latest")
  health_check_path = "/actuator/info"


  # App settings
  app_settings = local.node_forwarder_app_settings

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []
  subnet_id       = module.node_forwarder_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "node_forwarder_app_service_autoscale" {
  name                = format("%s-autoscale-node-forwarder", local.project)
  resource_group_name = azurerm_resource_group.node_forwarder_rg.name
  location            = azurerm_resource_group.node_forwarder_rg.location
  target_resource_id  = module.node_forwarder_app_service.plan_id
  enabled             = var.node_forwarder_autoscale_enabled

  # default profile on REQUESTs
  profile {
    name = "default"

    capacity {
      default = 5
      minimum = 3
      maximum = 10
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.node_forwarder_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3000
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.node_forwarder_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2500
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

    # Supported metrics for Microsoft.Web/sites 
    # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
    rule {
      metric_trigger {
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.node_forwarder_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 3 #sec
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "HttpResponseTime"
        metric_resource_id       = module.node_forwarder_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 2 #sec
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT20M"
      }
    }

  }

  # addded profile on CPU avg
  # profile {
  #   name = "response-time"

  #   capacity {
  #     default = 5
  #     minimum = 3
  #     maximum = 10
  #   }

  #   # Supported metrics for Microsoft.Web/sites 
  #   # 👀 https://learn.microsoft.com/en-us/azure/azure-monitor/reference/supported-metrics/microsoft-web-sites-metrics
  #   rule {
  #     metric_trigger {
  #       metric_name              = "HttpResponseTime"
  #       metric_resource_id       = module.node_forwarder_app_service.id
  #       metric_namespace         = "microsoft.web/sites"
  #       time_grain               = "PT1M"
  #       statistic                = "Average"
  #       time_window              = "PT5M"
  #       time_aggregation         = "Average"
  #       operator                 = "GreaterThan"
  #       threshold                = 3 #sec
  #       divide_by_instance_count = false
  #     }

  #     scale_action {
  #       direction = "Increase"
  #       type      = "ChangeCount"
  #       value     = "2"
  #       cooldown  = "PT5M"
  #     }
  #   }

  #   rule {
  #     metric_trigger {
  #       metric_name              = "HttpResponseTime"
  #       metric_resource_id       = module.node_forwarder_app_service.id
  #       metric_namespace         = "microsoft.web/sites"
  #       time_grain               = "PT1M"
  #       statistic                = "Average"
  #       time_window              = "PT5M"
  #       time_aggregation         = "Average"
  #       operator                 = "LessThan"
  #       threshold                = 2 #sec
  #       divide_by_instance_count = false
  #     }

  #     scale_action {
  #       direction = "Decrease"
  #       type      = "ChangeCount"
  #       value     = "1"
  #       cooldown  = "PT20M"
  #     }
  #   }

  #   recurrence {
  #     timezone = "E. Europe Standard Time"
  #     days     = ["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"]
  #     hours    = [6]
  #     minutes  = [0]
  #   }

  # }

}


# KV placeholder for CERT and KEY certificate
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_crt_node_forwarder_s" {
  name         = "certificate-crt-node-forwarder"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_key_node_forwarder_s" {
  name         = "certificate-key-node-forwarder"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

data "azurerm_key_vault_secret" "certificate_crt_node_forwarder" {
  name         = "certificate-crt-node-forwarder"
  key_vault_id = module.key_vault.id
}
data "azurerm_key_vault_secret" "certificate_key_node_forwarder" {
  name         = "certificate-key-node-forwarder"
  key_vault_id = module.key_vault.id
}

#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "node_forwarder_subscription_key" {
  count        = var.env_short != "p" ? 1 : 0 # only in DEV and UAT
  name         = "node-forwarder-api-subscription-key"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}


# pagopa-<ENV>-opex_pagopa-node-forwarder-responsetime @ _forward
# data "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-node-forwarder-responsetime-get" {
#   count               = var.env_short == "p" ? 1 : 0
#   resource_group_name = "dashboards"
#   name                = "pagopa-${var.env_short}-opex_pagopa-node-forwarder-responsetime @ _forward2"
# }

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-node-forwarder-responsetime-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-node-forwarder-responsetime @ _forward2"
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.apim.id
  description    = "Response time for /forward is less than or equal to 9s - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  enabled        = true
  query = (<<-QUERY
let threshold = 9000;
AzureDiagnostics
| where url_s matches regex "/forward"
| summarize
    watermark=threshold,
    duration_percentile_95=percentiles(DurationMs, 95) by bin(TimeGenerated, 5m)
| where duration_percentile_95 > threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

}

resource "azurerm_monitor_scheduled_query_rules_alert" "opex_pagopa-node-forwarder-availability-upd" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-opex_pagopa-node-forwarder-availability @ _forward2"
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id, azurerm_monitor_action_group.mo_email.id, azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = module.apim.id
  description    = "Availability for /forward is less than or equal to 99% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  enabled        = true
  query = (<<-QUERY
let threshold = 0.99;
AzureDiagnostics
| where url_s matches regex "/forward"
| summarize
    Total=count(),
    Success=count(responseCode_d < 500)
    by bin(TimeGenerated, 5m)
| extend availability=toreal(Success) / Total
| where availability < threshold
  QUERY
  )
  severity    = 1
  frequency   = 5
  time_window = 5
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 1
  }

}

#################################
# Alert on mem or cpu avr 
#################################
resource "azurerm_monitor_metric_alert" "app_service_over_cpu_usage" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-node-forwarder-cpu-usage-over-80"

  scopes      = [module.node_forwarder_app_service.plan_id]
  description = "Forwarder CPU usage greater than 80% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  severity    = 3
  frequency   = "PT5M"
  window_size = "PT5M"

  target_resource_type     = "microsoft.web/serverfarms"
  target_resource_location = var.location


  criteria {
    metric_namespace       = "microsoft.web/serverfarms"
    metric_name            = "CpuPercentage"
    aggregation            = "Average"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }

  tags = var.tags
}

resource "azurerm_monitor_metric_alert" "app_service_over_mem_usage" {
  count               = var.env_short == "p" ? 1 : 0
  resource_group_name = "dashboards"
  name                = "pagopa-${var.env_short}-pagopa-node-forwarder-mem-usage-over-80"

  scopes      = [module.node_forwarder_app_service.plan_id]
  description = "Forwarder MEM usage greater than 80% - https://portal.azure.com/#@pagopait.onmicrosoft.com/dashboard/arm/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/dashboards/providers/Microsoft.Portal/dashboards/pagopa-p-opex_pagopa-node-forwarder"
  severity    = 3
  frequency   = "PT5M"
  window_size = "PT5M"

  target_resource_type     = "microsoft.web/serverfarms"
  target_resource_location = var.location


  criteria {
    metric_namespace       = "microsoft.web/serverfarms"
    metric_name            = "MemoryPercentage"
    aggregation            = "Average"
    operator               = "GreaterThan"
    threshold              = "80"
    skip_metric_validation = false
  }

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.email.id
  }
  action {
    action_group_id = azurerm_monitor_action_group.new_conn_srv_opsgenie[0].id
  }

  tags = var.tags
}


