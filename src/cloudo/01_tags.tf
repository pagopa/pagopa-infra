module "tag_config" {
  source      = "../tag_config"
  domain      = "cloudo"
  environment = var.env
}
