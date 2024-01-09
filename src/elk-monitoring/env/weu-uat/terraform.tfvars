prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "elk"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "uat"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Dev"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/tree/main/src/domains/elk-monitoring"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.uat.platform"
apim_dns_zone_prefix     = "uat.platform"

# chart releases: https://github.com/pagopa/aks-microservice-chart-blueprint/releases
# image tags: https://github.com/pagopa/infra-ssl-check/releases
tls_cert_check_helm = {
  chart_version = "1.21.0"
  image_name    = "ghcr.io/pagopa/infra-ssl-check"
  image_tag     = "v1.2.2@sha256:22f4b53177cc8891bf10cbd0deb39f60e1cd12877021c3048a01e7738f63e0f9"
}

elastic_node_pool = {
  enabled         = true
  name            = "elastic01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "4" #TODO change to 2 or 3 in prod
  node_count_max  = "4"
  node_labels = {
    elastic : "eck",
  },
  node_taints           = [],
  node_tags             = { elastic : "yes" },
  elastic_pool_max_pods = "250",
}

elastic_hot_storage = {
  storage_type           = "StandardSSD_ZRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}
elastic_warm_storage = {
  storage_type           = "StandardSSD_LRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}
elastic_cold_storage = {
  storage_type           = "Standard_LRS"
  allow_volume_expansion = true
  initialStorageSize     = "100Gi"
}

enable_iac_pipeline = true

ingress_load_balancer_ip = "10.1.100.250"
subscription_name        = "uat-pagopa"

ingress_min_replica_count    = "1"
ingress_max_replica_count    = "3"
ingress_elk_load_balancer_ip = "10.1.100.251"
# ingress-nginx helm charts releases 4.X.X: https://github.com/kubernetes/ingress-nginx/releases?expanded=true&page=1&q=tag%3Ahelm-chart-4
# Pinned versions from "4.1.0" release: https://github.com/kubernetes/ingress-nginx/blob/helm-chart-4.1.0/charts/ingress-nginx/values.yaml
nginx_helm = {
  version = "4.7.2"
  controller = {
    image = {
      registry     = "k8s.gcr.io"
      image        = "ingress-nginx/controller"
      tag          = "v1.2.0"
      digest       = "sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185"
      digestchroot = "sha256:fb17f1700b77d4fcc52ca6f83ffc2821861ae887dbb87149cf5cbc52bea425e5"
    },
    config = {
      proxy-body-size : 0,
    }
  }
}

nodeset_config = {
  balancer-nodes = {
    count            = "3"
    roles            = []
    storage          = "30Gi"
    storageClassName = "pagopa-u-weu-elk-elastic-aks-storage-hot"
    requestMemory    = "1Gi"
    requestCPU       = "1"
    limitsMemory     = "2Gi"
    limitsCPU        = "1"
  },
  master-nodes = {
    count            = "3"
    roles            = ["master"]
    storage          = "30Gi"
    storageClassName = "pagopa-u-weu-elk-elastic-aks-storage-hot"
    requestMemory    = "1Gi"
    requestCPU       = "1"
    limitsMemory     = "2Gi"
    limitsCPU        = "1"
  },
  data-hot-nodes = {
    count            = "3"
    roles            = ["ingest", "data_content", "data_hot"]
    storage          = "220Gi"
    storageClassName = "pagopa-u-weu-elk-elastic-aks-storage-hot"
    requestMemory    = "3Gi"
    requestCPU       = "1"
    limitsMemory     = "4Gi"
    limitsCPU        = "2"
  },
  data-warm-nodes = {
    count            = "3"
    roles            = ["ingest", "data_content", "data_warm"]
    storage          = "270Gi"
    storageClassName = "pagopa-u-weu-elk-elastic-aks-storage-warm"
    requestMemory    = "3Gi"
    requestCPU       = "1"
    limitsMemory     = "4Gi"
    limitsCPU        = "2"
  },
  data-cold-nodes = {
    count            = "3"
    roles            = ["ingest", "data_content", "data_cold", "data_frozen", "ml", "transform", "remote_cluster_client"]
    storage          = "270Gi"
    storageClassName = "pagopa-u-weu-elk-elastic-aks-storage-cold"
    requestMemory    = "3Gi"
    requestCPU       = "1"
    limitsMemory     = "4Gi"
    limitsCPU        = "2"
  }
}

opentelemetry_operator_helm = {
  chart_version = "0.24.3"
  values_file   = "./env/opentelemetry_operator_helm/values.yaml"
}