resource "azurerm_resource_group" "qa_hub_rg" {
  name     = "${local.project}-qa-hub-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "qa_hub_app_service" {
  source              = "./.terraform/modules/__v4__/IDH/app_service_webapp"
  env                 = var.env
  idh_resource_tier   = var.qa_hub_plan_idh_tier
  location            = var.location
  name                = "${local.project_short}-qa-hub-wa"
  product_name        = local.prefix
  resource_group_name = azurerm_resource_group.qa_hub_rg.name

  app_service_plan_name = "${local.project}-qa-hub-plan"
  app_settings = {

  }

  docker_image        = var.qa_hub_image.docker_image
  docker_image_tag    = var.qa_hub_image.docker_image_tag
  docker_registry_url = var.qa_hub_image.docker_registry_url

  tags = module.tag_config.tags
  # which subnet is allowed to reach this app service
  allowed_subnet_ids = []


  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.azurewebsites.id

  embedded_subnet = {
    enabled      = true
    vnet_name    = local.spoke_compute_vnet_name
    vnet_rg_name = local.spoke_compute_vnet_resource_group_name
  }

  # fixme configure the cidr list and service name allowed on this function
  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = "All"
    target_ports                 = ["*"]
    protocol                     = "Tcp"
  }

  autoscale_settings = var.qa_hub_autoscale_settings

  always_on = var.qa_hub_always_on
}
