locals {
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"

  app_insights_ips_west_europe = [
    "51.144.56.96/28",
    "51.144.56.112/28",
    "51.144.56.128/28",
    "51.144.56.144/28",
    "51.144.56.160/28",
    "51.144.56.176/28",
  ]

  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  monitor_appinsights_name           = "${local.product}-appinsights"

  vnet_name                = "${local.product}-vnet"
  vnet_resource_group_name = "${local.product}-vnet-rg"
  pagopa_vnet_integration  = "pagopa-${var.env_short}-vnet-integration"

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"
  pagopa_apim_snet = "${local.product}-apim-snet"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  gps_hostname  = var.env == "prod" ? "weuprod.gps.internal.platform.pagopa.it" : "weu${var.env}.gps.internal.${var.env}.platform.pagopa.it"

  gps_kv_rg = "${local.product}-${var.domain}-sec-rg"
  gps_kv    = "${local.product}-${var.domain}-kv"

  ## GPD app-service locals ##
  gpd_cors_configuration = {
    origins = ["*"]
    methods = ["*"]
  }
  gpd_app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
    APPINSIGHTS_PROFILERFEATURE_VERSION             = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION             = "1.0.0"
    APPLICATIONINSIGHTS_CONFIGURATION_CONTENT       = ""
    APPINSIGHTS_SAMPLING_PERCENTAGE                 = "100"
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
    SPRING_DATASOURCE_USERNAME = data.azurerm_key_vault_secret.gpd_db_usr.value
    SPRING_DATASOURCE_PASSWORD = data.azurerm_key_vault_secret.gpd_db_pwd.value
    # Deactivation prepareThreshold=0 https://jdbc.postgresql.org/documentation/head/server-prepare.html
    SPRING_DATASOURCE_URL                   = (local.gpd_hostname != null ? format("jdbc:postgresql://%s:%s/%s?sslmode=require%s", local.gpd_hostname, local.gpd_dbmsport, var.gpd_db_name, (var.env_short != "d" ? "&prepareThreshold=0" : "")) : "")
    SPRING_DATASOURCE_TYPE                  = var.env_short == "d" ? "com.zaxxer.hikari.HikariDataSource" : "org.springframework.jdbc.datasource.SimpleDriverDataSource" # disable hikari pool in UAT and PROD
    SPRING_JPA_HIBERNATE_DDL_AUTO           = "validate"
    SPRING_JPA_HIBERNATE_SHOW_SQL           = "false"
    CORS_CONFIGURATION                      = jsonencode(local.gpd_cors_configuration)
    SCHEMA_NAME                             = "apd"
    LOG_LEVEL                               = "INFO"
    SQL_LOG_LEVEL                           = "DEBUG"
    SQL_BINDER_LOG_LEVEL                    = "TRACE"
    CRON_JOB_SCHEDULE_ENABLED               = var.gpd_cron_job_enable # default disable
    CRON_JOB_SCHEDULE_EXPRESSION_TO_VALID   = var.gpd_cron_schedule_valid_to
    CRON_JOB_SCHEDULE_EXPRESSION_TO_EXPIRED = var.gpd_cron_schedule_expired_to

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.acr.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.acr.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.acr.admin_password
  }
  # gpd_allowed_subnets = [module.apim_snet.id, module.reporting_function_snet.id, module.payments_snet.id, module.canoneunico_function_snet.id]
  gpd_allowed_subnets = [data.azurerm_subnet.apim_snet.id, data.azurerm_subnet.canoneunico_function_snet.id]
  gpd_hostname        = var.env_short == "d" ? data.azurerm_postgresql_server.postgresql[0].fqdn : data.azurerm_postgresql_flexible_server.postgres_flexible_server_private[0].fqdn
  gpd_dbmsport        = var.pgbouncer_enabled ? "6432" : "5432" # replace data fetch of module.postgres_flexible_server_private[0].connection_port present in gpd-common
  ## APIM GPD ##
  apim_debt_positions_service_api = {
    display_name          = "GPD pagoPA - Debt Positions service API for organizations"
    description           = "API to support Debt Positions service for organizations"
    path                  = "gpd/debt-positions-service"
    subscription_required = true
    service_url           = format("https://weu${var.env}.gps.internal.%s.platform.pagopa.it/pagopa-gpd-core", var.env == "prod" ? "" : var.env)
  }
}
