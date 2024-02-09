

module "monitoring_function" {

  depends_on = [azurerm_application_insights.application_insights]

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//monitoring_function?ref=v7.53.0"

  location            = var.location
  prefix              = "${local.product}-${var.location_short}"
  resource_group_name = azurerm_resource_group.synthetic_rg.name

  application_insight_name              = azurerm_application_insights.application_insights.name
  application_insight_rg_name           = azurerm_application_insights.application_insights.resource_group_name
  application_insights_action_group_ids = [data.azurerm_monitor_action_group.slack.id]

  docker_settings = {
    image_tag = "v1.5.0@sha256:13990c56c815c9ab8e1a333c87e67f48edf3be46750caba37a6830af8c464192"
  }

  job_settings = {
    cron_scheduling              = "*/5 * * * *"
    container_app_environment_id = data.azurerm_container_app_environment.tools_cae.id
    http_client_timeout          = 30000
  }

  storage_account_settings = {
    private_endpoint_enabled  = var.use_private_endpoint
    table_private_dns_zone_id = var.use_private_endpoint ? data.azurerm_private_dns_zone.storage_account_table.id : null
    replication_type          = var.storage_account_replication_type
  }

  private_endpoint_subnet_id = var.use_private_endpoint ? data.azurerm_subnet.private_endpoint_subnet[0].id : null

  tags = var.tags

  self_alert_configuration = {
    enabled = false
  }
  monitoring_configuration_encoded = file("./monitoring_configuration.json")
}
