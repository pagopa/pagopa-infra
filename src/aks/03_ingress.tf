resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
  }
}

# from Microsoft docs https://docs.microsoft.com/it-it/azure/aks/ingress-internal-ip
module "nginx_ingress" {
  source  = "terraform-module/release/helm"
  version = "2.7.0"

  namespace  = kubernetes_namespace.ingress.metadata[0].name
  repository = "https://kubernetes.github.io/ingress-nginx"
  app = {
    name          = "nginx-ingress"
    version       = var.nginx_helm_version
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
      name  = "controller.ingressClassResource.default"
      value = "true"
    }
  ]
}