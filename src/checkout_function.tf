resource "azurerm_resource_group" "checkout_be_rg" {
  count    = var.checkout_enabled ? 1 : 0
  name     = format("%s-checkout-be-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host checkout function
module "checkout_function_snet" {
  count                                          = var.checkout_enabled && var.cidr_subnet_checkout_be != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-checkout-be-snet", local.project)
  address_prefixes                               = var.cidr_subnet_checkout_be
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

module "checkout_function" {
  count  = var.checkout_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.checkout_be_rg[0].name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "checkout"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.checkout_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.checkout_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key


  app_service_plan_info = {
    kind                         = var.checkout_function_kind
    sku_tier                     = var.checkout_function_sku_tier
    sku_size                     = var.checkout_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME       = "node"
    WEBSITE_NODE_DEFAULT_VERSION   = "12.18.0"
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


    IO_PAY_CHALLENGE_RESUME_URL = format("https://%s.%s/p/response.html?id=idTransaction", var.dns_zone_checkout, var.external_domain)
    IO_PAY_ORIGIN               = format("https://%s.%s", var.dns_zone_checkout, var.external_domain)
    IO_PAY_XPAY_REDIRECT        = format("https://%s.%s/p/response.html?id=_id_&resumeType=_resumeType_&_queryParams_", var.dns_zone_checkout, var.external_domain)

    PAY_PORTAL_RECAPTCHA_SECRET = data.azurerm_key_vault_secret.google_recaptcha_secret[0].value
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "checkout_function" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-%s-autoscale", local.project, module.checkout_function[0].name)
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

# Availability: Alerting Action
resource "azurerm_monitor_scheduled_query_rules_alert" "checkout_availability" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-%s-availability-alert", local.project, module.checkout_function[0].name)
  resource_group_name = azurerm_resource_group.checkout_be_rg[0].name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "Email Header"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability greater than 99%"
  enabled        = true
  query = format(<<-QUERY
  requests
    | where cloud_RoleName == '%s'
    | summarize Total=count(), Success=count(toint(resultCode) == 200) by length=bin(timestamp,5m)
    | extend Availability=((Success*1.0)/Total)*100
    | project Availability
    | limit 1
  QUERY
  , format("%s-fn-%s", local.project, module.checkout_function[0].name))
  severity    = 1
  frequency   = 10
  time_window = 5
  trigger {
    operator  = "LessThan"
    threshold = 99
  }
}

resource "azurerm_monitor_metric_alert" "checkout_fn_5xx" {
  count = var.checkout_enabled ? 1 : 0

  name                = format("%s-%s", module.checkout_function[0].name, "5xx")
  resource_group_name = azurerm_resource_group.monitor_rg.name
  scopes              = [module.checkout_function[0].id]
  severity            = 1
  frequency           = "PT1M"
  window_size         = "PT5M"

  action {
    action_group_id = azurerm_monitor_action_group.slack.id
  }

  criteria {
    aggregation      = "Count"
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    operator         = "GreaterThanOrEqual"
    threshold        = "10"
  }

  tags = var.tags
}
