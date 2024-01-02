# resource "azurerm_subnet" "zabbix" {
#   name                 = "${local.project}-subnet"
#   resource_group_name  = data.azurerm_resource_group.rg_vnet_core.name
#   virtual_network_name = data.azurerm_virtual_network.vnet_core.name
#   address_prefixes     = var.cidr_subnet_zabbix_server
# }

# resource "azurerm_network_interface" "zabbix_nic" {
#   name                = "${local.project}-nic"
#   location            = azurerm_resource_group.zabbix.location
#   resource_group_name = azurerm_resource_group.zabbix.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.zabbix.id
#     private_ip_address_allocation = "Dynamic"
#   }

#   depends_on = [
#     azurerm_resource_group.zabbix
#   ]
# }

# resource "tls_private_key" "zabbix_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "azurerm_key_vault_secret" "zabbix_private_key" {
#   name         = "zabbix-private-key"
#   value        = tls_private_key.zabbix_key.private_key_openssh
#   content_type = "text/plain"

#   key_vault_id = data.azurerm_key_vault.kv_core.id
# }

# resource "azurerm_key_vault_secret" "zabbix_public_key" {
#   name         = "zabbix-public-key"
#   value        = tls_private_key.zabbix_key.public_key_openssh
#   content_type = "text/plain"

#   key_vault_id = data.azurerm_key_vault.kv_core.id
# }

# #store ssh public key
# resource "azurerm_ssh_public_key" "zabbix_public_key" {
#   name                = "${local.project}-admin-access-key"
#   resource_group_name = azurerm_resource_group.zabbix.name
#   location            = azurerm_resource_group.zabbix.location
#   public_key          = tls_private_key.zabbix_key.public_key_openssh
# }

# resource "azurerm_linux_virtual_machine" "zabbix_vm" {
#   name                = "${local.project}-vm"
#   resource_group_name = azurerm_resource_group.zabbix.name
#   location            = azurerm_resource_group.zabbix.location
#   size                = "Standard_D2as_v4"
#   admin_username      = "zabbix"

#   priority        = "Spot"
#   eviction_policy = "Deallocate"
#   network_interface_ids = [
#     azurerm_network_interface.zabbix_nic.id,
#   ]

#   admin_ssh_key {
#     username   = "zabbix"
#     public_key = tls_private_key.zabbix_key.public_key_openssh
#   }

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_id = "/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${var.image_rg_name}/providers/Microsoft.Compute/images/${var.image_name}"

#   depends_on = [azurerm_network_interface.zabbix_nic]
# }
