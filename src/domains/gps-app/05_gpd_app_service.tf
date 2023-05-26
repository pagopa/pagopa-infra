data "azurerm_resource_group" "gpd_rgroup" {
  name = format("%s-gpd-rg", local.product)
}

# gpd service plan
resource "azurerm_app_service_plan" "gpd_service_plan" {
  name                = format("%s-plan-gpd", local.product)
  location            = var.location
  resource_group_name = data.azurerm_resource_group.gpd_rgroup.name

  kind     = var.gpd_plan_kind
  reserved = var.gpd_plan_kind == "Linux" ? true : false

  sku {
    tier = var.gpd_plan_sku_tier
    size = var.gpd_plan_sku_size
  }

  tags = var.tags
}

# Subnet to host the api config
module "gpd_snet" {
  count                                     = var.cidr_subnet_gpd != null ? 1 : 0
  source                                    = "git::https://github.com/pagopa/terraform-azurerm-v3//subnet?ref=v6.11.2"
  name                                      = format("%s-gpd-snet", local.product)
  address_prefixes                          = var.cidr_subnet_gpd
  resource_group_name                       = local.vnet_resource_group_name
  virtual_network_name                      = local.vnet_name
  private_endpoint_network_policies_enabled = false

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "gpd_app_service" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3//app_service?ref=v6.11.2"

  vnet_integration    = true
  resource_group_name = data.azurerm_resource_group.gpd_rgroup.name
  plan_type           = "external"
  plan_id             = azurerm_app_service_plan.gpd_service_plan.id

  # App service
  name                = format("%s-app-gpd", local.product)
  client_cert_enabled = false
  always_on           = var.gpd_always_on
  java_version        = 11
  health_check_path   = "/info"

  app_settings    = local.gpd_app_settings
  allowed_subnets = local.gpd_allowed_subnets
  allowed_ips     = []
  subnet_id       = module.gpd_snet[0].id
  tags            = var.tags
}

module "gpd_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3//app_service_slot?ref=v6.11.2"

  # App service plan
  app_service_id   = module.gpd_app_service.id
  app_service_name = module.gpd_app_service.name

  # App service
  name                = "staging"
  resource_group_name = data.azurerm_resource_group.gpd_rgroup.name
  location            = var.location

  always_on = true
  #linux_fx_version  = format("DOCKER|%s/api-gpd-backend:%s", data.azurerm_container_registry.acr.login_server, "latest")
  health_check_path = "/info"

  # App settings
  app_settings    = local.gpd_app_settings
  allowed_subnets = local.gpd_allowed_subnets
  allowed_ips     = []
  subnet_id       = module.gpd_snet[0].id
  tags            = var.tags
}

resource "azurerm_monitor_autoscale_setting" "gpd_app_service_autoscale" {
  name                = format("%s-autoscale-gpd", local.product)
  resource_group_name = data.azurerm_resource_group.gpd_rgroup.name
  location            = var.location
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
        threshold                = 3000
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
        threshold                = 2500
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
