module "lb_snet" {
  source               = "git::https://github.com/pagopa/azurerm.git//subnet?ref=v1.0.51"
  name                 = format("%s-lb-snet", local.project)
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet_integration.name
  address_prefixes     = var.cidr_subnet_lb

  enforce_private_link_endpoint_network_policies = true
  service_endpoints                              = ["Microsoft.Web"]
}

locals {
  lb_be_ips = [
    for s in var.lb_backend_pool_ips :
    {
      ip      = s
      vnet_id = module.vnet_integration.id
    }
  ]

}



module "integration_lb" {
  count                                  = var.lb_enabled && var.cidr_subnet_lb != null ? 1 : 0
  source                                 = "git::https://github.com/pagopa/azurerm.git//load_balancer?ref=v1.0.83"
  name                                   = format("%s-lb-integration", local.project)
  resource_group_name                    = azurerm_resource_group.rg_vnet.name
  location                               = var.location
  type                                   = "private"
  frontend_subnet_id                     = module.lb_snet.id
  frontend_private_ip_address_allocation = "Dynamic"
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard" #`pip_sku` must match `lb_sku`

  lb_backend_pools = [
    {
      name = "db-nodo-sia"
      ips  = local.lb_be_ips
    }
  ]

  lb_port = {
    db-nodo-sia = {
      frontend_port     = "1521"
      protocol          = "Tcp"
      backend_port      = "1521",
      backend_pool_name = "db-nodo-sia"
      probe_name        = "tcp-1521"
    }
  }

  lb_probe = {
    tcp-1521 = {
      protocol     = "Tcp"
      port         = "1521"
      request_path = ""
    }
  }

  tags = var.tags
}
