# Postgres Flexible Server subnet
module "app_service_snet" {
  source                                        = "./.terraform/modules/__v4__/IDH/subnet"
  name                                          = "${local.project}-app-snet"
  resource_group_name                           = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_italy.name

  idh_resource_tier = "app_service"
  product_name = var.prefix
  env = var.env

  service_endpoints = ["Microsoft.Web"]

}

locals {
  db_user= module.secret_core.values["metabase-db-admin-login"].value
  db_password = module.secret_core.values["metabase-db-admin-password"].value
}

module "metabase_app_service" {
  source = "./.terraform/modules/__v4__/IDH/app_service_webapp"
  env    = var.env
  idh_resource_tier = var.metabase_plan_idh_tier
  location = var.location
  name = "${local.project}-metabase-webapp"
  product_name = var.prefix
  resource_group_name = azurerm_resource_group.metabase_rg.name

  app_service_plan_name = "${local.project}-metabase-plan"
  app_settings = {
    MB_DB_USER=module.secret_core.values["metabase-db-admin-login"].value
    MB_DB_PASS=module.secret_core.values["metabase-db-admin-password"].value
    MB_DB_CONNECTION_URI="jdbc:postgresql://${module.metabase_postgres_db.fqdn}:5432/metabase?ssl=true&sslmode=require"

  }
  docker_image = "metabase/metabase"
  docker_image_tag = "latest"
  docker_registry_url = "https://index.docker.io"
  subnet_id = module.app_service_snet.subnet_id
  tags = module.tag_config.tags

  allowed_subnet_ids = [data.azurerm_subnet.vpn_subnet.id]

  private_endpoint_dns_zone_id = data.azurerm_private_dns_zone.azurewebsites.id
  private_endpoint_subnet_id = data.azurerm_subnet.private_endpoint_subnet.id

  autoscale_settings = {
    max_capacity = 3
    scale_up_requests_threshold = 250
    scale_down_requests_threshold = 150

  }

  always_on = true
  ftps_state = "AllAllowed"
}
