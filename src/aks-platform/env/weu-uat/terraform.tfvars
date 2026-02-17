# general
prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "uat"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"


### External resources

monitor_resource_group_name                 = "pagopa-u-monitor-rg"
log_analytics_workspace_name                = "pagopa-u-law"
log_analytics_workspace_resource_group_name = "pagopa-u-monitor-rg"

### Aks
# https://pagopa.atlassian.net/wiki/spaces/DEVOPS/pages/482967553/AKS#sku-(dimensionamento)

# https://pagopa.atlassian.net/wiki/spaces/PAG/pages/482870619/VPN+-+pagoPA+platform
aks_sku_tier                   = "Standard"
aks_private_cluster_is_enabled = true
aks_alerts_enabled             = false
aks_enable_workload_identity   = true

aks_system_node_pool = {
  name                         = "system01"
  vm_size                      = "Standard_D2ds_v5"
  os_disk_type                 = "Ephemeral"
  os_disk_size_gb              = "75"
  node_count_min               = "2" #TODO change to 2 or 3 in prod
  node_count_max               = "3"
  only_critical_addons_enabled = true
  node_labels                  = { node_name : "aks-system-01", node_type : "system" },
  node_tags                    = { node_tag_1 : "1" },
}

aks_user_node_pool = {
  enabled         = true
  name            = "user01"
  vm_size         = "Standard_D8ds_v5"
  os_disk_type    = "Ephemeral"
  os_disk_size_gb = "300"
  node_count_min  = "6"
  node_count_max  = "7"
  node_labels     = { node_name : "aks-user-01", node_type : "user" },
  node_taints     = [],
  node_tags       = { node_tag_1 : "1" },
}

aks_cidr_subnet = ["10.1.0.0/17"]

aks_kubernetes_version = "1.32.4"

# Subnet aks
subnet_private_endpoint_network_policies_enabled = true

ingress_min_replica_count = "2"
ingress_max_replica_count = "30"
ingress_load_balancer_ip  = "10.1.100.250"
# ingress-nginx helm charts releases 4.X.X: https://github.com/kubernetes/ingress-nginx/releases?expanded=true&page=1&q=tag%3Ahelm-chart-4
# Pinned versions from "4.1.0" release: https://github.com/kubernetes/ingress-nginx/blob/helm-chart-4.1.0/charts/ingress-nginx/values.yaml
nginx_helm = {
  version = "4.14.2"
  controller = {
    image = {
      registry     = "k8s.gcr.io"
      image        = "ingress-nginx/controller"
      tag          = "v1.2.0"
      digest       = "sha256:d8196e3bc1e72547c5dec66d6556c0ff92a23f6d0919b206be170bc90d5f9185"
      digestchroot = "sha256:fb17f1700b77d4fcc52ca6f83ffc2821861ae887dbb87149cf5cbc52bea425e5"
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
  chart_version = "2.17.2"
  keda = {
    image_name = "ghcr.io/kedacore/keda"
    image_tag  = "2.8.0@sha256:cce502ff17fd2984af70b4e470b403a82067929f6e4d1888875a52fcb33fa9fd"
  }
  metrics_api_server = {
    image_name = "ghcr.io/kedacore/keda-metrics-apiserver"
    image_tag  = "2.8.0@sha256:4afe231e9ce5ca351fcf10a83479eb0ee2f3e6dc0f386108b89d1b5623d56b14"
  }
}

# chart releases: https://github.com/stakater/Reloader/releases
# image tags: https://hub.docker.com/r/stakater/reloader/tags
reloader_helm = {
  chart_version = "v0.0.118"
  image_name    = "stakater/reloader"
  image_tag     = "v0.0.118@sha256:2d423cab8d0e83d1428ebc70c5c5cafc44bd92a597bff94007f93cddaa607b02"
}

# chart releases: https://github.com/prometheus-community/helm-charts/releases?q=tag%3Aprometheus-15&expanded=true
# quay.io/prometheus/alertmanager image tags: https://quay.io/repository/prometheus/alertmanager?tab=tags
# jimmidyson/configmap-reload image tags: https://hub.docker.com/r/jimmidyson/configmap-reload/tags
# quay.io/prometheus/node-exporter image tags: https://quay.io/repository/prometheus/node-exporter?tab=tags
# quay.io/prometheus/prometheus image tags: https://quay.io/repository/prometheus/prometheus?tab=tags
# prom/pushgateway image tags:https://hub.docker.com/r/prom/pushgateway/tags

# prometheus_helm = {
#   chart_version = "15.12.0"
#   alertmanager = {
#     image_name = "quay.io/prometheus/alertmanager"
#     image_tag  = "v0.24.0@sha256:088464f949de8065b9da7dfce7302a633d700e9d598e2bebc03310712f083b31"
#   }
#   configmap_reload_prometheus = {
#     image_name = "jimmidyson/configmap-reload"
#     image_tag  = "v0.5.0@sha256:91467ba755a0c41199a63fe80a2c321c06edc4d3affb4f0ab6b3d20a49ed88d1"
#   }
#   configmap_reload_alertmanager = {
#     image_name = "jimmidyson/configmap-reload"
#     image_tag  = "v0.5.0@sha256:91467ba755a0c41199a63fe80a2c321c06edc4d3affb4f0ab6b3d20a49ed88d1"
#   }
#   node_exporter = {
#     image_name = "quay.io/prometheus/node-exporter"
#     image_tag  = "v1.3.1@sha256:f2269e73124dd0f60a7d19a2ce1264d33d08a985aed0ee6b0b89d0be470592cd"
#   }
#   server = {
#     image_name = "quay.io/prometheus/prometheus"
#     image_tag  = "v2.36.2@sha256:df0cd5887887ec393c1934c36c1977b69ef3693611932c3ddeae8b7a412059b9"
#   }
#   pushgateway = {
#     image_name = "prom/pushgateway"
#     image_tag  = "v1.4.3@sha256:9e4e2396009751f1dc66ebb2b59e07d5abb009eb26d637eb0cf89b9a3738f146"
#   }
# }

# https://github.com/prometheus-community/helm-charts/issues/1754#issuecomment-1199125703
prometheus_basic_auth_file = "./env/weu-uat/kube-prometheus-stack-helm/prometheus-basic-auth"

kube_prometheus_stack_helm = {
  chart_version = "44.2.1"
  values_file   = "./env/weu-uat/kube-prometheus-stack-helm/values.yaml"
}

tls_checker_https_endpoints_to_check = [
  {
    https_endpoint = "api.uat.platform.pagopa.it",
    alert_name     = "api-uat-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "management.uat.platform.pagopa.it",
    alert_name     = "management-uat-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "portal.uat.platform.pagopa.it",
    alert_name     = "portal-uat-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
  {
    https_endpoint = "api.prf.platform.pagopa.it",
    alert_name     = "api-prf-platform-pagopa-it",
    alert_enabled  = true,
    helm_present   = true,
  },
]
