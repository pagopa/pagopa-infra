data "azurerm_storage_account" "qa_shared_sa" {
  name                = replace("${local.project}-shared-sa", "-", "")
  resource_group_name = "${local.project}-sa-rg"
}

resource "kubernetes_secret" "mcp_catalog_sa" {
  metadata {
    name      = "mcp-catalog-sa-secret"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  type = "Opaque"
  data = {
    azurestorageaccountname = data.azurerm_storage_account.qa_shared_sa.name
    azurestorageaccountkey  = data.azurerm_storage_account.qa_shared_sa.primary_access_key
  }
}

resource "kubernetes_persistent_volume" "mcp_catalog_pv" {
  metadata {
    name = "mcp-catalog-pv"
  }
  spec {
    capacity = {
      storage = "1Gi"
    }
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = ""
    persistent_volume_source {
      csi {
        driver        = "file.csi.azure.com"
        volume_handle = "mcp-catalog-pv"
        volume_attributes = {
          shareName = "mcp-catalog"
        }
        node_stage_secret_ref {
          name      = kubernetes_secret.mcp_catalog_sa.metadata[0].name
          namespace = kubernetes_namespace.namespace.metadata[0].name
        }
      }
    }
  }
}

resource "kubernetes_persistent_volume_claim" "mcp_catalog_pvc" {
  metadata {
    name      = "mcp-catalog-pvc"
    namespace = kubernetes_namespace.namespace.metadata[0].name
  }
  spec {
    access_modes       = ["ReadWriteMany"]
    storage_class_name = ""
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    volume_name = kubernetes_persistent_volume.mcp_catalog_pv.metadata[0].name
  }
}
