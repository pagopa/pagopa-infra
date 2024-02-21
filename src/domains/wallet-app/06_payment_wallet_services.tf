locals {

  payment_wallet_services_app_settings = {
    WEBSITE_ADD_SITENAME_BINDINGS_IN_APPHOST_CONFIG = "1"
    WEBSITE_VNET_ROUTE_ALL                          = "1"
    WEBSITE_DNS_SERVER                              = "168.63.129.16"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE                 = true

    WEBSITES_ENABLE_APP_SERVICE_STORAGE = false
    WEBSITES_PORT                       = 8080
  }
}

resource "azurerm_resource_group" "payment_wallet_services_rg" {
  name     = "${local.product}-${var.location_short}-payment-wallet-services-rg"
  location = var.location
  tags     = var.tags
}

# payment wallet service plan for app service and functions
resource "azurerm_service_plan" "payment_wallet_app_service_plan" {
  name                = "${local.product}-${var.location_short}-plan-payment-wallet"
  resource_group_name = azurerm_resource_group.payment_wallet_services_rg.name
  location            = var.location

  os_type  = "Linux"
  sku_name = var.payment_wallet_app_service_sku_name

  tags = var.tags
}

# payment wallet service for CRUD on wallet document
module "payment_wallet_app_service" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service?ref=v7.52.0"

  name                = "${local.product}-${var.location_short}-app-payment-wallet"
  resource_group_name = azurerm_resource_group.payment_wallet_services_rg.name
  location            = var.location

  plan_id   = azurerm_service_plan.payment_wallet_app_service_plan.id
  plan_type = "external"

  always_on         = true
  health_check_path = "/actuator/info"

  app_settings = local.payment_wallet_services_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  subnet_id = module.payment_wallet_services_snet.id

  tags = var.tags
}

module "payment_wallet_app_service_slot_staging" {
  count = var.env_short == "p" ? 1 : 0

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//app_service_slot?ref=v7.52.0"

  app_service_id   = module.payment_wallet_app_service.id
  app_service_name = module.payment_wallet_app_service.name

  name                = "staging"
  resource_group_name = azurerm_resource_group.payment_wallet_services_rg.name
  location            = var.location

  always_on         = true
  health_check_path = "/actuator/info"

  app_settings = local.payment_wallet_services_app_settings

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]
  allowed_ips     = []

  subnet_id = module.payment_wallet_services_snet.id

  tags = var.tags
}

resource "azurerm_monitor_autoscale_setting" "payment_wallet_app_service_autoscale" {
  name                = "${local.product}-${var.location_short}-app-payment-wallet"
  resource_group_name = azurerm_resource_group.payment_wallet_services_rg.name
  location            = var.location
  target_resource_id  = azurerm_service_plan.payment_wallet_app_service_plan.id

  profile {
    name = "default"
    # TODO tuning
    capacity {
      default = 1
      minimum = 1
      maximum = 2
    }

    rule {
      metric_trigger {
        metric_name              = "Requests"
        metric_resource_id       = module.payment_wallet_app_service.id
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
        metric_resource_id       = module.payment_wallet_app_service.id
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
        cooldown  = "PT20M"
      }
    }
  }
}