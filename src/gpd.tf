locals {
  gpd_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  }
  gpd_hostname = var.env_short == "d" ? module.postgresql[0].fqdn : null // TODO
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
  source = "git::https://github.com/pagopa/azurerm.git//app_service?ref=v2.2.0"

  resource_group_name = azurerm_resource_group.gpd_rg.name
  plan_type           = "external"
  plan_id             = azurerm_app_service_plan.gpd_service_plan.id

  # App service
  name                = format("%s-app-gpd", local.project)
  client_cert_enabled = false
  always_on           = var.gpd_always_on
  linux_fx_version    = format("DOCKER|%s/api-gpd-backend:%s", module.acr[0].login_server, "latest")
  health_check_path   = "/info"

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
    WEBSITE_DNS_SERVER = "168.63.129.16"

    # Spring Environment
    SPRING_DATASOURCE_USERNAME              = format("%s@pagopa-%s-postgresql",data.azurerm_key_vault_secret.gpd_db_usr.value, var.env_short)
    SPRING_DATASOURCE_PASSWORD              = data.azurerm_key_vault_secret.gpd_db_pwd.value
    SPRING_DATASOURCE_URL                   = var.gpd_dbms_name == null ? null : format("jdbc:postgresql://%s:%s/%s?sslmode=require", local.gpd_hostname, var.gpd_dbms_port, var.gpd_db_name)
    SPRING_JPA_HIBERNATE_DDL_AUTO           = "validate"
    CORS_CONFIGURATION                      = jsonencode(local.gpd_cors_configuration)
    SCHEMA_NAME                             = "apd"
    LOG_LEVEL                               = "INFO"
    CRON_JOB_SCHEDULE_ENABLED               = var.gpd_cron_job_enable
    CRON_JOB_SCHEDULE_EXPRESSION_TO_VALID   = var.gpd_cron_schedule_valid_to
    CRON_JOB_SCHEDULE_EXPRESSION_TO_EXPIRED = var.gpd_cron_schedule_expired_to

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password

  }

  allowed_subnets = [module.apim_snet.id, module.reporting_function_snet.id, module.payments_snet.id, module.canoneunico_function_snet.id]

  allowed_ips = []

  subnet_id = module.gpd_snet[0].id

  tags = var.tags

}
