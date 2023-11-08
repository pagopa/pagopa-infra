resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress-elastic"
  }
}

# from Microsoft docs https://docs.microsoft.com/it-it/azure/aks/ingress-internal-ip
module "nginx_ingress" {
  source  = "terraform-module/release/helm"
  version = "2.8.0"

  namespace  = kubernetes_namespace.ingress.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  app = {
    name          = "nginx-ingress-elastic"
    version       = var.nginx_helm.version
    chart         = "ingress-nginx"
    recreate_pods = false #https://github.com/helm/helm/issues/6378 -> fixed in k8s 1.22
    deploy        = 1
  }

  values = [
    "${templatefile("${path.module}/ingress/loadbalancer.yaml.tpl", { load_balancer_ip = var.ingress_elk_load_balancer_ip })}",
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
              value = "60"
            }
          }
        ]
      }
    ),
  ]

  set = [
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
      name  = "controller.ingressClassResource.name"
      value = "nginxelk"
    },
    {
      name  = "controller.ingressClass"
      value = "nginxelk"
    },
    {
      name  = "controller.ingressClassResource.default"
      value = "false"
    },
    {
      name  = "controller.ingressClassResource.controllerValue"
      value = "k8s.io/nginxelk-controller"
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
