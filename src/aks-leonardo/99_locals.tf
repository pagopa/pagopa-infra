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

  public_ip_aks_leonardo_outbound_name = "pagopa-${var.env_short}-itn-${var.env}-aksoutbound-pip"

  # ACR DOCKER
  acr_name                = replace("${local.product}itncoreacr", "-", "")
  acr_resource_group_name = "${local.product}-itn-acr-rg"
  
  # monitor
  monitor_rg_name                      = "${local.product}-monitor-rg"
  monitor_log_analytics_workspace_name = "${local.product}-law"
  monitor_appinsights_name             = "${local.product}-appinsights"
  monitor_security_storage_name        = replace("${local.product}-sec-monitor-st", "-", "")

  monitor_action_group_slack_name = "SlackPagoPA"
  monitor_action_group_email_name = "PagoPA"
  alert_action_group_ita_name     = "${var.prefix}${var.env_short}ita"
  alert_action_group_error_name   = "${var.prefix}${var.env_short}error"

  aks_metrics_alerts = {
    node_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "cpuUsagePercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "memoryWorkingSetPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_disk = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "DiskUsedPercentage"
      operator         = "GreaterThan"
      threshold        = 80
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "host"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "device"
          operator = "Include"
          values   = ["*"]
        }
      ],
    }
    node_not_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/nodes"
      metric_name      = "nodesCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "status"
          operator = "Include"
          values   = ["NotReady"]
        }
      ],
    }
    pods_failed = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "podCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "phase"
          operator = "Include"
          values   = ["Failed"]
        }
      ]
    }
    pods_ready = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "PodReadyPercentage"
      operator         = "LessThan"
      threshold        = 80
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "Kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        }
      ]
    }
    container_cpu = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "cpuExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "Kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
      ]
    }
    container_memory = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/containers"
      metric_name      = "memoryWorkingSetExceededPercentage"
      operator         = "GreaterThan"
      threshold        = 95
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "Kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
      ]
    }
    container_oom = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "oomKilledContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "Kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
      ]
    }
    container_restart = {
      aggregation      = "Average"
      metric_namespace = "Insights.Container/pods"
      metric_name      = "restartingContainerCount"
      operator         = "GreaterThan"
      threshold        = 0
      frequency        = "PT15M"
      window_size      = "PT1H"
      dimension = [
        {
          name     = "Kubernetes namespace"
          operator = "Include"
          values   = ["*"]
        },
      ]
    }
  }
}
