locals {
  product = "${var.prefix}-${var.env_short}"

  #DNS
  forwarder_fqdn = "forwarder${var.env == "prod" ? "" : ".${var.env}"}.platform.pagopa.it"
}
