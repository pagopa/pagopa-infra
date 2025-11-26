data "azurerm_resource_group" "resource_group" {
  name = "${local.product}-azdoa-rg"
}


module "azdoa_custom_image" {
  source              = "git::https://github.com/pagopa/terraform-azurerm-v3.git//azure_devops_agent_custom_image?ref=v8.14.0"
  resource_group_name = data.azurerm_resource_group.resource_group.name
  location            = var.location
  image_name          = "${local.product}-azdo-agent-ubuntu2204-image"
  image_version       = var.azdo_agent_image_version
  subscription_id     = data.azurerm_subscription.current.subscription_id
  prefix              = local.product

}

