module "rn_agent" {
  #https://github.com/pagopa/payment-release-notes-agent/releases/tag/v0.0.6
  source = "git::https://github.com/pagopa/payment-release-notes-agent.git//infrastructure/iac?ref=d7f0325787e648bddc06abf310084ecc98be6d81"

  # General
  prefix   = var.prefix
  domain   = var.domain
  env      = var.env
  tags     = module.tag_config.tags
  location = var.location

  # IDH
  idh_app_service_resource_tier     = "basic"
  idh_storage_account_resource_tier = "basic_public"

  # Network
  vnet_name          = data.azurerm_virtual_network.network_tools_vnet.name
  vnet_rg            = data.azurerm_virtual_network.network_tools_vnet.resource_group_name
  allowed_subnet_ids = [data.azurerm_subnet.apim_vnet.id]

  private_dns_zone_blob_ids             = [data.azurerm_private_dns_zone.blob_storage.id]
  azure_website_dns_zone_name           = "privatelink.azurewebsites.net"
  internal_dns_zone_resource_group_name = "${local.product}-vnet-rg"

  # General App
  docker_image_tag = "v0.0.6"
  department_name  = "Dipartimento Pagamenti"

  # APIM
  api_management_name = "${var.prefix}-${var.env_short}-apim"
  api_management_rg   = "${var.prefix}-${var.env_short}-api-rg"
  apim_hostname       = "api.${var.env_short == "p" ? "" : "${var.env}."}platform.pagopa.it"

  # KV
  kv_resource_group_name = "${local.product}-${var.location_short}-${var.domain}-sec-rg"
  kv_name                = "${local.product}-${var.location_short}-${var.domain}-kv"
}
