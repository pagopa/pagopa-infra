module "redis_alerting" {
  source = "./.terraform/modules/__v4__/continuos_platform_alerting"

  alerting_domains           = local.alerting_domains
  azure_resource_type        = local.azure_redis_resource_type
  global_custom_action_group = local.global_custom_action_group
  resource_metric_alerts     = var.redis_metric_alerts
  resource_alerts_enabled    = var.redis_alerts_enabled
}