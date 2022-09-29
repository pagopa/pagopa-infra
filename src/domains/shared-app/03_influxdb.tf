# influxdb v2
resource "helm_release" "influxdb2" {
  count = var.env_short != "p" ? 1 : 0
  name  = "pagopa-influxdb2"

  repository = "https://helm.influxdata.com/"
  chart      = "influxdb2"
  version    = var.influxdb2_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "image.repository"
    value = var.influxdb2_helm.image.name
  }

  set {
    name  = "image.tag"
    value = var.influxdb2_helm.image.tag
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
