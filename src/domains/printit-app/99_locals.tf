locals {
  product       = "${var.prefix}-${var.env_short}"
  project_short = "${var.prefix}-${var.env_short}-${var.domain}"
  project       = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  project_core_itn = "${var.prefix}-${var.env_short}-${var.location_short}-core"


  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "Opsgenie"
  monitor_appinsights_name           = "${local.product}-appinsights"
  monitor_appinsights_italy_name     = "${local.project_core_itn}-appinsights"

  vnet_name                = "${var.prefix}-${var.env_short}-${var.location_short}-vnet"
  vnet_resource_group_name = "${var.prefix}-${var.env_short}-${var.location_short}-vnet-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname                      = "${var.domain}.itn"
  internal_dns_zone_name                = "${var.dns_zone_internal_prefix}.${var.external_domain}"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  pagopa_apim_snet        = "${local.product}-apim-snet"
  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  domain_hostname = "${var.dns_zone_prefix}.${local.internal_dns_zone_name}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  apim_hostname = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"

  printit_pdf_engine_app_settings = {

    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights_italy.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = "InstrumentationKey=${data.azurerm_application_insights.application_insights_italy.instrumentation_key}"
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
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    #     WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 3000
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

    # waitForRender params
    CHECK_SIZE_INTERVAL        = 100
    MIN_STABLE_SIZE_ITERATIONS = 3
    FOLDERS_TO_LOAD            = "notices"

  }

  printit_pdf_engine_app_settings_java = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights_italy.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = "InstrumentationKey=${data.azurerm_application_insights.application_insights_italy.instrumentation_key}"
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
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    #     WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 80
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

    #custom prop
    HTML_TEMPLATE_FILE_NAME           = "template"
    WORKING_DIRECTORY_PATH            = "/temp"
    PDF_ENGINE_NODE_INFO_ENDPOINT     = var.env_short != "p" ? "https://api.${var.env}.platform.pagopa.it/printit/pdf-engine-node/v1/info" : "https://api.platform.pagopa.it/printit/pdf-engine-node/v1/info"
    PDF_ENGINE_NODE_GENERATE_ENDPOINT = var.env_short != "p" ? "https://api.${var.env}.platform.pagopa.it/printit/pdf-engine-node/v1/generate-pdf" : "https://api.platform.pagopa.it/printit/pdf-engine-node/v1/generate-pdf"
    ENABLE_ECS_CONSOLE                = "true"
    CONSOLE_LOG_THRESHOLD             = "DEBUG"
    CONSOLE_LOG_PATTERN               = "%d{HH:mm:ss.SSS}[%thread]%-5level%logger{36}-%msg%n"
    CONSOLE_LOG_CHARSET               = "UTF-8"
    OTEL_RESOURCE_ATTRIBUTES          = "service.name=printitpagopapdfengineotl,deployment.environment=${var.env}"
    OTEL_EXPORTER_OTLP_ENDPOINT       = "http://otel-collector.elastic-system.svc:4317"
    OTEL_LOGS_EXPORTER                = "none"
    OTEL_TRACES_SAMPLER               = "always_on"
    JAVA_TOOL_OPTIONS                 = "-javaagent:/home/site/wwwroot/jmx_prometheus_javaagent-0.19.0.jar=12345:/home/site/wwwroot/config.yaml -javaagent:/home/site/wwwroot/opentelemetry-javaagent.jar"
    OTEL_EXPORTER_OTLP_HEADERS        = data.azurerm_key_vault_secret.elastic_otel_token_header.value
    PDF_ENGINE_NODE_SUBKEY            = can(azurerm_api_management_subscription.pdf_engine_node_subkey[0].primary_key) ? azurerm_api_management_subscription.pdf_engine_node_subkey[0].primary_key : ""

  }

}
