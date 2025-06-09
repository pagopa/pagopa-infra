module "tag_config" {
  source      = "../tag_config"
  domain      = var.domain
  environment = var.env
}
