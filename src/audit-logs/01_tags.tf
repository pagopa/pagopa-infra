module "tag_config" {
  source      = "../tag_config"
  domain      = local.domain
  environment = var.env
}
