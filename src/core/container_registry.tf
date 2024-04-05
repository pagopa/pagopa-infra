resource "azurerm_resource_group" "container_registry_rg" {
  name     = format("%s-container-registry-rg", local.project)
  location = var.location

  tags = var.tags
}

module "container_registry" {
  source                        = "git::https://github.com/pagopa/terraform-azurerm-v3.git//container_registry?ref=v7.76.0"
  name                          = replace(format("%s-common-acr", local.project), "-", "")
  sku                           = var.env_short != "d" ? "Premium" : "Basic"
  resource_group_name           = azurerm_resource_group.container_registry_rg.name
  admin_enabled                 = true # TODO to change ...
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = var.env_short == "p" ? true : false
  public_network_access_enabled = true
  location                      = var.location

  private_endpoint = {
    enabled              = false
    private_dns_zone_ids = []
    subnet_id            = null
    virtual_network_id   = null
  }

  network_rule_set = [{
    default_action  = "Allow"
    ip_rule         = []
    virtual_network = []
  }]

  tags = var.tags
}
