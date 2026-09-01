data "azurerm_storage_account" "qa_shared_sa" {
  name                = replace("${local.project}-shared-sa", "-", "")
  resource_group_name = "${local.project}-sa-rg"
}

data "azurerm_storage_share" "mcp_catalog" {
  name                 = "mcp-catalog"
  storage_account_name = data.azurerm_storage_account.qa_shared_sa.name
}

# Retrieve storage account key via az CLI — azurerm v4 data source does not expose primary_access_key.
data "external" "mcp_sa_key" {
  program = ["bash", "-c", "az storage account keys list --account-name ${data.azurerm_storage_account.qa_shared_sa.name} --resource-group ${data.azurerm_storage_account.qa_shared_sa.resource_group_name} --query '{key: [0].value}' -o json"]
}

resource "kubernetes_secret" "mcp_catalog_storage" {
  metadata {
    name      = "mcp-catalog-storage-secret"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  data = {
    azurestorageaccountname = data.azurerm_storage_account.qa_shared_sa.name
    azurestorageaccountkey  = data.external.mcp_sa_key.result.key
  }

  type = "Opaque"
}

resource "kubernetes_persistent_volume" "mcp_catalog" {
  metadata {
    name = "mcp-catalog-pv"
  }

  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = "azurefile-csi"

    persistent_volume_source {
      csi {
        driver        = "file.csi.azure.com"
        volume_handle = "${data.azurerm_storage_account.qa_shared_sa.name}#${data.azurerm_storage_share.mcp_catalog.name}"

        volume_attributes = {
          storageAccount = data.azurerm_storage_account.qa_shared_sa.name
          shareName      = data.azurerm_storage_share.mcp_catalog.name
          resourceGroup  = data.azurerm_storage_account.qa_shared_sa.resource_group_name
        }

        node_stage_secret_ref {
          name      = kubernetes_secret.mcp_catalog_storage.metadata[0].name
          namespace = kubernetes_secret.mcp_catalog_storage.metadata[0].namespace
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "mcp_catalog" {
  metadata {
    name      = "mcp-catalog-pvc"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }

  wait_until_bound = false

  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = "azurefile-csi"
    volume_name        = kubernetes_persistent_volume.mcp_catalog.metadata[0].name

    resources {
      requests = {
        storage = "1Gi"
      }
    }
  }
}
