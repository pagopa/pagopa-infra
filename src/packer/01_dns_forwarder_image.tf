module "dns_forwarder_image" {
  source              = "./.terraform/modules/__v4__/dns_forwarder_vm_image"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
  location            = var.location
  image_name          = "${local.product}-dns-forwarder-ubuntu2204-image"
  image_version       = var.dns_forwarder_backup_image_version
  subscription_id     = data.azurerm_subscription.current.subscription_id
  prefix              = local.product
}
