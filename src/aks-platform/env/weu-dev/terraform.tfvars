# general
prefix          = "pagopa"
env_short       = "d"
env             = "dev"
domain          = "dev"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"


### External resources

monitor_resource_group_name                 = "pagopa-d-monitor-rg"
log_analytics_workspace_name                = "pagopa-d-law"
log_analytics_workspace_resource_group_name = "pagopa-d-monitor-rg"

### Aks
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/482967553/AKS#sku-(dimensionamento)

aks_sku_tier                   = "Standard"
aks_private_cluster_is_enabled = false
aks_alerts_enabled             = false
aks_enable_workload_identity   = true

aks_system_node_pool = {
  name                         = "system01"
  vm_size                      = "Standard_D2ds_v5"
  os_disk_type                 = "Ephemeral"
  os_disk_size_gb              = "75"
  node_count_min               = "1"
  node_count_max               = "3"
  only_critical_addons_enabled = true
  node_labels                  = { node_name : "aks-system-01", node_type : "system" },
  node_tags                    = { node_tag_1 : "1" },
}

aks_user_node_pool = {
  enabled         = true
  name            = "user01"
  vm_size         = "Standard_B8ms"
  os_disk_type    = "Managed"
  os_disk_size_gb = "300"
  node_count_min  = "4"
  node_count_max  = "5"
  node_labels     = { node_name : "aks-user-01", node_type : "user" },
  node_taints     = [],
  node_tags       = { node_tag_1 : "1" },
}

aks_cidr_subnet = ["10.1.0.0/17"]

aks_kubernetes_version = "1.32.4"

# Subnet aks
subnet_private_endpoint_network_policies_enabled = true

ingress_min_replica_count = "1"
ingress_max_replica_count = "3"
ingress_load_balancer_ip  = "10.1.100.250"
# ingress-nginx helm charts releases 4.X.X: https://github.com/kubernetes/ingress-nginx/releases?expanded=true&page=1&q=tag%3Ahelm-chart-4
# Pinned versions from "4.7.2" release: https://github.com/kubernetes/ingress-nginx/blob/helm-chart-4.7.2/charts/ingress-nginx/values.yaml
nginx_helm = {
  version = "4.12.1"
  controller = {
    image = {
      registry     = "k8s.gcr.io"
      image        = "ingress-nginx/controller"
      tag          = "v1.8.1"
      digest       = "sha256:e5c4824e7375fcf2a393e1c03c293b69759af37a9ca6abdb91b13d78a93da8bd"
      digestchroot = "sha256:e0d4121e3c5e39de9122e55e331a32d5ebf8d4d257227cb93ab54a1b912a7627"
    },
    resources = {
      requests = {
        memory = "300Mi"
      }
    },
    config = {
      proxy-body-size : 0,
    }
  }
}

# chart releases: https://github.com/kedacore/charts/releases
# keda image tags: https://github.com/kedacore/keda/pkgs/container/keda/versions
# keda-metrics-apiserver image tags: https://github.com/kedacore/keda/pkgs/container/keda-metrics-apiserver/versions
keda_helm = {
  chart_version = "2.17.1"
  keda = {
    image_name = "ghcr.io/kedacore/keda"
    image_tag  = "2.11.2@sha256:d8d3ef2937e22da29daa7cd9485626a577f1166bab47c582c43ff776d47d764b"
  }
  metrics_api_server = {
    image_name = "ghcr.io/kedacore/keda-metrics-apiserver"
    image_tag  = "2.11.2@sha256:b45c4d4290913cfd227184e16751ee322e5f2544a33c178ae90c356e3380d0f5"
  }
}

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v1.0.40"
  image_name    = "stakater/reloader"
  image_tag     = "v1.0.40@sha256:da5ab4a51874a07ef612c00a4998311953c825b10573ccad538e02c2b1634e1d"
}

# https://github.com/prometheus-community/helm-charts/issues/1754#issuecomment-1199125703
prometheus_basic_auth_file = "./env/weu-dev/kube-prometheus-stack-helm/prometheus-basic-auth"

kube_prometheus_stack_helm = {
  chart_version = "44.2.1"
  values_file   = "./env/weu-dev/kube-prometheus-stack-helm/values.yaml"
}

tls_checker_keyvault = {
  name        = "pagopa-d-kv"
  secret_name = "pagopa-d-application-insight-connection-string"
}
tls_checker_https_endpoints_to_check = [
  {
    https_endpoint = "api.dev.platform.pagopa.it",
    alert_name     = "api-dev-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "management.dev.platform.pagopa.it",
    alert_name     = "management-dev-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "portal.dev.platform.pagopa.it",
    alert_name     = "portal-dev-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
]
