# influxdb v2
resource "helm_release" "influxdb2" {
  name = "pagopa-influxdb2"

  repository = "https://helm.influxdata.com/"
  chart      = "influxdb2"
  version    = var.influxdb2_helm_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "service.type"
    value = "ClusterIP"
  }

  set {
    name  = "ingress.enabled"
    value = true
  }

  set {
    name  = "ingress.tls"
    value = true
  }

  set {
    name  = "ingress.hostname"
    value = "weu${var.env}.shared.internal.${var.env}.platform.pagopa.it"
  }

  set {
    name  = "ingress.path"
    value = "/pagopa-influxdb/(.*)"
  }

}
