resource "azurerm_resource_group" "acr_ita_rg" {
  name     = "${local.product_ita}-acr-rg"
  location = var.location

  tags = module.tag_config.tags
}

module "container_registry_ita" {
  source = "./.terraform/modules/__v3__/container_registry"

  name                = replace("${local.project}-acr", "-", "")
  resource_group_name = azurerm_resource_group.acr_ita_rg.name
  location            = azurerm_resource_group.acr_ita_rg.location

  sku                           = var.container_registry_sku
  zone_redundancy_enabled       = var.container_registry_zone_redundancy_enabled
  public_network_access_enabled = true
  private_endpoint_enabled      = false

  admin_enabled          = true
  anonymous_pull_enabled = false

  network_rule_set = [{
    default_action  = "Allow"
    ip_rule         = []
    virtual_network = []
  }]

  tags = module.tag_config.tags
}
