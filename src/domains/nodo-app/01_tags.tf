module "tag_config" {
  source      = "./modules/tag_config"
  domain      = var.domain
  environment = var.env
}
