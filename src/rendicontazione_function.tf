resource "azurerm_resource_group" "reporting_rg" {
  name     = format("%s-reporting-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host reporting_batch function
module "reporting_batch_function_snet" {
  count                                          = var.cidr_subnet_reporting_batch != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-batch-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_batch
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

## Function reporting_batch
module "reporting_batch_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.reporting_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "batch"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.reporting_batch_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.reporting_batch_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  # worker_runtime                           = "java"
  # linux_fx_version  =  format("DOCKER|%s/reporting-batch:%s", module.acr[0].login_server, "latest")


  app_service_plan_info = {
    kind                         = var.reporting_batch_function_kind
    sku_tier                     = var.reporting_batch_function_sku_tier
    sku_size                     = var.reporting_batch_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = azurerm_storage_account.flows.primary_connection_string
    PAA_ID_INTERMEDIARIO      = var.paa_id_intermediario
    PAA_STAZIONE_INT          = var.paa_id_stazione
    PAA_PASSWORD              = var.paa_password
    FLOWS_TABLE               = azurerm_storage_table.flow.name
    FLOWS_QUEUE               = azurerm_storage_queue.flow.name

    # KEY                       = data.azurerm_key_vault_certificate_data.broker_cert.key
    # KEY_PKCS8                 = data.azurerm_key_vault_secret.broker_key.value
    # # the certificate PEM contains all chain, the first one is the leaf certicate we should use for broker
    # CERT                 = split("\n-----BEGIN CERTIFICATE-----", data.azurerm_key_vault_certificate_data.broker_cert.pem)[0]

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}


# Subnet to host reporting_service function
module "reporting_service_function_snet" {
  count                                          = var.cidr_subnet_reporting_service != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-reporting-service-snet", local.project)
  address_prefixes                               = var.cidr_subnet_reporting_service
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

## Function reporting_service
module "reporting_service_function" {
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.reporting_rg.name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "service"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.reporting_service_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.reporting_service_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key
  # worker_runtime                           = "java"
  # linux_fx_version  =  format("DOCKER|%s/reporting-service:%s", module.acr[0].login_server, "latest")


  app_service_plan_info = {
    kind                         = var.reporting_service_function_kind
    sku_tier                     = var.reporting_service_function_sku_tier
    sku_size                     = var.reporting_service_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    // Keepalive fields are all optionals
    FETCH_KEEPALIVE_ENABLED             = "true"
    FETCH_KEEPALIVE_SOCKET_ACTIVE_TTL   = "110000"
    FETCH_KEEPALIVE_MAX_SOCKETS         = "40"
    FETCH_KEEPALIVE_MAX_FREE_SOCKETS    = "10"
    FETCH_KEEPALIVE_FREE_SOCKET_TIMEOUT = "30000"
    FETCH_KEEPALIVE_TIMEOUT             = "60000"

    # custom configuration
    FLOW_SA_CONNECTION_STRING = azurerm_storage_account.flows.primary_connection_string
    PAA_ID_INTERMEDIARIO      = var.paa_id_intermediario
    PAA_STAZIONE_INT          = var.paa_id_stazione
    PAA_PASSWORD              = var.paa_password
    FLOWS_QUEUE               = azurerm_storage_queue.flow.name
    OPTIONS_QUEUE             = azurerm_storage_queue.option.name
    FLOWS_XML_BLOB            = azurerm_storage_container.flow.name
    # PAYMENTS_HOST             = format("https://%s", module.payments.default_site_hostname)
    AUX_DIGIT = 3

    # KEY                       = data.azurerm_key_vault_certificate_data.broker_cert.key
    # KEY_PKCS8                 = data.azurerm_key_vault_secret.broker_key.value
    # # the certificate PEM contains all chain, the first one is the leaf certicate we should use for broker
    # CERT                 = split("\n-----BEGIN CERTIFICATE-----", data.azurerm_key_vault_certificate_data.broker_cert.pem)[0]

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    # ACR
    DOCKER_REGISTRY_SERVER_URL      = "https://${module.acr[0].login_server}"
    DOCKER_REGISTRY_SERVER_USERNAME = module.acr[0].admin_username
    DOCKER_REGISTRY_SERVER_PASSWORD = module.acr[0].admin_password
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

## Storage Account
resource "azurerm_storage_account" "flows" {
  name                      = replace(format("%s-flow-sa", local.project), "-", "")
  resource_group_name       = azurerm_resource_group.reporting_rg.name
  location                  = var.location
  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"
  account_tier              = "Standard"

  account_replication_type = "LRS"

  tags = var.tags
}


## table storage
resource "azurerm_storage_table" "flow" {
  name                 = format("%stable", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## queue storage flows
resource "azurerm_storage_queue" "flow" {
  name                 = format("%squeueflow", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## queue storage flows
resource "azurerm_storage_queue" "option" {
  name                 = format("%squeueoption", azurerm_storage_account.flows.name)
  storage_account_name = azurerm_storage_account.flows.name
}

## blob container flows
resource "azurerm_storage_container" "flow" {
  name                  = format("%scontflow", azurerm_storage_account.flows.name)
  storage_account_name  = azurerm_storage_account.flows.name
  container_access_type = "private"
}
