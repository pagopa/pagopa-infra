resource "helm_release" "status_app" {

  name       = "status"
  chart      = "microservice-chart"
  repository = "https://pagopa.github.io/aks-microservice-chart-blueprint"
  version    = "2.8.0"
  namespace  = "zabbix"

  values = [
    file("${path.module}/templates/status_app.yaml.tpl"),
  ]
}

data "azurerm_key_vault_certificate_data" "zabbix_cert" {
  name         = "dev01-zabbix-internal-dev-cstar-pagopa-it"
  key_vault_id = data.azurerm_key_vault.kv_core.id
}

resource "kubernetes_secret" "zabbix_tls_secret" {
  metadata {
    name      = "dev01-zabbix-internal-dev-cstar-pagopa-it"
    namespace = "zabbix"
  }
  data = {
    "tls.crt" = data.azurerm_key_vault_certificate_data.zabbix_cert.pem
    "tls.key" = data.azurerm_key_vault_certificate_data.zabbix_cert.key
  }
  type = "kubernetes.io/tls"
}
