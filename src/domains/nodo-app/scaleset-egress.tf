resource "azurerm_resource_group" "vmss_rg" {
  name     = format("%s-vmss-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_integration_name
  resource_group_name = local.vnet_resource_group_name
}

module "vmss_snet" {
  source = "./.terraform/modules/__v3__/subnet"

  name                                          = format("%s-vmss-snet", local.project)
  address_prefixes                              = var.cidr_subnet_vmss
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_integration.name
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies_enabled     = false
}

data "azurerm_key_vault_secret" "vmss_admin_login" {
  name         = "vmss-administrator-login"
  key_vault_id = data.azurerm_key_vault.kv.id
}

data "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-administrator-password"
  key_vault_id = data.azurerm_key_vault.kv.id
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss-egress" {
  name                            = format("%s-vmss", local.project)
  resource_group_name             = azurerm_resource_group.vmss_rg.name
  location                        = azurerm_resource_group.vmss_rg.location
  sku                             = "Standard_D4ds_v5"
  instances                       = var.vmss_instance_number
  admin_username                  = data.azurerm_key_vault_secret.vmss_admin_login.value
  admin_password                  = data.azurerm_key_vault_secret.vmss_admin_password.value
  disable_password_authentication = false
  zones                           = var.vmss_zones

  source_image_reference {
    publisher = "RedHat"
    offer     = "RHEL"
    sku       = "7.7"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name                          = "egress-input"
    primary                       = true
    enable_ip_forwarding          = true
    enable_accelerated_networking = true

    ip_configuration {
      name                                   = "egress-in"
      primary                                = true
      subnet_id                              = module.vmss_snet.id
      load_balancer_backend_address_pool_ids = [module.load_balancer_nodo_egress.azurerm_lb_backend_address_pool_id[0]]
    }
  }
  network_interface {
    name                          = "egress-output"
    enable_ip_forwarding          = true
    enable_accelerated_networking = true
    ip_configuration {
      name      = "egress-out"
      primary   = true
      subnet_id = module.vmss_snet.id
    }
  }
}

#
# vmss extension script network-config.sh
# N.B. vmss with private load balancer lost internet connection. script embedded in base64
#
resource "azurerm_virtual_machine_scale_set_extension" "vmss-extension" {
  name                         = "network-rule-forward"
  virtual_machine_scale_set_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
  publisher                    = "Microsoft.Azure.Extensions"
  type                         = "CustomScript"
  type_handler_version         = "2.0"
  settings = jsonencode({
    "script" : "c3VkbyBzeXNjdGwgbmV0LmlwdjQuaXBfZm9yd2FyZD0xCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtdCBuYXQgLUkgUE9TVFJPVVRJTkcgLW8gZXRoMCAtaiBNQVNRVUVSQURFCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtSSBGT1JXQVJEIC1pIGV0aDEgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtQSBGT1JXQVJEIC1pIGV0aDAgLW8gZXRoMSAtbSBzdGF0ZSAtLXN0YXRlIFJFTEFURUQsRVNUQUJMSVNIRUQgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtdCBuYXQgLUkgUE9TVFJPVVRJTkcgLW8gZXRoMSAtaiBNQVNRVUVSQURFCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtSSBGT1JXQVJEIC1pIGV0aDAgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcGVybWFuZW50IC0tZGlyZWN0IC0tcGFzc3Rocm91Z2ggaXB2NCAtQSBGT1JXQVJEIC1pIGV0aDEgLW8gZXRoMCAtbSBzdGF0ZSAtLXN0YXRlIFJFTEFURUQsRVNUQUJMSVNIRUQgLWogQUNDRVBUCnN1ZG8gZmlyZXdhbGwtY21kIC0tcmVsb2FkCg=="
  })
}

#
# create load balancer (NVA) with tcp/0 ports
#
module "load_balancer_nodo_egress" {
  source = "./.terraform/modules/__v3__/load_balancer"

  resource_group_name                    = local.vnet_resource_group_name
  location                               = var.location
  name                                   = format("%s-egress-lb", local.project)
  frontend_name                          = "frontend_private_ip"
  type                                   = "private"
  frontend_subnet_id                     = module.vmss_snet.id
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = var.lb_frontend_private_ip_address
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"
  lb_port = {
    lb_nodo = {
      frontend_port     = "0"
      protocol          = "All"
      backend_port      = "0"
      backend_pool_name = "default"
      probe_name        = "probe_nodo"
    }
  }

  lb_probe = {
    probe_nodo = {
      protocol     = "Tcp"
      port         = "22"
      request_path = ""
    }
  }

  tags = module.tag_config.tags

  depends_on = []
}

#
# create routing table from aks to external endpoint via load balancer NVA
#
module "route_table_peering_nexi" {
  source = "./.terraform/modules/__v3__/route_table"

  name                          = format("%s-aks-to-nexi-rt", local.project)
  location                      = var.location
  resource_group_name           = local.vnet_resource_group_name
  disable_bgp_route_propagation = false

  subnet_ids = [data.azurerm_subnet.aks_snet.id]

  routes = var.route_aks

  tags = module.tag_config.tags
}

#
# include VMSS subnet in primary route table on integration vnet
#
data "azurerm_route_table" "route_sia" {
  name                = format("%s-sia-rt", local.product)
  resource_group_name = local.vnet_resource_group_name
}

resource "azurerm_subnet_route_table_association" "snet_vmss_to_sia" {
  subnet_id      = module.vmss_snet.id
  route_table_id = data.azurerm_route_table.route_sia.id
}

resource "azurerm_monitor_autoscale_setting" "vmss-scale" {
  count               = var.env_short != "d" ? 1 : 0
  name                = format("%s-vmss-scale", local.project)
  resource_group_name = azurerm_resource_group.vmss_rg.name
  location            = azurerm_resource_group.vmss_rg.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.vmss-egress.id

  profile {
    name = format("%s-vmss-scale-rule-cpu", local.project)

    capacity {
      default = 1
      minimum = 1
      maximum = 3
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.vmss-egress.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 20
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }

}
