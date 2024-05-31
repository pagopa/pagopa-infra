// todo: remove and destroy
locals {
  authorizer_functions_app_settings = {
    linux_fx_version                    = "JAVA|11"
    FUNCTIONS_WORKER_RUNTIME            = "java"
    FUNCTIONS_WORKER_PROCESS_COUNT      = 4
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITE_ENABLE_SYNC_UPDATE_SITE     = true

    DOCKER_REGISTRY_SERVER_URL = "ghcr.io"
    IMAGE_NAME                 = "pagopa/pagopa-platform-authorizer"

    COSMOS_CONN_STRING                    = data.azurerm_key_vault_secret.authorizer_cosmos_connection_string.value
    REFRESH_CONFIGURATION_PATH            = data.azurerm_key_vault_secret.authorizer_refresh_configuration_url.value
    APICONFIG_SELFCARE_INTEGRATION_PATH   = data.azurerm_key_vault_secret.apiconfig_selfcare_integration_url.value
    APICONFIG_SELFCARE_INTEGRATION_SUBKEY = data.azurerm_key_vault_secret.apiconfig_selfcare_integration_subkey.value
    RETRY_NUMBER                          = 4
    STARTING_RETRY_DELAY_MILLIS           = 1500

    EC_SQL_QUERY             = "SELECT VALUE i FROM c JOIN i IN c.authorization WHERE c.domain = {domain}"
    IS_EC_ENROLLED_SQL_QUERY = "SELECT VALUE COUNT(i) FROM c JOIN i IN c.authorization WHERE c.domain = {domain} AND ARRAY_CONTAINS(c.authorization, {organizationFiscalCode})"
  }
}
// todo: remove and destroy
# Subnet to host authorizer function
module "authorizer_functions_snet" {
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v6.6.0"
  name                                      = "${local.project}-authorizer-fn-snet"
  address_prefixes                          = [var.cidr_subnet_authorizer_functions]
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = data.azurerm_virtual_network.vnet.name
  private_endpoint_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Web",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
// todo: remove and destroy
data "azurerm_resource_group" "shared_rg" {
  name = "${local.project}-rg"
}
// todo: remove and destroy
module "authorizer_function_app" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app?ref=v7.29.0"

  resource_group_name                      = data.azurerm_resource_group.shared_rg.name
  name                                     = "${local.project}-authorizer-fn"
  location                                 = var.location
  health_check_path                        = "/info"
  subnet_id                                = module.authorizer_functions_snet.id
  runtime_version                          = "~4"
  system_identity_enabled                  = true
  always_on                                = var.authorizer_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  # App settings
  app_settings = local.authorizer_functions_app_settings

  docker = {
    registry_url      = local.authorizer_functions_app_settings.DOCKER_REGISTRY_SERVER_URL
    image_name        = local.authorizer_functions_app_settings.IMAGE_NAME
    image_tag         = "latest"
    registry_username = null
    registry_password = null
  }

  sticky_connection_string_names = ["COSMOS_CONN_STRING", "COSMOS_CONNection_STRING"]
  client_certificate_mode        = "Optional"


  cors = {
    allowed_origins = []
  }

  app_service_plan_name = "${local.project}-plan-authorizer-fn"
  app_service_plan_info = {
    kind                         = var.authorizer_functions_app_sku.kind
    sku_size                     = var.authorizer_functions_app_sku.sku_size
    maximum_elastic_worker_count = 0
    worker_count                 = 1
    zone_balancing_enabled       = false
  }

  storage_account_name = replace(format("%s-auth-st", local.project), "-", "")
  storage_account_info = {
    account_kind                      = "StorageV2"
    account_tier                      = "Standard"
    account_replication_type          = var.function_app_storage_account_replication_type
    access_tier                       = "Hot"
    advanced_threat_protection_enable = true
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id, data.azurerm_subnet.apim_v2_snet.id]

  allowed_ips = []

  tags = var.tags
}
// todo: remove and destroy
module "authorizer_function_app_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//function_app_slot?ref=v6.9.0"

  app_service_plan_id                      = module.authorizer_function_app.app_service_plan_id
  function_app_id                          = module.authorizer_function_app.id
  storage_account_name                     = module.authorizer_function_app.storage_account_name
  storage_account_access_key               = module.authorizer_function_app.storage_account.primary_access_key
  name                                     = "staging"
  resource_group_name                      = data.azurerm_resource_group.shared_rg.name
  location                                 = var.location
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key
  always_on                                = var.authorizer_function_always_on
  health_check_path                        = "/info"
  runtime_version                          = "~4"
  subnet_id                                = module.authorizer_functions_snet.id

  # App settings
  app_settings = local.authorizer_functions_app_settings

  docker = {
    registry_url      = local.authorizer_functions_app_settings.DOCKER_REGISTRY_SERVER_URL
    image_name        = local.authorizer_functions_app_settings.IMAGE_NAME
    image_tag         = "latest"
    registry_username = null
    registry_password = null
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id, data.azurerm_subnet.apim_v2_snet.id]
  allowed_ips     = []

  tags = var.tags
}
// todo: remove and destroy
resource "azurerm_monitor_autoscale_setting" "authorizer_function" {
  count = var.env_short != "d" ? 1 : 0

  name                = "${module.authorizer_function_app.name}-autoscale"
  resource_group_name = data.azurerm_resource_group.shared_rg.name
  location            = var.location
  target_resource_id  = module.authorizer_function_app.app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.authorizer_functions_autoscale.default
      minimum = var.authorizer_functions_autoscale.minimum
      maximum = var.authorizer_functions_autoscale.maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.authorizer_function_app.id
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
        metric_resource_id       = module.authorizer_function_app.id
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
// todo: remove and destroy
data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = local.acr_resource_group_name
}

