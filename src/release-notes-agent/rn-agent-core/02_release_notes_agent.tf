module "rn_agent" {
  #https://github.com/pagopa/payment-release-notes-agent/releases/tag/v0.0.7
  source = "git::https://github.com/pagopa/payment-release-notes-agent.git//infrastructure/iac?ref=1b64dfd05db51832ea3c6ece98f9d3896d0bee24"

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
  docker_image_tag = "v0.0.7"
  department_name  = "Dipartimento Pagamenti"

  # APIM
  api_management_name = "${var.prefix}-${var.env_short}-apim"
  api_management_rg   = "${var.prefix}-${var.env_short}-api-rg"
  apim_hostname       = "api.${var.env_short == "p" ? "" : "${var.env}."}platform.pagopa.it"

  # KV
  kv_resource_group_name = "${local.product}-${var.location_short}-${var.domain}-sec-rg"
  kv_name                = "${local.product}-${var.location_short}-${var.domain}-kv"

  # Monitoring
  log_analytics_workspace_name                = local.log_analytics_workspace_name
  log_analytics_workspace_resource_group_name = local.monitor_resource_group_name
  application_insights_name                   = local.application_insisght_name
  application_insights_resource_group_name    = local.monitor_resource_group_name


}
