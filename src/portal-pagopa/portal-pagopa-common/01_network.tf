module "portal_app_subnet" {
  source = "./.terraform/modules/__v4__/IDH/subnet"
  name   = "${local.project}-app-snet"

  resource_group_name  = data.azurerm_resource_group.rg_vnet.name
  virtual_network_name = "${local.product}-${var.location_short}-spoke-tools-vnet"

  idh_resource_tier = "app_service"
  product_name      = var.prefix
  env               = var.env

  service_endpoints = ["Microsoft.Storage"]
  tags              = module.tag_config.tags
}
