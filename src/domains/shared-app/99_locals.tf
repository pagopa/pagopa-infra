locals {
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"
  product = "${var.prefix}-${var.env_short}"

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

  acr_name                = replace("${local.product}commonacr", "-", "")
  acr_resource_group_name = "${local.product}-container-registry-rg"

  aks_name                = "${local.product}-${var.location_short}-${var.instance}-aks"
  aks_resource_group_name = "${local.product}-${var.location_short}-${var.instance}-aks-rg"

  ingress_hostname       = "${var.location_short}${var.instance}.${var.domain}"
  internal_dns_zone_name = "${var.dns_zone_internal_prefix}.${var.external_domain}"

  pagopa_apim_name = "${local.product}-apim"
  pagopa_apim_rg   = "${local.product}-api-rg"

  pagopa_apim_snet        = "${local.product}-apim-snet"
  pagopa_vnet_integration = "pagopa-${var.env_short}-vnet-integration"
  pagopa_vnet_rg          = "pagopa-${var.env_short}-vnet-rg"

  apim_hostname   = "api.${var.apim_dns_zone_prefix}.${var.external_domain}"
  shared_hostname = var.env == "prod" ? "weuprod.shared.internal.platform.pagopa.it" : "weu${var.env}.shared.internal.${var.env}.platform.pagopa.it"

  cache_generator_hostname   = "${local.shared_hostname}/authorizer-functions/api"
  cache_generator_hostname_2 = "${local.shared_hostname}/authorizer-functions"

  authorizer_config_hostname = "${local.shared_hostname}/authorizer-config"

  # iuvgenerator_hostname = "${local.shared_hostname}/pagopa-iuv-generator" # removed it not used shifted to 👀 https://github.com/pagopa/pagopa-iuvgenerator/tree/main/infra

  # DOMAINS
  system_domain_namespace = kubernetes_namespace.system_domain_namespace.metadata[0].name
  domain_namespace        = kubernetes_namespace.namespace.metadata[0].name

  authorizer_healthcheck_criteria = {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "HealthCheckStatus"
    aggregation      = "Average"
    operator         = "LessThan"
    threshold        = 99
  }
  authorizer_healthcheck_action = var.env_short == "p" ? [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id,
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.opsgenie[0].id,
      webhook_properties = null
    }
    ] : [
    {
      action_group_id    = data.azurerm_monitor_action_group.email.id
      webhook_properties = null
    },
    {
      action_group_id    = data.azurerm_monitor_action_group.slack.id,
      webhook_properties = null
    }
  ]

  shared_pdf_engine_app_settings = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
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
    # WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10
    TIMEOUT_DELAY = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    # WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 3000
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.container_registry.admin_password

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

    # waitForRender params
    CHECK_SIZE_INTERVAL        = 100
    MIN_STABLE_SIZE_ITERATIONS = 3
    FOLDERS_TO_LOAD            = "receipts"
  }

  shared_pdf_engine_app_settings_java = {
    # Monitoring
    APPINSIGHTS_INSTRUMENTATIONKEY                  = data.azurerm_application_insights.application_insights.instrumentation_key
    APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", data.azurerm_application_insights.application_insights.instrumentation_key)
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
    # WEBSITE_HEALTHCHECK_MAXPINGFAILURES             = 10
    TIMEOUT_DELAY = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    # WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = true

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 80
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"
    DOCKER_REGISTRY_SERVER_URL      = "https://${data.azurerm_container_registry.container_registry.login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = data.azurerm_container_registry.container_registry.admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = data.azurerm_container_registry.container_registry.admin_password

    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

    # custom prop
    HTML_TEMPLATE_FILE_NAME           = "template"
    WORKING_DIRECTORY_PATH            = "/temp"
    PDF_ENGINE_NODE_INFO_ENDPOINT     = var.env_short != "p" ? "https://api.${var.env}.platform.pagopa.it/shared/pdf-engine-node/v1/info" : "https://api.platform.pagopa.it/shared/pdf-engine-node/v1/info"
    PDF_ENGINE_NODE_GENERATE_ENDPOINT = var.env_short != "p" ? "https://api.${var.env}.platform.pagopa.it/shared/pdf-engine-node/v1/generate-pdf" : "https://api.platform.pagopa.it/shared/pdf-engine-node/v1/generate-pdf"
    ENABLE_ECS_CONSOLE                = "true"
    CONSOLE_LOG_THRESHOLD             = "DEBUG"
    CONSOLE_LOG_PATTERN               = "%d{HH:mm:ss.SSS}[%thread]%-5level%logger{36}-%msg%n"
    CONSOLE_LOG_CHARSET               = "UTF-8"
    OTEL_RESOURCE_ATTRIBUTES          = "service.name=pagopapdfengineotl,deployment.environment=uat"
    OTEL_EXPORTER_OTLP_ENDPOINT       = "http://otel-collector.elastic-system.svc:4317"
    OTEL_LOGS_EXPORTER                = "none"
    OTEL_TRACES_SAMPLER               = "always_on"
    JAVA_TOOL_OPTIONS                 = "-javaagent:/home/site/wwwroot/jmx_prometheus_javaagent-0.19.0.jar=12345:/home/site/wwwroot/config.yaml -javaagent:/home/site/wwwroot/opentelemetry-javaagent.jar"
    OTEL_EXPORTER_OTLP_HEADERS        = data.azurerm_key_vault_secret.elastic_otel_token_header.value
    PDF_ENGINE_NODE_SUBKEY            = data.azurerm_key_vault_secret.pdf_engine_node_subkey.value

  }

}
