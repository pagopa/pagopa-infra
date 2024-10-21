module "letsencrypt" {
  source = "git::https://github.com/pagopa/terraform-azurerm-v3.git//letsencrypt_credential?ref=v8.56.0"

  prefix            = var.prefix
  env               = var.env_short
  key_vault_name    = module.key_vault.name
  subscription_name = data.azurerm_subscription.current.display_name
}

resource "helm_release" "cert_mounter" { # It needs tls_checker
  depends_on = [module.pod_identity]

  name         = "cert-mounter-blueprint"
  repository   = "https://pagopa.github.io/aks-helm-cert-mounter-blueprint"
  chart        = "cert-mounter-blueprint"
  version      = "1.0.4"
  namespace    = kubernetes_namespace.namespace.metadata[0].name
  timeout      = 120
  force_update = true

  values = ["${
    templatefile("${path.root}/helm/cert-mounter.yaml.tpl", {
      NAMESPACE        = kubernetes_namespace.namespace.metadata[0].name
      DOMAIN           = var.domain
      CERTIFICATE_NAME = replace(local.apisix_hostname, ".", "-"),
      ENV_SHORT        = var.env_short,
      TENANT_ID        = data.azurerm_subscription.current.tenant_id
    })
  }"]
}

resource "kubernetes_ingress_v1" "apisix" {
  metadata {
    name      = "apisix"
    namespace = kubernetes_namespace.namespace.metadata[0].name
    annotations = {
      "nginx.ingress.kubernetes.io/rewrite-target" = "/$1"
      "nginx.ingress.kubernetes.io/ssl-redirect"   = false
      "nginx.ingress.kubernetes.io/use-regex"      = true
    }
  }

  spec {
    ingress_class_name = "nginxelk"

    rule {
      host = local.apisix_hostname

      http {
        path {
          path = "/(.*)"
          backend {
            service {
              name = "apisix-gateway"
              port {
                number = 80
              }
            }
          }
        }
      }
    }

    tls {
      hosts       = [local.apisix_hostname]
      secret_name = replace(local.apisix_hostname, ".", "-")
    }
  }
}
