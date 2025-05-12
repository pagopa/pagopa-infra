module "monitoring_function" {
  depends_on = [azurerm_application_insights.application_insights]
  source     = "./.terraform/modules/__v3__/monitoring_function"
  legacy     = false

  location            = var.location
  prefix              = "${local.product}-${var.location_short}"
  resource_group_name = azurerm_resource_group.synthetic_rg.name

  application_insight_name              = azurerm_application_insights.application_insights.name
  application_insight_rg_name           = azurerm_application_insights.application_insights.resource_group_name
  application_insights_action_group_ids = var.env_short == "p" ? [data.azurerm_monitor_action_group.infra_opsgenie[0].id] : [data.azurerm_monitor_action_group.slack.id]

  docker_settings = {
    image_tag = "v1.10.0@sha256:1686c4a719dc1a3c270f98f527ebc34179764ddf53ee3089febcb26df7a2d71d"
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
    enabled = var.self_alert_enabled
  }
  monitoring_configuration_encoded = templatefile("${path.module}/monitoring_configuration.json.tpl", {
    env_name                                 = var.env,
    env_short                                = var.env_short,
    api_dot_env_name                         = var.env == "prod" ? "api" : "api.${var.env}"
    internal_api_domain_prefix               = "weu${var.env}"
    internal_api_domain_suffix               = var.env == "prod" ? "internal.platform.pagopa.it" : "internal.${var.env}.platform.pagopa.it"
    nodo_subscription_key                    = nonsensitive(module.secret_core.values["synthetic-monitoring-nodo-subscription-key"].value)
    appgw_public_ip                          = data.azurerm_public_ip.appgateway_public_ip.ip_address
    check_position_body                      = var.check_position_body
    alert_enabled                            = var.synthetic_alerts_enabled
    verify_payment_internal_expected_outcome = var.verify_payment_internal_expected_outcome
    nexi_node_ip                             = var.nexi_node_ip
    fdr_enabled                              = var.env == "prod" ? false : true
    nexi_ndp_host                            = var.nexi_ndp_host
  })
}
