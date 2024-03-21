resource "azurerm_resource_group" "checkout_be_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-be-rg", local.parent_project)
  location = var.location

  tags = var.tags
}

# Subnet to host checkout function
module "checkout_function_snet" {
  count                                          = var.checkout_enabled && var.cidr_subnet_checkout_be != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-checkout-be-snet", local.parent_project)
  address_prefixes                               = var.cidr_subnet_checkout_be
  resource_group_name                            = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = data.azurerm_virtual_network.vnet.name
  enforce_private_link_endpoint_network_policies = true

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "checkout_function" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v3.2.5"

  resource_group_name = azurerm_resource_group.checkout_be_rg[0].name
  name                = format("%s-fn-checkout", local.parent_project)
  location            = var.location
  health_check_path   = "/info"
  subnet_id           = module.checkout_function_snet[0].id
  runtime_version     = "~4"
  os_type             = "linux"
  linux_fx_version    = "NODE|18"

  always_on                                = var.checkout_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = format("%s-plan-fncheckout", local.parent_project)
  app_service_plan_info = {
    kind                         = var.checkout_function_kind
    sku_tier                     = var.checkout_function_sku_tier
    sku_size                     = var.checkout_function_sku_size
    maximum_elastic_worker_count = 0
  }

  storage_account_name = replace(format("%s-st-fncheckout", local.parent_project), "-", "")

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "18.16.0"
    FUNCTIONS_WORKER_PROCESS_COUNT = 4
    NODE_ENV                       = "production"

    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    IO_PAGOPA_PROXY  = var.checkout_pagopaproxy_host
    PAGOPA_BASE_PATH = "/pagopa/api/v1"


    IO_PAY_CHALLENGE_RESUME_URL = format("https://%s.%s/%s?id=idTransaction", var.dns_zone_checkout, var.external_domain, "esito")
    IO_PAY_ORIGIN               = format("https://%s.%s", var.dns_zone_checkout, var.external_domain)
    IO_PAY_XPAY_REDIRECT        = format("https://%s.%s/%s?id=_id_&resumeType=_resumeType_&_queryParams_", var.dns_zone_checkout, var.external_domain, "esito")

    PAY_PORTAL_RECAPTCHA_SECRET = data.azurerm_key_vault_secret.google_recaptcha_secret.value
  }

  storage_account_info = var.function_app_storage_account_info

  allowed_subnets = [data.azurerm_subnet.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "checkout_function" {
  count = var.checkout_enabled && var.env_short != "d" ? 1 : 0

  name                = format("%s-autoscale", module.checkout_function[0].name)
  resource_group_name = azurerm_resource_group.checkout_be_rg[0].name
  location            = var.location
  target_resource_id  = module.checkout_function[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.checkout_function_autoscale_default
      minimum = var.checkout_function_autoscale_minimum
      maximum = var.checkout_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.checkout_function[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 4000
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
        metric_resource_id       = module.checkout_function[0].id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 3000
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
}

# Availability: Checkout functions & pagopa-proxy
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_availability" {
  count = var.checkout_enabled && var.env_short == "p" ? 1 : 0

  name                = format("%s-availability-alert", module.checkout_function[0].name)
  resource_group_name = azurerm_resource_group.checkout_be_rg[0].name
  location            = var.location

  action {
    action_group           = [data.azurerm_monitor_action_group.email.id, data.azurerm_monitor_action_group.slack.id, data.azurerm_monitor_action_group.opsgenie.id]
    email_subject          = "Checkout Availability"
    custom_webhook_payload = "{}"
  }
  data_source_id = data.azurerm_application_insights.application_insights.id
  description    = "Checkout Availability less than 99%"
  enabled        = true
  query = (<<-QUERY
requests
    | where url startswith 'https://api.platform.pagopa.it/checkout/' or  url startswith 'https://api.platform.pagopa.it/api/checkout/v1'
    | summarize Total=count(), Success=count( (toint(resultCode) >= 200 and toint(resultCode) < 500 or customDimensions['Response-Body'] contains 'detail_v2' ) and duration < 10000) by Time=bin(timestamp,5m)
    | extend Availability=((Success*1.0)/Total)*100
    | where toint(Availability) < 99
  QUERY
  )
  severity    = 1
  frequency   = 30
  time_window = 30
  trigger {
    operator  = "GreaterThan"
    threshold = 2
  }
}

resource "azurerm_monitor_metric_alert" "checkout_fn_5xx" {
  count = var.checkout_enabled && var.env_short == "p" ? 1 : 0

  name                = format("%s-%s", module.checkout_function[0].name, "5xx")
  resource_group_name = data.azurerm_resource_group.monitor_rg.name
  scopes              = [module.checkout_function[0].id]
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  enabled = false

  action {
    action_group_id = data.azurerm_monitor_action_group.slack.id
  }

  dynamic_criteria {
    aggregation       = "Total"
    metric_namespace  = "Microsoft.Web/sites"
    metric_name       = "Http5xx"
    operator          = "GreaterThan"
    alert_sensitivity = "Low"
  }

  tags = var.tags
}
