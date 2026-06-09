resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

#ingress
# from Microsoft docs https://docs.microsoft.com/it-it/azure/aks/ingress-internal-ip
module "nginx_ingress" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace  = kubernetes_namespace.ingress.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  app = {
    name          = "nginx-ingress"
    version       = var.nginx_helm.version
    chart         = "ingress-nginx"
    recreate_pods = false #https://github.com/helm/helm/issues/6378 -> fixed in k8s 1.22
    deploy        = 1
  }

  values = [
    "${templatefile("${path.module}/ingress/loadbalancer.yaml.tpl", { load_balancer_ip = var.ingress_load_balancer_ip })}",
    templatefile(
      "${path.module}/ingress/autoscaling.yaml.tpl",
      {
        min_replicas     = var.ingress_min_replica_count
        max_replicas     = var.ingress_max_replica_count
        polling_interval = 30  # seconds
        cooldown_period  = 300 # seconds
        triggers = [
          {
            type = "cpu"
            metadata = {
              type  = "Utilization"
              value = "70"
            }
          },
          {
            type = "memory"
            metadata = {
              type  = "Utilization"
              value = "70"
            }
          }
        ]
      }
    ),
  ]

  set = [
    {
      name  = "controller.image.digestChroot"
      value = var.nginx_helm.controller.image.digestchroot
    },
    {
      name  = "controller.nodeSelector.beta\\.kubernetes\\.io/os"
      value = "linux"
    },
    {
      name  = "defaultBackend.nodeSelector.beta\\.kubernetes\\.io/os"
      value = "linux"
    },
    {
      name  = "controller.admissionWebhooks.patch.nodeSelector.beta\\.kubernetes\\.io/os"
      value = "linux"
    },
    {
      name  = "controller.ingressClassResource.default"
      value = "true"
    },
    {
      name  = "controller.resources.requests.memory"
      value = var.nginx_helm.controller.resources.requests.memory
    },
    {
      name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-load-balancer-health-probe-request-path"
      value = "/healthz"
    },
    {
      # To overcome 1m size limit of https://kubernetes.github.io/ingress-nginx/user-guide/nginx-configuration/configmap/#proxy-body-size
      # Setting size to 0 disables checking of client request body size
      name  = "controller.config.proxy-body-size"
      value = var.nginx_helm.controller.config.proxy-body-size
    }
  ]
}

###############################################################################
# HAProxy Ingress module - configuration
###############################################################################

module "haproxy_ingress" {
  source = "./.terraform/modules/__v4__/kubernetes_haproxy_ingress_controller"
  count  = var.env_short == "d" ? 1 : 0

  release_name         = "haproxy-ingress"
  namespace            = "haproxy-ingress"
  chart_version        = "1.49.0"
  controller_image_tag = "3.2.6"

  # ---- Namespace labels for Azure Policy / Workload Identity ----
  namespace_labels = {
    "azure.workload.identity/use" = "false"
    "environment"                 = var.env
  }

  # ---- Replicas & aggressive autoscaling ----
  replica_count = 3

  autoscaling = {
    enabled                   = true
    min_replicas              = 3
    max_replicas              = 20
    target_cpu_utilization    = 70
    target_memory_utilization = 75
  }

  # ---- PDB: keep at least 2 pods always available ----
  pod_disruption_budget = {
    enabled       = true
    min_available = 2
  }

  # ---- Resources (production sizing) ----
  resources = {
    requests_cpu    = "200m"
    requests_memory = "256Mi"
    limits_cpu      = "1000m"
    limits_memory   = "1Gi"
  }

  # ---- Resource Quota on the namespace ----
  enable_resource_quota = false

  # ---- Internal Load Balancer with static IP ----
  service_type     = "LoadBalancer"
  load_balancer_ip = var.haproxy_ingress_load_balancer_ip

  service_annotations = {
    # Force the Load Balancer to be internal to the VNet
    "service.beta.kubernetes.io/azure-load-balancer-internal" = "true"
  }

  # ---- Default IngressClass ----
  ingress_class_name           = "haproxy"
  set_as_default_ingress_class = false

  # ---- Full monitoring ----
  enable_metrics         = true
  enable_stats           = true
  enable_service_monitor = true # requires Prometheus Operator to be installed
  metrics_port           = 1024

  # ---- Network Policy ----
  enable_network_policy = true

  # ---- Distribution across Azure availability zones (zones 1, 2, 3) ----
  enable_topology_spread     = true
  anti_affinity_topology_key = "topology.kubernetes.io/zone"

  # ---- Logging ----
  log_level = "info"

  # ---- Generous timeout for environments with slow policies ----
  timeout_seconds = 600
  atomic          = true

  # ---- Targeted overrides for advanced HAProxy settings ----
  extra_set_values = {
    "controller.config.ssl-redirect"      = "true"
    "controller.config.timeout-connect"   = "5s"
    "controller.config.timeout-client"    = "60s"
    "controller.config.timeout-server"    = "60s"
    "controller.config.nbthread"          = "4"
    "controller.config.max-spread-checks" = "10"
    "controller.config.forwarded-for"     = "true"
    "controller.config.load-balance"      = "roundrobin"
  }
}
