resource "azurerm_resource_group" "buyerbanks_rg" {
  count    = var.buyerbanks_enabled ? 1 : 0
  name     = format("%s-buyerbanks-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host buyerbanks function
module "buyerbanks_function_snet" {
  count                                          = var.buyerbanks_enabled && var.cidr_subnet_buyerbanks != null ? 1 : 0
  source                                         = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                                           = format("%s-buyerbanks-snet", local.project)
  address_prefixes                               = var.cidr_subnet_buyerbanks
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

module "buyerbanks_function" {
  count  = var.buyerbanks_enabled ? 1 : 0
  source = "git::https://github.com/pagopa/azurerm.git//function_app?ref=v1.0.84"

  resource_group_name                      = azurerm_resource_group.buyerbanks_rg[0].name
  prefix                                   = var.prefix
  env_short                                = var.env_short
  name                                     = "buyerbanks"
  location                                 = var.location
  health_check_path                        = "info"
  subnet_out_id                            = module.buyerbanks_function_snet[0].id
  runtime_version                          = "~3"
  always_on                                = var.checkout_function_always_on
  application_insights_instrumentation_key = azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_info = {
    kind                         = var.buyerbanks_function_kind
    sku_tier                     = var.buyerbanks_function_sku_tier
    sku_size                     = var.buyerbanks_function_sku_size
    maximum_elastic_worker_count = 0
  }

  app_settings = {
    FUNCTIONS_WORKER_RUNTIME        = "node"
    WEBSITE_NODE_DEFAULT_VERSION    = "14.16.0"
    FUNCTIONS_WORKER_PROCESS_COUNT  = 4
    NODE_ENV                        = "production"
    BUYERBANKS_SA_CONNECTION_STRING = module.buyerbanks_storage[0].primary_connection_string
    BUYERBANKS_BLOB_CONTAINER       = azurerm_storage_container.banks[0].name
  }

  allowed_subnets = [module.apim_snet.id]

  allowed_ips = []

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "buyerbanks_function" {
  count = var.buyerbanks_enabled ? 1 : 0

  name                = format("%s-%s-autoscale", local.project, module.buyerbanks_function[0].name)
  resource_group_name = azurerm_resource_group.buyerbanks_rg[0].name
  location            = var.location
  target_resource_id  = module.buyerbanks_function[0].app_service_plan_id

  profile {
    name = "default"

    capacity {
      default = var.buyerbanks_function_autoscale_default
      minimum = var.buyerbanks_function_autoscale_minimum
      maximum = var.buyerbanks_function_autoscale_maximum
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.buyerbanks_function[0].id
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
        metric_resource_id       = module.buyerbanks_function[0].id
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

#tfsec:ignore:azure-storage-default-action-deny
module "buyerbanks_storage" {
  count = var.buyerbanks_enabled ? 1 : 0

  source = "git::https://github.com/pagopa/azurerm.git//storage_account?ref=v2.0.13"

  name                       = replace(format("%s-buyerbanks-storage", local.project), "-", "")
  account_kind               = "StorageV2"
  account_tier               = "Standard"
  account_replication_type   = "LRS"
  access_tier                = "Hot"
  versioning_name            = "versioning"
  enable_versioning          = var.buyerbanks_enable_versioning
  resource_group_name        = azurerm_resource_group.buyerbanks_rg[0].name
  location                   = var.location
  advanced_threat_protection = var.buyerbanks_advanced_threat_protection
  allow_blob_public_access   = false

  blob_properties_delete_retention_policy_days = var.buyerbanks_delete_retention_days

  tags = var.tags
}

## blob container buyerbanks 
resource "azurerm_storage_container" "banks" {
  count = var.buyerbanks_enabled ? 1 : 0

  name                  = "banks"
  storage_account_name  = module.buyerbanks_storage[0].name
  container_access_type = "private"
}