module "dns_forwarder_image" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//dns_forwarder_vm_image?ref=v8.14.0"
  resource_group_name = data.azurerm_resource_group.rg_vnet_core.name
  location            = var.location
  image_name          = "${local.product}-dns-forwarder-ubuntu2204-image"
  image_version       = var.dns_forwarder_backup_image_version
  subscription_id     = data.azurerm_subscription.current.subscription_id
  prefix              = local.product
}
