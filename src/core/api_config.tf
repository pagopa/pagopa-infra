resource "azurerm_resource_group" "api_config_rg" {
  name     = format("%s-api-config-rg", local.project)
  location = var.location

  tags = var.tags
}

locals {
  apiconfig_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  }
}

# Subnet to host the api config
module "api_config_snet" {
  count                                          = var.cidr_subnet_api_config != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.90"
  name                                           = format("%s-api-config-snet", local.project)
  address_prefixes                               = var.cidr_subnet_api_config
  resource_group_name                            = azurerm_resource_group.rg_vnet.name
  virtual_network_name                           = module.vnet_integration.name
  enforce_private_link_endpoint_network_policies = true

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "api_config_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.8.0"

  vnet_integration    = true
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  # App service plan vars
  plan_name     = format("%s-plan-api-config", local.project)
  plan_kind     = "Linux"
  plan_sku_tier = var.api_config_tier
  plan_sku_size = var.api_config_size
  plan_reserved = true # Mandatory for Linux plan

  # App service plan
  name                = format("%s-app-api-config", local.project)
  client_cert_enabled = false
  always_on           = var.api_config_always_on
  # linux_fx_version    = "JAVA|11-java11"
  linux_fx_version  = format("DOCKER|%s/api-apiconfig-backend:%s", module.container_registry.login_server, "latest")
  health_check_path = "/apiconfig/api/v1/info"


  app_settings = {
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
    # Spring Environment
    SPRING_DATASOURCE_USERNAME = data.azurerm_key_vault_secret.db_nodo_usr.value
    SPRING_DATASOURCE_PASSWORD = data.azurerm_key_vault_secret.db_nodo_pwd.value
    SPRING_DATASOURCE_URL      = var.db_service_name == null ? null : format("jdbc:oracle:thin:@%s.%s:%s/%s", azurerm_private_dns_a_record.private_dns_a_record_db_nodo.name, azurerm_private_dns_zone.db_nodo_dns_zone.name, var.db_port, var.db_service_name)
    CORS_CONFIGURATION         = jsonencode(local.apiconfig_cors_configuration)
    XSD_ICA                    = var.xsd_ica
    XSD_COUNTERPART            = var.xsd_counterpart
    XSD_CDI                    = var.xsd_cdi
    LOGGING_LEVEL              = var.apiconfig_logging_level

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password

  }

  allowed_subnets = [module.apim_snet.id]
  allowed_ips     = []

  subnet_id = module.api_config_snet[0].id

  tags = var.tags
}

# Node database availability: Alerting Action
resource "azurerm_monitor_scheduled_query_rules_alert" "apiconfig_db_healthcheck" {
  name                = format("%s-%s", module.api_config_app_service.name, "db-healthcheck")
  resource_group_name = azurerm_resource_group.api_config_rg.name
  location            = var.location

  action {
    action_group           = [azurerm_monitor_action_group.email.id, azurerm_monitor_action_group.slack.id]
    email_subject          = "DB Nodo Healthcheck"
    custom_webhook_payload = "{}"
  }
  data_source_id = azurerm_application_insights.application_insights.id
  description    = "Availability greater than or equal 99%"
  enabled        = true
  query = format(<<-QUERY
  traces
    | where cloud_RoleName == "%s" and tostring(message) contains "dbConnection"
    | order by timestamp desc
    | summarize Total=count(), Success=countif(tostring(message) contains "dbConnection=up") by length=bin(timestamp,15m)
    | extend Availability=((Success*1.0)/Total)*100
    | where toint(Availability) < 99
  QUERY
    , module.api_config_app_service.name
  )
  severity    = 1
  frequency   = 45
  time_window = 45
  trigger {
    operator  = "GreaterThanOrEqual"
    threshold = 3
  }
}

resource "azurerm_monitor_autoscale_setting" "apiconfig_app_service_autoscale" {
  name                = format("%s-autoscale-apiconfig", local.project)
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location
  target_resource_id  = module.api_config_app_service.plan_id

  profile {
    name = "default"

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    # gpd rules
    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.api_config_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "GreaterThan"
        threshold                = 250
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.api_config_app_service.id
        metric_namespace         = "microsoft.web/sites"
        time_grain               = "PT1M"
        statistic                = "Average"
        time_window              = "PT5M"
        time_aggregation         = "Average"
        operator                 = "LessThan"
        threshold                = 250
        divide_by_instance_count = false
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }


  }
}
