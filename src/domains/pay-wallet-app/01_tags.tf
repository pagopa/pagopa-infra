module "tag_config" {
  source      = "../../tag_config"
  domain      = replace(var.domain, "-", "")
  environment = var.env
}
