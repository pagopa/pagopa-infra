resource "random_password" "admin_influxdb_password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

# influxdb v1
resource "helm_release" "influxdb" {
  count = var.env_short != "p" ? 1 : 0
  name  = "pagopa-influxdb"

  repository = "https://helm.influxdata.com/"
  chart      = "influxdb"
  version    = var.influxdb_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  set {
    name  = "image.repository"
    value = var.influxdb_helm.image.name
  }

  set {
    name  = "image.tag"
    value = var.influxdb_helm.image.tag
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

  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io\\/rewrite-target"
    value = "/$1"
  }

  set {
    name  = "setDefaultUser.enabled"
    value = true
  }

  set {
    name  = "setDefaultUser.user.username"
    value = "admin"
  }

  set {
    name  = "setDefaultUser.user.password"
    value = random_password.admin_influxdb_password.result
  }
}

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
    value = "/pagopa-influxdb2/(.*)"
  }
  set {
    name  = "ingress.annotations.nginx\\.ingress\\.kubernetes\\.io\\/rewrite-target"
    value = "/$1"
  }

  set {
    name  = "setDefaultUser.enabled"
    value = true
  }

  set {
    name  = "setDefaultUser.user.username"
    value = "admin"
  }

  set {
    name  = "setDefaultUser.user.password"
    value = random_password.admin_influxdb_password.result
  }
}
