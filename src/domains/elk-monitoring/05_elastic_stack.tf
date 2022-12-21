data "azurerm_private_dns_zone" "internal" {
  name                = local.internal_dns_zone_name
  resource_group_name = local.internal_dns_zone_resource_group_name
}

resource "azurerm_private_dns_a_record" "kibana_ingress" {
  name                = local.kibana_hostname_short
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}

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

### ECK CRDS YAML
#data "template_file" "crds_tpl" {
#  template = "${file("${path.module}/elk/crds.yaml.tpl")}"
#}
#resource "local_file" "crds_file" {
#  filename = "${path.module}/elk/crds.yaml"
#  content  = templatefile("${path.module}/elk/crds.yaml.tpl",{})

#    provisioner "local-exec" {
#    command = "kubectl apply -f ${self.filename}"
#  }
#}
#resource "local_file" "operator_file" {
#  filename = "${path.module}/elk/operator.yaml"
#  content  = templatefile("${path.module}/elk/operator.yaml.tpl",{})
#  
#    provisioner "local-exec" {
#    command = "kubectl apply -f ${self.filename}"
#  }
#}
#resource "null_resource" "crds_null" {

#  provisioner "local-exec" {
#    command = "kubectl -n elastic-system apply -f ${path.module}/elk/crds.yaml"
#  }
#}

#resource "null_resource" "operator_null" {
#
#  provisioner "local-exec" {
#    command = "kubectl -n elastic-system apply -f ${path.module}/elk/operator.yaml"
#  }
#}

resource "local_file" "elastic_file" {
  filename = "${path.module}/elk/elastic.yaml"
  content = templatefile("${path.module}/elk/elastic.yaml.tpl", {
    num_node_balancer      = var.elastic_cluster_config.num_node_balancer
    num_node_master        = var.elastic_cluster_config.num_node_master
    num_node_hot           = var.elastic_cluster_config.num_node_hot
    num_node_warm          = var.elastic_cluster_config.num_node_warm
    num_node_cold          = var.elastic_cluster_config.num_node_cold
    storage_size_balancer  = var.elastic_cluster_config.storage_size_balancer
    storage_size_master    = var.elastic_cluster_config.storage_size_master
    storage_size_hot       = var.elastic_cluster_config.storage_size_hot
    storage_size_warm      = var.elastic_cluster_config.storage_size_warm
    storage_size_cold      = var.elastic_cluster_config.storage_size_cold
    storage_class_balancer = "${local.project}-elastic-aks-storage-hot"
    storage_class_master   = "${local.project}-elastic-aks-storage-hot"
    storage_class_hot      = "${local.project}-elastic-aks-storage-hot"
    storage_class_warm     = "${local.project}-elastic-aks-storage-warm"
    storage_class_cold     = "${local.project}-elastic-aks-storage-cold"
  })

  provisioner "local-exec" {
    command = "kubectl -n elastic-system apply -f ${self.filename}"
  }

}

resource "kubernetes_manifest" "kibana_manifest" {
  field_manager {
    force_conflicts = true
  }
  computed_fields = ["metadata.labels", "metadata.annotations", "spec", "status"]
  manifest = yamldecode(templatefile("${path.module}/elk/kibana.yaml", {
    external_domain = "https://dev-pagopa.westeurope.cloudapp.azure.com/kibana" ####TEMP "${local.apim_hostname}/kibana"

  }))

}

resource "kubernetes_manifest" "ingress_manifest" {

  manifest = yamldecode(file("${path.module}/elk/ingress.yaml"))
}

resource "kubernetes_manifest" "apm_manifest" {
  field_manager {
    force_conflicts = true
  }
  computed_fields = ["metadata.labels", "metadata.annotations", "spec", "status"]
  manifest        = yamldecode(file("${path.module}/elk/apm.yaml"))


}

