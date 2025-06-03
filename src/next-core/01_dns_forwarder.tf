module "dns_forwarder_backup_snet" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//subnet?ref=v7.76.0"
  count  = var.is_feature_enabled.dns_forwarder_lb ? 1 : 0

  name                 = "${local.project}-dns-forwarder-backup-snet"
  address_prefixes     = var.cidr_subnet_dns_forwarder_backup
  resource_group_name  = azurerm_resource_group.rg_vnet.name
  virtual_network_name = module.vnet.name
}

# with default image
module "dns_forwarder_backup_vmss_li" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_scale_set_vm?ref=v7.76.0"
  count  = var.is_feature_enabled.dns_forwarder_lb ? 1 : 0

  name                = local.dns_forwarder_backup_name
  resource_group_name = azurerm_resource_group.rg_vnet.name
  subnet_id           = module.dns_forwarder_backup_snet[0].id
  subscription_name   = data.azurerm_subscription.current.display_name
  subscription_id     = data.azurerm_subscription.current.subscription_id
  location            = var.location
  source_image_name   = var.dns_forwarder_vm_image_name

  tags = module.tag_config.tags
}
