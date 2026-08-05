resource "azurerm_resource_group" "qa_hub_rg" {
  name     = "${local.project}-qa-hub-rg"
  location = var.location

  tags = module.tag_config.tags
}

data "azurerm_container_registry" "qa_hub_acr" {
  name                = "pagopaditncoreacr"
  resource_group_name = "pagopa-d-itn-acr-rg"
}

resource "azurerm_role_assignment" "qa_hub_app_service_acr_pull" {
  scope                = data.azurerm_container_registry.qa_hub_acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.qa_hub_app_service.principal_id
  principal_type       = "ServicePrincipal"
}

module "qa_hub_app_service" {
  source              = "./.terraform/modules/__v4__/IDH/app_service_webapp"
  env                 = var.env
  idh_resource_tier   = var.qa_hub_plan_idh_tier
  location            = var.location
  name                = "${local.project_short}-qa-hub-wa"
  product_name        = local.prefix
  resource_group_name = azurerm_resource_group.qa_hub_rg.name

  app_service_plan_name = "${local.project}-qa-hub-plan"
  app_settings = {
    WEBSITES_PORT                          = "3000"
    WEBSITE_DISABLE_CONTAINER_STARTUP_LOGS = "false"
    AUTH_TRUST_HOST                        = "true"
    GOOGLE_CLIENT_ID                       = var.qa_hub_google_client_id
    GOOGLE_CLIENT_SECRET                   = var.qa_hub_google_client_secret
    NEXTAUTH_SECRET                        = var.qa_hub_nextauth_secret
    NEXTAUTH_URL                           = var.qa_hub_nextauth_url
    NEXT_PUBLIC_API_URL                    = var.qa_hub_public_api_url
    WEBSITE_ENABLE_SYNC_UPDATE_SITE        = "true"
  }

  docker_image             = var.qa_hub_image.docker_image
  docker_image_tag         = var.qa_hub_image.docker_image_tag
  docker_registry_url      = "https://${data.azurerm_container_registry.qa_hub_acr.login_server}"
  docker_registry_username = null
  docker_registry_password = null
  container_registry_use_managed_identity = true

  tags = module.tag_config.tags
  # which subnet is allowed to reach this app service
  allowed_subnet_ids = []


  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.azurewebsites.id

  embedded_subnet = {
    enabled      = true
    vnet_name    = local.spoke_compute_vnet_name
    vnet_rg_name = local.spoke_compute_vnet_resource_group_name
  }

  # fixme configure the cidr list and service name allowed on this function
  embedded_nsg_configuration = {
    source_address_prefixes      = ["*"]
    source_address_prefixes_name = "All"
    target_ports                 = ["*"]
    protocol                     = "Tcp"
  }

  autoscale_settings = var.qa_hub_autoscale_settings

  always_on = var.qa_hub_always_on
}
