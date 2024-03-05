locals {
  product = "${var.prefix}-${var.env_short}"
  project = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

  # AKS
  aks_rg_name      = "${local.project}-aks-rg"
  aks_cluster_name = "${local.project}-aks"

  ### Network
  vnet_ita_resource_group_name = "${local.product}-itn-vnet-rg"
  vnet_ita_name                = "${local.product}-itn-vnet"

  vnet_core_resource_group_name = "${local.product}-vnet-rg"
  vnet_core_name                = "${local.product}-vnet"

  public_ip_aks_leonardo_outbound_name = "pagopa-${var.env_short}-itn-aks-leonardo-pip"

  # ACR DOCKER
  docker_rg_name       = "${local.product}-container-registry-rg"
  docker_registry_name = replace("${var.prefix}-${var.env_short}-common-acr", "-", "")

  # monitor
  monitor_rg_name                      = "${local.product}-monitor-rg"
  monitor_log_analytics_workspace_name = "${local.product}-law"
  monitor_appinsights_name             = "${local.product}-appinsights"
  monitor_security_storage_name        = replace("${local.product}-sec-monitor-st", "-", "")

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  alert_action_group_ita_name    = "${var.prefix}${var.env_short}ita"
  alert_action_group_error_name   = "${var.prefix}${var.env_short}error"
}
