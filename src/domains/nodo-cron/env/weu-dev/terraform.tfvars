prefix                                      = "pagopa"
env_short                                   = "d"
env                                         = "dev"
domain                                      = "nodo"
location                                    = "westeurope"
location_short                              = "weu"
monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"
instance                                    = "dev"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
apim_dns_zone_prefix     = "dev.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
nodo_user_node_pool = {
  enabled         = true
  name            = "nodocron01"
  vm_size         = "Standard_B8ms"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "1"
  node_count_max  = "4"
  node_labels = {
  "nodo-cron" = "true", },
  node_taints        = ["dedicated=nodo-cron:NoSchedule"],
  node_tags          = { node_tag_1 : "1" },
  nodo_pool_max_pods = "250",
}
