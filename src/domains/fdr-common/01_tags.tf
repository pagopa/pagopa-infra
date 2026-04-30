module "tag_config" {
  source      = "../../tag_config"
  domain      = var.domain
  environment = var.env
}

locals {
  tags_grafana = merge(module.tag_config.tags, {
    "grafana" = "yes"
  })
}
