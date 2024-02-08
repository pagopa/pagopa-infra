resource "azurerm_resource_group" "synthetic_rg" {
  location = var.location
  name     = "${local.project}-rg"
}

module "monitoring_function" {
  depends_on = [azurerm_resource_group.synthetic_rg]

  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//monitoring_function?ref=v7.52.0"

  location            = var.location
  prefix              = "${local.product}-${var.location_short}"
  resource_group_name = azurerm_resource_group.synthetic_rg.name

  application_insight_name              = data.azurerm_application_insights.application_insights.name
  application_insight_rg_name           = data.azurerm_application_insights.application_insights.resource_group_name
  application_insights_action_group_ids = [data.azurerm_monitor_action_group.slack.id]

  docker_settings = {
    image_tag = "v1.3.0@sha256:2b5509e0e51bd92b10e0e3b5d5075f2f3351ac145fd6242249ae4d29b4b9d5b4"
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

  self_alert_enabled = false
  monitoring_configuration_encoded = jsonencode([
    {
      "apiName" : "api-uat-pagopa",
      "appName" : "root",
      "url" : "https://api.uat.platform.pagopa.it/",
      "type" : "public",
      "checkCertificate" : true,
      "method" : "GET",
      "expectedCodes" : ["200"],
      "tags" : {
        "description" : "pagopa uat context root"
      },
      "durationLimit" : 10000,
      "alertEnabled" : false
    }
  ])
}
