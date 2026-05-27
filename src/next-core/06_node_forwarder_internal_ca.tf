data "azurerm_key_vault_secret" "certificate_crt_node_forwarder_internal_ca" {
  name         = "certificate-crt-node-forwarder"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "certificate_key_node_forwarder_internal_ca" {
  name         = "certificate-key-node-forwarder"
  key_vault_id = module.key_vault.id
}

locals {
  node_forwarder_internal_ca_app_settings = {
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
    TIMEOUT_DELAY                                   = 300
    # Integration with private DNS (see more: https://docs.microsoft.com/en-us/answers/questions/85359/azure-app-service-unable-to-resolve-hostname-of-vi.html)
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_RUN_FROM_PACKAGE                        = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE                 = true
    # Spring Environment
    DEFAULT_LOGGING_LEVEL = var.node_forwarder_logging_level
    APP_LOGGING_LEVEL     = var.node_forwarder_logging_level
    JAVA_OPTS             = "" # "-Djavax.net.debug=ssl:handshake" // mTLS debug

    # Cert configuration
    CERTIFICATE_CRT = data.azurerm_key_vault_secret.certificate_crt_node_forwarder_internal_ca.value
    CERTIFICATE_KEY = data.azurerm_key_vault_secret.certificate_key_node_forwarder_internal_ca.value

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
    # WEBSITE_SWAP_WARMUP_PING_PATH       = "/actuator/health"
    # WEBSITE_SWAP_WARMUP_PING_STATUSES   = "200"

    # Connection Pool
    MAX_CONNECTIONS           = 120 #80
    MAX_CONNECTIONS_PER_ROUTE = 60  #40
    CONN_TIMEOUT              = 8
  }
}

resource "azurerm_resource_group" "node_forwarder_internal_ca_rg" {
  name     = format("%s-node-forw-internal-ca-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

module "node_forwarder_internal_ca_app_service" {
  source = "./.terraform/modules/__v4__/app_service"
  count  = 1

  vnet_integration    = true
  resource_group_name = azurerm_resource_group.node_forwarder_internal_ca_rg.name
  location            = var.location

  # App service plan vars
  plan_name = "${local.project}-plan-node-forw-internal-ca"

  # App service plan
  name                = "${local.project}-app-node-forw-internal-ca"
  client_cert_enabled = false
  always_on           = var.node_forwarder_always_on
  health_check_path   = "/actuator/info"
  app_settings        = local.node_forwarder_internal_ca_app_settings

  docker_image             = "pagopanodeforwarder"
  docker_image_tag         = var.node_forwarder_image_tag
  docker_registry_username = data.azurerm_container_registry.container_registry.admin_username
  docker_registry_password = data.azurerm_container_registry.container_registry.admin_password
  docker_registry_url      = "https://${data.azurerm_container_registry.container_registry.login_server}"

  allowed_subnets = []
  allowed_ips     = []

  public_network_access_enabled = false

  sku_name            = var.node_forwarder_sku
  minimum_tls_version = local.node_forwarder_min_tls_version

  ip_restriction_default_action = local.node_forwarder_ip_restriction_default_action

  subnet_id                    = var.is_feature_enabled.node_forwarder_ha_enabled ? module.node_forwarder_ha_snet[0].id : module.node_forwarder_snet[0].id
  health_check_maxpingfailures = local.node_forwarder_health_check_maxpingfailures

  zone_balancing_enabled = var.node_forwarder_zone_balancing_enabled

  tags = module.tag_config.tags
}

resource "azurerm_private_endpoint" "forwarder_internal_ca_input_private_endpoint" {

  name                = "${local.project}-node-forw-internal-ca-private-endpoint"
  location            = var.location
  resource_group_name = azurerm_resource_group.node_forwarder_internal_ca_rg.name
  subnet_id           = module.common_private_endpoint_snet.id

  private_dns_zone_group {
    name                 = "${local.project}-node-forw-internal-ca-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.appservice_private_dns.id]
  }

  private_service_connection {
    name                           = "${local.project}-node-forw-internal-ca-service-connection"
    private_connection_resource_id = module.node_forwarder_internal_ca_app_service[0].id
    is_manual_connection           = false
    subresource_names              = ["sites"]
  }

  tags = module.tag_config.tags
}

# KV placeholder for CERT and KEY certificate
#tfsec:ignore:azure-keyvault-ensure-secret-expiry tfsec:ignore:azure-keyvault-content-type-for-secret
resource "azurerm_key_vault_secret" "certificate_crt_node_forwarder_internal_ca" {
  name         = "certificate-crt-node-forw-internal-ca"
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
resource "azurerm_key_vault_secret" "certificate_key_node_forwarder_internal_ca" {
  name         = "certificate-key-node-forw-internal-ca"
  value        = "<TO_UPDATE_MANUALLY_BY_PORTAL>"
  content_type = "text/plain"

  key_vault_id = module.key_vault.id

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}