data "azurerm_key_vault_secret" "vm_debug_ssh_user" {
  name         = "vm-debug-ssh-user"
  key_vault_id = data.azurerm_key_vault.kv_italy.id
}

data "azurerm_key_vault_secret" "vm_debug_ssh_pass" {
  name         = "vm-debug-ssh-pass"
  key_vault_id = data.azurerm_key_vault.kv_italy.id
}


# Creazione dell'interfaccia di rete
resource "azurerm_network_interface" "vm_debug_italy" {
  name                = "${local.project}-vm-debug-italy"
  location            = azurerm_resource_group.rg_aks.location
  resource_group_name = azurerm_resource_group.rg_aks.name

  ip_configuration {
    name                          = "aks-user-subnet"
    subnet_id                     = azurerm_subnet.user_aks_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Creazione della macchina virtuale
resource "azurerm_linux_virtual_machine" "vm_debug_italy" {
  name                            = "${local.project}-vm-debug-italy"
  resource_group_name             = azurerm_resource_group.rg_aks.name
  location                        = azurerm_resource_group.rg_aks.location
  size                            = "Standard_B2ms"
  admin_username                  = data.azurerm_key_vault_secret.vm_debug_ssh_user.value
  admin_password                  = data.azurerm_key_vault_secret.vm_debug_ssh_pass.value
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.vm_debug_italy.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

### TODO dev test is not avaible in Italy
# # Creazione della pianificazione di spegnimento automatico
# resource "azurerm_dev_test_global_vm_shutdown_schedule" "shutdown_schedule" {
#   location            = azurerm_resource_group.rg_aks.location
#   virtual_machine_id  = azurerm_linux_virtual_machine.vm_debug_italy.id
#   enabled             = true
#   daily_recurrence_time = "1900"
#   timezone              = "Central Europe Standard Time"
#   notification_settings {
#     enabled         = false
#   }
# }
