# Storage subnet
module "cruscotto_storage_snet" {
  count  = var.env_short == "d" ? 0 : 1
  source = "./.terraform/modules/__v4__/subnet"

  name                 = "${local.project}-storage-snet"
  address_prefixes     = var.cidr_subnet_storage_account
  resource_group_name  = local.vnet_italy_resource_group_name
  virtual_network_name = local.vnet_italy_name

  private_endpoint_network_policies = "Disabled"

  service_endpoints = [
    "Microsoft.Storage",
  ]
}

