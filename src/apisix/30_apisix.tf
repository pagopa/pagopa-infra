data "azurerm_key_vault_secret" "admin_apikey" {
  name         = "${local.project}-admin-apikey"
  key_vault_id = module.key_vault.id
}

data "azurerm_key_vault_secret" "viewer_apikey" {
  name         = "${local.project}-viewer-apikey"
  key_vault_id = module.key_vault.id
}

resource "helm_release" "apisix" {
  name       = "apisix"
  chart      = "apisix"
  repository = "https://charts.apiseven.com"
  version    = var.apisix_helm.chart_version
  namespace  = kubernetes_namespace.namespace.metadata[0].name

  values = ["${
    templatefile("${path.root}/helm/apisix.yaml.tpl", {
      ADMIN_TOKEN  = data.azurerm_key_vault_secret.admin_apikey.value
      VIEWER_TOKEN = data.azurerm_key_vault_secret.viewer_apikey.value
    })
  }"]
}
