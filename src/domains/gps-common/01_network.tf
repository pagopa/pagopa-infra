# Azure Storage subnet
module "storage_account_snet" {
  source                                        = "./.terraform/modules/__v3__/subnet"
  name                                          = "${local.project}-storage-account-snet"
  address_prefixes                              = var.gpd_sftp_cidr_subnet_gpd_storage_account
  resource_group_name                           = local.vnet_resource_group_name
  virtual_network_name                          = data.azurerm_virtual_network.vnet.name
  service_endpoints                             = ["Microsoft.Web", "Microsoft.AzureCosmosDB", "Microsoft.EventHub", "Microsoft.Storage"]
  private_link_service_network_policies_enabled = var.gpd_sftp_sa_snet_private_link_service_network_policies_enabled
}


resource "azurerm_private_dns_a_record" "ingress" {
  name                = local.ingress_hostname
  zone_name           = data.azurerm_private_dns_zone.internal.name
  resource_group_name = local.internal_dns_zone_resource_group_name
  ttl                 = 3600
  records             = [var.ingress_load_balancer_ip]
}
