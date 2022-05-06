resource "azurerm_resource_group" "container_registry_rg" {
  name     = format("%s-container-registry-rg", local.project)
  location = var.location

  tags = var.tags
}

module "container_registry" {
  source                        = "git::https://github.com/pagopa/azurerm.git//container_registry?ref=v2.14.1"
  name                          = replace(format("%s-common-acr", local.project), "-", "")
  sku                           = var.env_short == "p" ? "Premium" : "Basic"
  resource_group_name           = azurerm_resource_group.container_registry_rg.name
  admin_enabled                 = false
  anonymous_pull_enabled        = false
  zone_redundancy_enabled       = true
  public_network_access_enabled = false
  location                      = var.location

  private_endpoint = {
    enabled              = var.env_short == "p" ? true : false
    private_dns_zone_ids =  var.env_short == "p" ?  [azurerm_private_dns_zone.privatelink_azurecr_pagopa.id] : false
 // subnet_id            = 
    virtual_network_id   = azurerm_resource_group.rg_vnet.name
  }

  tags = var.tags
}
