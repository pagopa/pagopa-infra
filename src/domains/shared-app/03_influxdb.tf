# influxdb v2
resource "helm_release" "influxdb2" {
  name = "pagopa-influxdb2"

  repository = "https://helm.influxdata.com/"
  chart      = "influxdb2"
  version    = "2.1.0"
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
    value = false
  }

  set {
    name  = "ingress.hostname"
    value = format("weu%s.shared.internal.%s.platform.pagopa.it", var.env, var.env)
  }

  set {
    name  = "ingress.path"
    value = "/pagopa-influxdb/(.*)"
  }

}
