resource "kubernetes_namespace" "opencost" {
  metadata {
    name = "opencost"
  }
}

resource "helm_release" "opencost" {
  name       = "opencost"
  namespace  = kubernetes_namespace.opencost.metadata[0].name
  repository = "https://opencost.github.io/opencost-helm-chart"
  chart      = "opencost"
  version    = "1.42.3"

  values = [
    <<EOF
{
  "opencost": {
    "prometheus": {
      "internal": {
        "namespaceOverride": "elastic-system",
        "port": "9090",
        "serviceName": "prometheus-kube-prometheus-prometheus",
      },
      "serviceDiscovery": {
        "enabled": true
      }
    },
    "exporter": {
      "extraVolumeMounts": []
    }
  },
  "extraVolumes": []
}
EOF
  ]

}
