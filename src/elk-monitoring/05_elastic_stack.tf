module "elastic_stack" {
  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.5.0"

  namespace = local.elk_namespace
  nodeset_config = var.nodeset_config

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}
