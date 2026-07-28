resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "${var.domain}-cron"
  }
}



#
# K8s service account - used here the same from node domain in order to make both
# nodo and nodo-cron use the same workload identity
#
locals {
  nodo_workload_identity_name = "${var.domain}-workload-identity"
}


data "azurerm_key_vault_secret" "nodo_cron_workload_identity_client_id" {
  name         = "nodo-workload-identity-client-id"
  key_vault_id = data.azurerm_key_vault.nodo_kv.id
}

data "azurerm_key_vault_secret" "nodo_cron_workload_identity_service_account_name" {
  name         = "nodo-workload-identity-service-account-name"
  key_vault_id = data.azurerm_key_vault.nodo_kv.id
}

resource "kubernetes_service_account_v1" "nodo_cron_workload_identity_sa" {
  metadata {
    name      = data.azurerm_key_vault_secret.nodo_cron_workload_identity_service_account_name.value
    namespace = "nodo-cron"
    annotations = {
      "azure.workload.identity/client-id" = data.azurerm_key_vault_secret.nodo_cron_workload_identity_client_id.value
    }
  }
}