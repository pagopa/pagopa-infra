resource "azurerm_resource_group" "container_registry_rg" {
  name     = format("%s-container-registry-rg", local.product)
  location = var.location

  tags = module.tag_config.tags
}

module "container_registry" {
  source                        = "./.terraform/modules/__v4__/container_registry"
  name                          = replace(format("%s-common-acr", local.product), "-", "")
  sku                           = var.env_short != "d" ? "Premium" : "Basic"
  resource_group_name           = azurerm_resource_group.container_registry_rg.name
  admin_enabled                 = true # TODO to change ...
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = var.env_short == "p" ? true : false
  public_network_access_enabled = true
  location                      = var.location


  private_endpoint_enabled = false


  network_rule_set = [{
    default_action  = "Allow"
    ip_rule         = []
    virtual_network = []
  }]

  tags = module.tag_config.tags
}
