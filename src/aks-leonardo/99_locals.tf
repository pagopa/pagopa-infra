locals {
  product          = "${var.prefix}-${var.env_short}"
  product_location = "${var.prefix}-${var.env_short}-${var.location_short}"
  project          = "${var.prefix}-${var.env_short}-${var.location_short}-${var.domain}"

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
  acr_name_ita                = replace("${local.product}itncoreacr", "-", "")
  acr_resource_group_name_ita = "${local.product}-itn-acr-rg"

  # monitor
  #TODO dev needs to be re-created to use the correct names containing local.product_location + core instead of local.product
  monitor_rg_name                      = var.env_short == "d" ? "${local.product}-monitor-rg" : "${local.product_location}-core-monitor-rg"
  monitor_log_analytics_workspace_name = var.env_short == "d" ? "${local.product}-law" : "${local.product_location}-core-law"
  monitor_appinsights_name             = var.env_short == "d" ? "${local.product}-appinsights" : "${local.product_location}-core-appinsights"

  monitor_action_group_slack_name    = "SlackPagoPA"
  monitor_action_group_email_name    = "PagoPA"
  monitor_action_group_opsgenie_name = "InfraOpsgenie"
  alert_action_group_ita_name        = "${var.prefix}${var.env_short}ita"
  alert_action_group_error_name      = "${var.prefix}${var.env_short}error"

  kv_italy_name    = "pagopa-${var.env_short}-itn-core-kv"
  kv_italy_rg_name = "pagopa-${var.env_short}-itn-core-sec-rg"

  aks_logs_alerts = {
    pods_failed = {
      display_name            = "${module.aks_leonardo.name}-POD-FAILED"
      description             = "Detect if there is any pod failed"
      query                   = <<-KQL
        KubePodInventory
        | where TimeGenerated > ago(15m)
        | where PodStatus == "Failed"
        | project TimeGenerated, ClusterName, Namespace, Name, PodStatus
        | summarize count() by PodStatus, Namespace
      KQL
      severity                = 1
      window_duration         = "PT30M"
      evaluation_frequency    = "PT15M"
      operator                = "GreaterThan"
      threshold               = 1
      time_aggregation_method = "Average"
      resource_id_column      = "PodStatus"
      metric_measure_column   = "count_"
      dimension = [
        {
          name     = "Namespace"
          operator = "Include"
          values   = ["*"]
        }
      ]
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
      skip_query_validation                    = true

    }
    pods_ready = {
      display_name                             = "${module.aks_leonardo.name}-POD-READY"
      description                              = "Detect pods percentage is over defined threshold"
      query                                    = <<-KQL
        KubePodInventory
        | where TimeGenerated > ago(15m)
        | summarize TotalPodCount = count(), RunningPodCount = countif(PodStatus == "Running")
        | extend RunningPodPercentage = (todouble(RunningPodCount) / todouble(TotalPodCount)) * 100
        | where RunningPodPercentage > 80
        | project RunningPodPercentage, TotalPodCount, RunningPodCount
        | summarize any(RunningPodPercentage)
      KQL
      severity                                 = 1
      window_duration                          = "PT30M"
      evaluation_frequency                     = "PT15M"
      operator                                 = "LessThan"
      threshold                                = 80
      time_aggregation_method                  = "Average"
      resource_id_column                       = "RunningPodPercentage"
      metric_measure_column                    = "any_RunningPodPercentage"
      dimension                                = []
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
      skip_query_validation                    = true
    }
    pods_oomkilled = {
      display_name            = "${module.aks_leonardo.name}-POD-OMMKILLED"
      description             = "Detect if any pod is OOMKilled"
      query                   = <<-KQL
        KubePodInventory
        | where PodStatus != "running"
        | extend ContainerLastStatusJSON = parse_json(ContainerLastStatus)
        | extend FinishedAt = todatetime(ContainerLastStatusJSON.finishedAt)
        | where ContainerLastStatusJSON.reason == "OOMKilled"
        | distinct PodUid, Namespace, ControllerName, ContainerLastStatus, FinishedAt
        | order by FinishedAt asc
      KQL
      severity                = 3
      window_duration         = "PT15M"
      evaluation_frequency    = "PT5M"
      operator                = "GreaterThan"
      threshold               = 1
      time_aggregation_method = "Count"
      resource_id_column      = "ControllerName"
      metric_measure_column   = null
      dimension = [
        {
          name     = "ControllerName"
          operator = "Include"
          values   = ["*"]
        },
        {
          name     = "Namespace"
          operator = "Exclude"
          values = [
            "kube-system",
            "default"
          ]
        }
      ]
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
      skip_query_validation                    = true
    }
    pods_restart = {
      display_name            = "${module.aks_leonardo.name}-POD-RESTART-COUNT"
      description             = "Detect if any pod was restarted abnormally"
      query                   = <<-KQL
        KubePodInventory
        | where ContainerRestartCount > 0
        | summarize RestartCount = sum(ContainerRestartCount) by bin(TimeGenerated, 1m), Namespace, Name, _ResourceId
        | where RestartCount > 0
        | project TimeGenerated, Namespace, Name, RestartCount, _ResourceId
        | summarize any(RestartCount) by Namespace
      KQL
      severity                = 2
      window_duration         = "PT30M"
      evaluation_frequency    = "PT15M"
      operator                = "GreaterThan"
      threshold               = 5
      time_aggregation_method = "Average"
      resource_id_column      = "RestartCount"
      metric_measure_column   = "any_RestartCount"
      dimension = [
        {
          name     = "Namespace"
          operator = "Exclude"
          values = [
            "kube-system",
            "default"
          ]
        },
      ]
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
      skip_query_validation                    = true
    }
    pods_cpu = {
      display_name            = "${module.aks_leonardo.name}-POD-CPU-USAGE"
      description             = "Detect if any pod has High CPU Usage"
      query                   = <<-KQL
        let endDateTime = now();
        let startDateTime = ago(1h);
        let trendBinSize = 1m;
        let capacityCounterName = 'cpuLimitNanoCores';
        let usageCounterName = 'cpuUsageNanoCores';
        let clusterName = '${module.aks_leonardo.name}';
        KubePodInventory
        | where TimeGenerated < endDateTime
        | where TimeGenerated >= startDateTime
        | where ClusterName == clusterName
        | extend InstanceName = strcat(ClusterId, '/', ContainerName)
        | distinct Computer, InstanceName, ContainerName, ControllerName
        | join hint.strategy=shuffle (
            Perf
            | where TimeGenerated < endDateTime
            | where TimeGenerated >= startDateTime
            | where ObjectName == 'K8SContainer'
            | where CounterName == capacityCounterName
            | summarize LimitValue = max(CounterValue) by Computer, InstanceName, bin(TimeGenerated, trendBinSize)
            | project Computer, InstanceName, LimitStartTime = TimeGenerated, LimitEndTime = TimeGenerated + trendBinSize, LimitValue
        ) on Computer, InstanceName
        | join kind=inner hint.strategy=shuffle (
            Perf
            | where TimeGenerated < endDateTime + trendBinSize
            | where TimeGenerated >= startDateTime - trendBinSize
            | where ObjectName == 'K8SContainer'
            | where CounterName == usageCounterName
            | project Computer, InstanceName, UsageValue = CounterValue, TimeGenerated
        ) on Computer, InstanceName
        | where TimeGenerated >= LimitStartTime and TimeGenerated < LimitEndTime
        | project Computer, ControllerName, ContainerName, TimeGenerated, UsagePercent = UsageValue * 100.0 / LimitValue
        | summarize AggValue = avg(UsagePercent) by bin(TimeGenerated, trendBinSize) , ContainerName, ControllerName
      KQL
      severity                = 2
      window_duration         = "PT15M"
      evaluation_frequency    = "PT5M"
      operator                = "GreaterThan"
      threshold               = 95
      time_aggregation_method = "Average"
      metric_measure_column   = "AggValue"
      dimension = [
        {
          name     = "ControllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
    }
    pods_memory = {
      display_name            = "${module.aks_leonardo.name}-POD-MEM-USAGE"
      description             = "Detect if any pod has High Memory Usage"
      query                   = <<-KQL
        let endDateTime = now();
        let startDateTime = ago(1h);
        let trendBinSize = 1m;
        let capacityCounterName = 'memoryLimitBytes';
        let usageCounterName = 'memoryRssBytes';
        let clusterName = '${module.aks_leonardo.name}';
        KubePodInventory
        | where TimeGenerated < endDateTime
        | where TimeGenerated >= startDateTime
        | where ClusterName == clusterName
        | extend InstanceName = strcat(ClusterId, '/', ContainerName)
        | where ContainerName !contains "microservice-chart"
        | distinct Computer, InstanceName, ContainerName, ControllerName
        | join hint.strategy=shuffle (
            Perf
            | where TimeGenerated < endDateTime
            | where TimeGenerated >= startDateTime
            | where ObjectName == 'K8SContainer'
            | where CounterName == capacityCounterName
            | summarize LimitValue = max(CounterValue) by Computer, InstanceName, bin(TimeGenerated, trendBinSize)
            | project Computer, InstanceName, LimitStartTime = TimeGenerated, LimitEndTime = TimeGenerated + trendBinSize, LimitValue
        ) on Computer, InstanceName
        | join kind=inner hint.strategy=shuffle (
            Perf
            | where TimeGenerated < endDateTime + trendBinSize
            | where TimeGenerated >= startDateTime - trendBinSize
            | where ObjectName == 'K8SContainer'
            | where CounterName == usageCounterName
            | project Computer, InstanceName, UsageValue = CounterValue, TimeGenerated
        ) on Computer, InstanceName
        | where TimeGenerated >= LimitStartTime and TimeGenerated < LimitEndTime
        | project Computer, ControllerName, ContainerName, TimeGenerated, UsagePercent = UsageValue * 100.0 / LimitValue
        | summarize AggValue = avg(UsagePercent) by bin(TimeGenerated, trendBinSize) , ContainerName, ControllerName
    KQL
      severity                = 2
      window_duration         = "PT15M"
      evaluation_frequency    = "PT5M"
      operator                = "GreaterThan"
      threshold               = 90
      time_aggregation_method = "Average"
      metric_measure_column   = "AggValue"
      dimension = [
        {
          name     = "ControllerName"
          operator = "Include"
          values   = ["*"]
        }
      ]
      minimum_failing_periods_to_trigger_alert = 1
      number_of_evaluation_periods             = 1
      auto_mitigation_enabled                  = true
    }
  }
}
