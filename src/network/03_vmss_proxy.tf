resource "azurerm_resource_group" "vmss_rg" {
  name     = format("%s-vmss-rg", local.project)
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_virtual_network" "vnet_integration" {
  name                = local.vnet_core_name
  resource_group_name = local.vnet_core_resource_group_name
}

module "vmss_snet" {
  source = "./.terraform/modules/__v4__/subnet"

  name                                          = format("%s-vmss-snet", local.project)
  address_prefixes                              = ["10.1.131.0/28"]
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_integration.name
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies_enabled     = false
}

module "vmss_pls_snet" {
  source = "./.terraform/modules/__v4__/subnet"

  name                                          = format("%s-vmss-pls-snet", local.project)
  address_prefixes                              = ["10.1.131.16/28"]
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_integration.name
  private_link_service_network_policies_enabled = true
  private_endpoint_network_policies_enabled     = false
}

data "azurerm_key_vault_secret" "vmss_admin_login" {
  name         = "vmss-administrator-login"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

data "azurerm_key_vault_secret" "vmss_admin_password" {
  name         = "vmss-administrator-password"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "azurerm_linux_virtual_machine_scale_set" "vmss-egress" {
  name                            = format("%s-vmss", local.project)
  resource_group_name             = azurerm_resource_group.vmss_rg.name
  location                        = azurerm_resource_group.vmss_rg.location
  sku                             = "Standard_D2ds_v5"
  instances                       = 1
  admin_username                  = data.azurerm_key_vault_secret.vmss_admin_login.value
  admin_password                  = data.azurerm_key_vault_secret.vmss_admin_password.value
  disable_password_authentication = false
  zones                           = ["1"]

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
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
      load_balancer_backend_address_pool_ids = [module.load_balancer_observ_egress.azurerm_lb_backend_address_pool_id[0]]
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
    "script" : "Y2F0IDw8J0VPRicgPiBpcF9md2Quc2gKIyEvYmluL2Jhc2gKCiMtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiMgQ29weXJpZ2h0IChjKSBNaWNyb3NvZnQgQ29ycG9yYXRpb24uIEFsbCByaWdodHMgcmVzZXJ2ZWQuCiMgTGljZW5zZWQgdW5kZXIgdGhlIE1JVCBMaWNlbnNlLiAKIy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCgp1c2FnZSgpIHsKCWVjaG8gLWUgIlxlWzMzbSIKCWVjaG8gInVzYWdlOiAkezB9IFstaSA8ZXRoX2ludGVyZmFjZT5dIFstZiA8ZnJvbnRlbmRfcG9ydD5dIFstYSA8ZGVzdF9pcF9hZGRyPl0gWy1iIDxkZXN0X3BvcnQ+XSIgMT4mMgoJZWNobyAid2hlcmU6IiAxPiYyCgllY2hvICI8ZXRoX2ludGVyZmFjZT46IEludGVyZmFjZSBvbiB3aGljaCBwYWNrZXQgd2lsbCBhcnJpdmUgYW5kIGJlIGZvcndhcmRlZCIgMT4mMgoJZWNobyAiPGZyb250ZW5kX3BvcnQ+OiBGcm9udGVuZCBwb3J0IG9uIHdoaWNoIHBhY2tldCBhcnJpdmVzIiAxPiYyCgllY2hvICI8ZGVzdF9wb3J0PiAgICA6IERlc3RpbmF0aW9uIHBvcnQgdG8gd2hpY2ggcGFja2V0IGlzIGZvcndhcmRlZCIgMT4mMgoJZWNobyAiPGRlc3RfaXBfYWRkcj4gOiBEZXN0aW5hdGlvbiBJUCB3aGljaCBwYWNrZXQgaXMgZm9yd2FyZGVkIiAxPiYyCgllY2hvIC1lICJcZVswbSIKfQoKaWYgW1sgJCMgLWVxIDAgXV07IHRoZW4KCWVjaG8gLWUgIlxlWzMxbUVSUk9SOiBubyBvcHRpb25zIGdpdmVuXGVbMG0iCgl1c2FnZQoJZXhpdCAxCmZpCndoaWxlIGdldG9wdHMgJ2k6ZjphOmI6JyBPUFRTOyBkbwoJY2FzZSAiJHtPUFRTfSIgaW4KCQlpKQoJCQllY2hvIC1lICJcZVszMm1Vc2luZyBldGhlcm5ldCBpbnRlcmZhY2UgJHtPUFRBUkd9XGVbMG0iCgkJCUVUSF9JRj0ke09QVEFSR30KCQkJOzsKCQlmKQoJCQllY2hvIC1lICJcZVszMm1Gcm9udGVuZCBwb3J0IGlzICR7T1BUQVJHfVxlWzBtIgoJCQlGRV9QT1JUPSR7T1BUQVJHfQoJCQk7OwoJCWEpCgkJCWVjaG8gLWUgIlxlWzMybURlc3RpbmF0aW9uIElQIEFkZHJlc3MgaXMgJHtPUFRBUkd9XGVbMG0iCgkJCURFU1RfSE9TVD0ke09QVEFSR30KCQkJOzsKCQliKQoJCQllY2hvIC1lICJcZVszMm1EZXN0aW5hdGlvbiBQb3J0IGlzICR7T1BUQVJHfVxlWzBtIgoJCQlERVNUX1BPUlQ9JHtPUFRBUkd9CgkJCTs7CgkJKikKCQkJdXNhZ2UKCQkJZXhpdCAxCgkJCTs7Cgllc2FjCmRvbmUKCmlmIFsgLXogJHtFVEhfSUZ9IF07IHRoZW4KCWVjaG8gLWUgIlxlWzMxbUVSUk9SOiBldGhlcm5ldCBpbnRlcmZhY2Ugbm90IHNwZWNpZmllZCEhIVxlWzBtIgoJdXNhZ2UKCWV4aXQgMQpmaQppZiBbIC16ICR7RkVfUE9SVH0gXTsgdGhlbgoJZWNobyAtZSAiXGVbMzFtRVJST1I6IGZyb250ZW5kIHBvcnQgbm90IHNwZWNpZmllZCEhIVxlWzBtIgoJdXNhZ2UKCWV4aXQgMQpmaQppZiBbIC16ICR7REVTVF9IT1NUfSBdOyB0aGVuCgllY2hvIC1lICJcZVszMW1FUlJPUjogZGVzdGluYXRpb24gSVAgbm90IHNwZWNpZmllZCEhIVxlWzBtIgoJdXNhZ2UKCWV4aXQgMQpmaQppZiBbIC16ICR7REVTVF9QT1JUfSBdOyB0aGVuCgllY2hvIC1lICJcZVszMW1FUlJPUjogZGVzdGluYXRpb24gcG9ydCBub3Qgc3BlY2lmaWVkISEhXGVbMG0iCgl1c2FnZQoJZXhpdCAxCmZpCgojMS4gTWFrZSBzdXJlIHlvdSdyZSByb290CmVjaG8gLWUgIlxlWzMybUNoZWNraW5nIHdoZXRoZXIgd2UncmUgcm9vdC4uLlxlWzBtIgppZiBbIC16ICR7VUlEfSBdOyB0aGVuCglVSUQ9JChpZCAtdSkKZmkKaWYgWyAiJHtVSUR9IiAhPSAiMCIgXTsgdGhlbgoJZWNobyAtZSAiXGVbMzFtRVJST1I6IHVzZXIgbXVzdCBiZSByb290XGVbMG0iCglleGl0IDEKZmkKCiMyLiBNYWtlIHN1cmUgSVAgRm9yd2FyZGluZyBpcyBlbmFibGVkIGluIHRoZSBrZXJuZWwKZWNobyAtZSAiXGVbMzJtRW5hYmxpbmcgSVAgZm9yd2FyZGluZy4uLlxlWzBtIgplY2hvICIxIiA+IC9wcm9jL3N5cy9uZXQvaXB2NC9pcF9mb3J3YXJkCgojMy4gQ2hlY2sgaWYgSVAgb3IgaG9zdG5hbWUgaXMgc3BlY2lmaWVkIGZvciBkZXN0aW5hdGlvbiBJUAppZiBbWyAke0RFU1RfSE9TVH0gPX4gXlswLTldK1wuWzAtOV0rXC5bMC05XStcLlswLTldKyQgXV07IHRoZW4KCURFU1RfSVA9JHtERVNUX0hPU1R9CmVsc2UKCURFU1RfSVA9JChob3N0ICR7REVTVF9IT1NUfSB8IGdyZXAgImhhcyBhZGRyZXNzIiB8IGF3ayAne3ByaW50ICRORn0nKQpmaQplY2hvIC1lICJcZVszMm1Vc2luZyBEZXN0aW5hdGlvbiBJUCAke0RFU1RfSVB9XGVbMG0iCgojNC4gR2V0IGxvY2FsIElQCkxPQ0FMX0lQPSQoaXAgYWRkciBscyAke0VUSF9JRn0gfCBncmVwIC13IGluZXQgfCBhd2sgJ3twcmludCAkMn0nIHwgYXdrIC1GLyAne3ByaW50ICQxfScpCmVjaG8gLWUgIlxlWzMybVVzaW5nIExvY2FsIElQICR7TE9DQUxfSVB9XGVbMG0iCgojNC4gRG8gRE5BVAplY2hvIC1lICJcZVszMm1DcmVhdGluZyBETkFUIHJ1bGUgZnJvbSAke0xPQ0FMX0lQfToke0ZFX1BPUlR9IHRvICR7REVTVF9JUH06JHtERVNUX1BPUlR9Li4uXGVbMG0iCmlwdGFibGVzIC10IG5hdCAtQSBQUkVST1VUSU5HIC1wIHRjcCAtaSAke0VUSF9JRn0gLS1kcG9ydCAke0ZFX1BPUlR9IC1qIEROQVQgLS10byAke0RFU1RfSVB9OiR7REVTVF9QT1JUfQoKIzQuIERvIFNOQVQKZWNobyAtZSAiXGVbMzJtQ3JlYXRpbmcgU05BVCBydWxlIGZyb20gJHtERVNUX0lQfToke0RFU1RfUE9SVH0gdG8gJHtMT0NBTF9JUH06JHtGRV9QT1JUfS4uLlxlWzBtIgojaXB0YWJsZXMgLXQgbmF0IC1BIFBPU1RST1VUSU5HIC1wIHRjcCAtbyAke0VUSF9JRn0gLS1kcG9ydCAke0RFU1RfUE9SVH0gLWogU05BVCAtZCAke0RFU1RfSVB9IC0tdG8tc291cmNlICR7TE9DQUxfSVB9OiR7RkVfUE9SVH0KaXB0YWJsZXMgLXQgbmF0IC1BIFBPU1RST1VUSU5HIC1vICR7RVRIX0lGfSAtaiBNQVNRVUVSQURFCmVjaG8gLWUgIlxlWzMybURvbmUhXGVbMG0iCkVPRgoKY2htb2QgK3ggaXBfZndkLnNoCnN1ZG8gLi9pcF9md2Quc2ggLWkgZXRoMCAtZiA1NDMyIC1hIGJjNmI0MTM1ODI2My5wcml2YXRlLnBvc3RncmVzLmRhdGFiYXNlLmF6dXJlLmNvbS4gLWIgNTQzMg=="
  })
}

#
# create load balancer (NVA) with tcp/0 ports
#
module "load_balancer_observ_egress" {
  source = "./.terraform/modules/__v4__/load_balancer"

  resource_group_name                    = local.vnet_resource_group_name
  location                               = var.location
  name                                   = format("%s-egress-lb", local.project)
  frontend_name                          = "frontend_private_ip"
  type                                   = "private"
  frontend_subnet_id                     = module.vmss_snet.id
  frontend_private_ip_address_allocation = "Static"
  frontend_private_ip_address            = "10.1.131.14"
  lb_sku                                 = "Standard"
  pip_sku                                = "Standard"
  lb_port = {
    lb_nodo = {
      frontend_port     = "0"
      protocol          = "All"
      backend_port      = "0"
      backend_pool_name = "default"
      probe_name        = "probe_ssh"
    }
  }

  lb_probe = {
    probe_ssh = {
      protocol     = "Tcp"
      port         = "22"
      request_path = ""
    }
  }

  tags = module.tag_config.tags

  depends_on = []
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
