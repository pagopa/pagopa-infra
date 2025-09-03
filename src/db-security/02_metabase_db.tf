resource "azurerm_resource_group" "metabase_rg" {
  name     = "${local.project}-rg"
  location = var.location

  tags = module.tag_config.tags
}

# Postgres Flexible Server subnet
module "postgres_flexible_snet" {
  source                                        = "./.terraform/modules/__v4__/IDH/subnet"
  name                                          = "${local.project}-pgflex-snet"
  resource_group_name                           = data.azurerm_resource_group.rg_vnet_italy.name
  virtual_network_name                          = data.azurerm_virtual_network.vnet_italy.name
  service_endpoints                             = ["Microsoft.Storage"]

  idh_resource_tier = "postgres_flexible"
  product_name = var.prefix
  env = var.env

}


module "metabase_postgres_db" {
  source = "./.terraform/modules/__v4__/IDH/postgres_flexible_server"

  env               = var.env
  idh_resource_tier = var.metabase_pgflex_params.idh_tier
  product_name      = var.prefix


  name                = "${local.project}-flexible-postgresql"
  location            = azurerm_resource_group.metabase_rg.location
  resource_group_name = azurerm_resource_group.metabase_rg.name


  private_dns_zone_id           =  var.env_short != "d" ? data.azurerm_private_dns_zone.postgres[0].id : null
  delegated_subnet_id           = module.postgres_flexible_snet.id

  administrator_login    = module.secret_core.values["metabase-db-admin-login"].value
  administrator_password = module.secret_core.values["metabase-db-admin-password"].value


  diagnostic_settings_enabled = var.metabase_pgflex_params.pgres_flex_diagnostic_settings_enabled
  log_analytics_workspace_id  = data.azurerm_log_analytics_workspace.log_analytics_italy.id

  custom_metric_alerts = var.metabase_pgflex_custom_metric_alerts
  databases = ["metabase"]

  alert_action =  []

  private_dns_registration = var.metabase_pgflex_params.private_dns_registration_enabled
  private_dns_zone_name    = "${var.env_short}.internal.postgresql.pagopa.it"
  private_dns_zone_rg_name = data.azurerm_resource_group.rg_vnet_core.name
  private_dns_record_cname = "metabase-db"

  additional_azure_extensions = ["citext"]

  tags = module.tag_config.tags

}


