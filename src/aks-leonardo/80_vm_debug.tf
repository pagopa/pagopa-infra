

resource "azurerm_linux_virtual_machine" "vm_debug" {
  name                = "${local.product_location}-aks-vm-debug"
  resource_group_name = azurerm_resource_group.rg_aks.name
  location            = azurerm_resource_group.rg_aks.location
  size                = "Standard_B2ms"
  admin_username      = "adminuser"
  admin_password      = "P@ssw0rd1234!"
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.example.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "22.04-LTS"
    version   = "latest"
  }
}
