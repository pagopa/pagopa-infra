module "tag_config" {
  source      = "../tag_config"
  domain      = "core"
  environment = var.env
}
