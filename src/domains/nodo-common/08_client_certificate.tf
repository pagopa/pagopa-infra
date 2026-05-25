data "azurerm_key_vault" "kv_ca" {
  name                = "${local.product}-${var.location_short}-core-ca-kv"
  resource_group_name = "${local.product}-${var.location_short}-core-ca-rg"
}

module "client_certificate" {
  source              = "./.terraform/modules/__v4__/keyvault_client_certificates"
  root_key_vault_id   = data.azurerm_key_vault.kv_ca.id
  root_key_vault_name = data.azurerm_key_vault.kv_ca.name

  certificates = {
    "forwarder${var.env == "prod" ? "" : "-${var.env}"}-platform-pagopa-it" = {
      key_vault_name     = data.azurerm_key_vault.key_vault.name
      subject            = "CN=forwarder${var.env == "prod" ? "" : ".${var.env}"}.platform.pagopa.it",
      validity_in_months = 12
      san_dns_names = [
        "forwarder${var.env == "prod" ? "" : ".${var.env}"}.platform.pagopa.it",
        "www.forwarder${var.env == "prod" ? "" : ".${var.env}"}.platform.pagopa.it"
      ]
    }
  }

  tags = module.tag_config.tags
}