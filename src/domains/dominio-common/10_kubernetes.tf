data "azurerm_kubernetes_cluster" "aks" {
  name                = "${local.aks_name}"
  resource_group_name = "${local.aks_rg_name}"
}

module "workload_identity" {
  source = "./.terraform/modules/__v4__/kubernetes_workload_identity_init"

  workload_identity_name_prefix         = local.domain
  workload_identity_resource_group_name = data.azurerm_kubernetes_cluster.aks.resource_group_name
  workload_identity_location            = var.location
}


data "azurerm_resources" "aks_load_balancers" {
  type = "Microsoft.Network/loadBalancers"

  required_tags = {
    "aks-managed-cluster-name": local.aks_name,
    "aks-managed-cluster-rg": local.aks_rg_name
  }
}

data "azurerm_lb" "internal_lb" {
  name                = "kubernetes-internal"
  resource_group_name = [for lb in data.azurerm_resources.aks_load_balancers.resources: lb if lb.name == "kubernetes-internal" ][0].resource_group_name
}


resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [data.azurerm_lb.internal_lb.private_ip_address]
}
