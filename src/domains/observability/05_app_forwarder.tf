locals {

  app_forwarder_app_settings = {
    # Monitoring
    # APPINSIGHTS_INSTRUMENTATIONKEY                  = azurerm_application_insights.application_insights.instrumentation_key
    # APPLICATIONINSIGHTS_CONNECTION_STRING           = format("InstrumentationKey=%s", azurerm_application_insights.application_insights.instrumentation_key)
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
    # Spring Environment
    DEFAULT_LOGGING_LEVEL = "INFO"
    APP_LOGGING_LEVEL     = "INFO"
    JAVA_OPTS             = "-Djavax.net.debug=ssl:handshake" // mTLS debug

    # Cert configuration
    CERTIFICATE_CRT = var.app_forwarder_enabled ? data.azurerm_key_vault_secret.certificate_crt_app_forwarder[0].value : ""
    CERTIFICATE_KEY = var.app_forwarder_enabled ? data.azurerm_key_vault_secret.certificate_key_app_forwarder[0].value : ""

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"


    # Connection Pool
    MAX_CONNECTIONS           = 80
    MAX_CONNECTIONS_PER_ROUTE = 40
    CONN_TIMEOUT              = 8

  }


}

// kv shared
data "azurerm_key_vault" "kv_shared" {
  name                = "pagopa-${var.env_short}-shared-kv"
  resource_group_name = "pagopa-${var.env_short}-shared-sec-rg"
}


# Subnet to host the node forwarder

data "azurerm_resource_group" "rg_node_forwarder" {
  name = "pagopa-${var.env_short}-node-forwarder-rg"
}

data "azurerm_subnet" "subnet_node_forwarder" {
  count = var.app_forwarder_enabled ? 1 : 0

  name                 = "pagopa-${var.env_short}-node-forwarder-snet"
  virtual_network_name = "pagopa-${var.env_short}-vnet"
  resource_group_name  = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_subnet" "subnet_apim" {
  name                 = "pagopa-${var.env_short}-apim-snet"
  virtual_network_name = "pagopa-${var.env_short}-vnet-integration"
  resource_group_name  = "pagopa-${var.env_short}-vnet-rg"
}

data "azurerm_container_registry" "acr" {
  name                = "pagopa${var.env_short}commonacr"
  resource_group_name = "pagopa-${var.env_short}-container-registry-rg"
}


module "app_forwarder_app_service" {
  count = var.app_forwarder_enabled ? 1 : 0

  source = "./.terraform/modules/__v4__/app_service"

  vnet_integration    = false
  resource_group_name = data.azurerm_resource_group.rg_node_forwarder.name
  location            = var.location

  ip_restriction_default_action = var.app_forwarder_ip_restriction_default_action

  # App service plan vars
  plan_name = format("%s-plan-app-forwarder", local.project)
  sku_name  = "S1"

  docker_registry_url = "https://${data.azurerm_container_registry.acr.login_server}"
  docker_registry_username = data.azurerm_container_registry.acr.admin_username
  docker_registry_password = data.azurerm_container_registry.acr.admin_password

  # App service plan
  name                = format("%s-app-app-forwarder", local.project)
  client_cert_enabled = false
  always_on           = true
  docker_image        = "${data.azurerm_container_registry.acr.login_server}/pagopanodeforwarder"
  docker_image_tag    = "latest"
  # linux_fx_version    = format("DOCKER|%s/pagopanodeforwarder:%s", data.azurerm_container_registry.acr.login_server, "latest")
  health_check_path = "/actuator/info"
  health_check_maxpingfailures = 10

  minimum_tls_version = "1.2"

  app_settings = local.app_forwarder_app_settings

  allowed_subnets = [data.azurerm_subnet.subnet_apim.id]
  allowed_ips     = []

  subnet_id = data.azurerm_subnet.subnet_node_forwarder[0].id

  tags = module.tag_config.tags
}

module "app_forwarder_slot_staging" {
  count = var.app_forwarder_enabled ? 1 : 0

  source = "./.terraform/modules/__v4__/app_service_slot"

  # App service plan
  app_service_id   = module.app_forwarder_app_service[0].id
  app_service_name = module.app_forwarder_app_service[0].name


  # App service
  name                = "staging"
  resource_group_name = data.azurerm_resource_group.rg_node_forwarder.name
  location            = var.location
  always_on           = true
  # linux_fx_version    = format("DOCKER|%s/pagopanodeforwarder:%s", module.container_registry.login_server, "latest")
  docker_image      = "${data.azurerm_container_registry.acr.login_server}/pagopanodeforwarder"
  docker_registry_url = "https://${data.azurerm_container_registry.acr.login_server}"
  docker_registry_username = data.azurerm_container_registry.acr.admin_username
  docker_registry_password = data.azurerm_container_registry.acr.admin_password
  docker_image_tag  = "latest"
  health_check_path = "/actuator/info"

  minimum_tls_version = "1.2"

  health_check_maxpingfailures = 10

  # App settings
  app_settings = local.app_forwarder_app_settings

  allowed_subnets = [data.azurerm_subnet.subnet_apim.id]
  allowed_ips     = []
  subnet_id       = data.azurerm_subnet.subnet_node_forwarder[0].id

  tags = module.tag_config.tags
}


# KV placeholder for CERT and KEY certificate
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_crt_app_forwarder_s" {
  count = var.app_forwarder_enabled ? 1 : 0

  name         = "certificate-crt-app-forwarder"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_shared.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_key_app_forwarder_s" {
  count = var.app_forwarder_enabled ? 1 : 0

  name         = "certificate-key-app-forwarder"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = data.azurerm_key_vault.kv_shared.id


  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

data "azurerm_key_vault_secret" "certificate_crt_app_forwarder" {
  count = var.app_forwarder_enabled ? 1 : 0

  name         = "certificate-crt-app-forwarder"
  key_vault_id = data.azurerm_key_vault.kv_shared.id

}
data "azurerm_key_vault_secret" "certificate_key_app_forwarder" {
  count = var.app_forwarder_enabled ? 1 : 0

  name         = "certificate-key-app-forwarder"
  key_vault_id = data.azurerm_key_vault.kv_shared.id

}

