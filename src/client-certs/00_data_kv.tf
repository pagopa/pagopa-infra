# Certification Authority Key Vault
data "azurerm_key_vault" "kv_ca" {
  name                = "${local.product}-${var.location_short}-core-ca-kv"
  resource_group_name = "${local.product}-${var.location_short}-core-ca-rg"
}

# Nodo Key Vault
data "azurerm_key_vault" "kv_nodo" {
  name                = "${local.product}-nodo-kv"
  resource_group_name = "${local.product}-nodo-sec-rg"
}