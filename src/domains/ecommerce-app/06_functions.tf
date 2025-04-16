resource "azurerm_resource_group" "ecommerce_reporting_functions_rg" {
  name     = format("%s-fn-rg", local.project)
  location = var.location

  tags = var.tags
}

# Subnet to host ecommerce reporting function
module "ecommerce_reporting_functions_snet" {
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = "${local.project}-reporting-fn-snet"
  address_prefixes                              = [var.cidr_subnet_ecommerce_functions]
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Web",
    "Microsoft.Storage",
  ]

  delegation = {
    name = "default"
    service_delegation = {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}

module "ecommerce_reporting_function_app" {
  source = "./.terraform/modules/__v3__/function_app"

  resource_group_name = azurerm_resource_group.ecommerce_reporting_functions_rg.name
  name                = "${local.project}-reporting-fn"
  location            = var.location
  health_check_path   = "info"
  subnet_id           = module.ecommerce_reporting_functions_snet.id
  runtime_version     = "~4"

  always_on                                = var.ecommerce_function_always_on
  application_insights_instrumentation_key = data.azurerm_application_insights.application_insights.instrumentation_key

  app_service_plan_name = "${local.project}-plan-reporting-fn"
  app_service_plan_info = {
    kind                         = "Linux"
    worker_count                 = 4
    sku_tier                     = var.ecommerce_functions_app_sku.sku_tier
    sku_size                     = var.ecommerce_functions_app_sku.sku_size
    maximum_elastic_worker_count = 0
    zone_balancing_enabled       = true
  }

  storage_account_name = replace("pagopa-${var.env}-${var.location_short}-ecommtx-sa-fn", "-", "")

  app_settings = {
    linux_fx_version         = "JAVA|21"
    FUNCTIONS_WORKER_RUNTIME = "java"
  }

  allowed_subnets = [data.azurerm_subnet.apim_vnet.id]

  allowed_ips = []

  tags = var.tags
}