resource "kubernetes_storage_class" "kubernetes_storage_class_hot" {
  metadata {
    name = "${local.project}-elastic-aks-storage-hot"
  }
  storage_provisioner = "disk.csi.azure.com"
  reclaim_policy      = "Retain"
  parameters = {
    skuName = var.elastic_hot_storage.storage_type
  }
  allow_volume_expansion = var.elastic_hot_storage.allow_volume_expansion

}

resource "kubernetes_storage_class" "kubernetes_storage_class_warm" {
  metadata {
    name = "${local.project}-elastic-aks-storage-warm"
  }
  storage_provisioner = "disk.csi.azure.com"
  reclaim_policy      = "Retain"
  parameters = {
    skuName = var.elastic_warm_storage.storage_type
  }
  allow_volume_expansion = var.elastic_warm_storage.allow_volume_expansion

}

resource "kubernetes_storage_class" "kubernetes_storage_class_cold" {
  metadata {
    name = "${local.project}-elastic-aks-storage-cold"
  }
  storage_provisioner = "disk.csi.azure.com"
  reclaim_policy      = "Retain"
  parameters = {
    skuName = var.elastic_cold_storage.storage_type
  }
  allow_volume_expansion = var.elastic_cold_storage.allow_volume_expansion

}
