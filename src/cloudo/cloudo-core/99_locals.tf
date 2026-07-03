
locals {
  product        = "${var.prefix}-${var.env_short}"
  product_region = "${var.prefix}-${var.env_short}-${var.location_short}"
  product_ita    = "${var.prefix}-${var.env_short}-${var.location_short_ita}"

  aks_integration_clusters = {
    weu = data.azurerm_kubernetes_cluster.aks_weu
  }

  aks_private_clusters = {
    for cluster_key, cluster in local.aks_integration_clusters :
    cluster_key => {
      node_resource_group = cluster.node_resource_group
      private_dns_zone_name = join(
        ".",
        slice(
          split(".", cluster.private_fqdn),
          1,
          length(split(".", cluster.private_fqdn))
        )
      )
    }
    if cluster.private_fqdn != null && cluster.private_fqdn != ""
  }
}
