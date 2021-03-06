locals {
  gpd_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  }
  gpd_app_settings = {
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
    SPRING_DATASOURCE_USERNAME = var.env_short == "d" ? format("%s@pagopa-%s-postgresql", data.azurerm_key_vault_secret.gpd_db_usr.value, var.env_short) : data.azurerm_key_vault_secret.gpd_db_usr.value
    SPRING_DATASOURCE_PASSWORD = data.azurerm_key_vault_secret.gpd_db_pwd.value
    # Deactivation prepareThreshold=0 https://jdbc.postgresql.org/documentation/head/server-prepare.html
    SPRING_DATASOURCE_URL                   = (local.gpd_hostname != null ? format("jdbc:postgresql://%s:%s/%s?sslmode=require%s", local.gpd_hostname, local.gpd_dbmsport, var.gpd_db_name, (var.env_short != "d" ? "&prepareThreshold=0" : "")) : "")
    SPRING_DATASOURCE_TYPE                  = var.env_short == "d" ? "com.zaxxer.hikari.HikariDataSource" : "org.springframework.jdbc.datasource.SimpleDriverDataSource" # disable hikari pull in UAT and PROD
    SPRING_JPA_HIBERNATE_DDL_AUTO           = "validate"
    SPRING_JPA_HIBERNATE_SHOW_SQL           = "false"
    CORS_CONFIGURATION                      = jsonencode(local.gpd_cors_configuration)
    SCHEMA_NAME                             = "apd"
    LOG_LEVEL                               = "INFO"
    CRON_JOB_SCHEDULE_ENABLED               = var.gpd_cron_job_enable # default disable
    CRON_JOB_SCHEDULE_EXPRESSION_TO_VALID   = var.gpd_cron_schedule_valid_to
    CRON_JOB_SCHEDULE_EXPRESSION_TO_EXPIRED = var.gpd_cron_schedule_expired_to

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.container_registry.admin_password
  }
  # gpd_allowed_subnets = [module.apim_snet.id, module.reporting_function_snet.id, module.payments_snet.id, module.canoneunico_function_snet.id]
  gpd_allowed_subnets = [module.apim_snet.id, module.reporting_function_snet.id, module.canoneunico_function_snet.id]
  gpd_hostname        = var.env_short == "d" ? module.postgresql[0].fqdn : module.postgres_flexible_server_private[0].fqdn
  gpd_dbmsport        = var.env_short == "d" ? var.gpd_dbms_port : module.postgres_flexible_server_private[0].connection_port # PgBouncer
}

# Subnet to host the api config
module "gpd_snet" {
  count                                          = var.cidr_subnet_gpd != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-gpd-snet", local.project)
  address_prefixes                               = var.cidr_subnet_gpd
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



module "gpd_app_service" {
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.8.0"

  vnet_integration    = true
  resource_group_name = azurerm_resource_group.gpd_rg.name
  plan_type           = "external"
  plan_id             = azurerm_app_service_plan.gpd_service_plan.id

  # App service
  name                = format("%s-app-gpd", local.project)
  client_cert_enabled = false
  always_on           = var.gpd_always_on
  linux_fx_version    = format("DOCKER|%s/api-gpd-backend:%s", module.container_registry.login_server, "latest")
  health_check_path   = "/info"

  app_settings = local.gpd_app_settings

  allowed_subnets = local.gpd_allowed_subnets

  allowed_ips = []

  subnet_id = module.gpd_snet[0].id

  tags = var.tags

}


module "gpd_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//app_service_slot?ref=v2.2.0"

  # App service plan
  app_service_plan_id = module.gpd_app_service.plan_id
  app_service_id      = module.gpd_app_service.id
  app_service_name    = module.gpd_app_service.name

  # App service
  name                = "staging"
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location

  always_on         = true
  linux_fx_version  = format("DOCKER|%s/api-gpd-backend:%s", module.container_registry.login_server, "latest")
  health_check_path = "/info"

  # App settings
  app_settings = local.gpd_app_settings

  allowed_subnets = local.gpd_allowed_subnets
  allowed_ips     = []
  subnet_id       = module.gpd_snet[0].id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "gpd_app_service_autoscale" {
  name                = format("%s-autoscale-gpd", local.project)
  resource_group_name = azurerm_resource_group.gpd_rg.name
  location            = azurerm_resource_group.gpd_rg.location
  target_resource_id  = module.gpd_app_service.plan_id

  profile {
    name = "default"

    capacity {
      default = var.gpd_autoscale_default
      minimum = var.gpd_autoscale_minimum
      maximum = var.gpd_autoscale_maximum
    }

    # gpd rules
    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.gpd_app_service.id
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
        value     = "2"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.gpd_app_service.id
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
