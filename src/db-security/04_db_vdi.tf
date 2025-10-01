resource "azurerm_resource_group" "db_vdi_rg" {
  count = var.enabled_features.db_vdi ? 1 : 0
  name     = "${local.project}-db-vdi-rg"
  location = var.location

  tags = module.tag_config.tags
}

resource "azurerm_network_interface" "vdi_nic" {
    count = var.enabled_features.db_vdi ? 1 : 0

  name                = "${local.project}-db-vdi-nic"
  location            = azurerm_resource_group.db_vdi_rg[0].location
  resource_group_name = azurerm_resource_group.db_vdi_rg[0].name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.tools_subnet[0].id
    private_ip_address_allocation = "Dynamic"
  }

  tags = module.tag_config.tags
}

resource "azurerm_windows_virtual_machine" "db_vdi_vm" {
    count = var.enabled_features.db_vdi ? 1 : 0

  name                = "${local.project}-db-vdi"
  computer_name       = "${local.product}-db-vdi"
  resource_group_name = azurerm_resource_group.db_vdi_rg[0].name
  location            = azurerm_resource_group.db_vdi_rg[0].location
  size                = "Standard_B4ms"
  network_interface_ids = [
    azurerm_network_interface.vdi_nic[0].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  identity {
    type = "SystemAssigned"
  }

  license_type = "None"

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-Datacenter"
    version   = "latest"
  }

  tags = module.tag_config.tags
}


resource "azurerm_virtual_machine_extension" "aad_join_extension" {
    count = var.enabled_features.db_vdi ? 1 : 0

  name                 = "AADLoginForWindows"
  virtual_machine_id   = azurerm_windows_virtual_machine.db_vdi_vm[0].id
  publisher            = "Microsoft.Azure.ActiveDirectory"
  type                 = "AADLoginForWindows"
  type_handler_version = "2.0"

  auto_upgrade_minor_version = false
  automatic_upgrade_enabled  = false


  tags = module.tag_config.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "auto_shutdown" {
  count = var.enabled_features.db_vdi ? 1 : 0
  virtual_machine_id = azurerm_windows_virtual_machine.db_vdi_vm[0].id
  location           = var.location
  enabled            = var.auto_shutdown_enabled

  daily_recurrence_time = var.auto_shutdown_time
  timezone              = "Central European Standard Time"

  notification_settings {
    enabled = false
  }
}
