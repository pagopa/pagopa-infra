#################################### [ECOMMERCE] ####################################
locals {

  pagopa_key = "pagopa"
  ecommerce_key    = "ecommerce"

  ecommerce_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/${path.pagopa_key}/${local.ecommerce_key}/namespace/namespace.json", {
    name = "${local.ecommerce_key}"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "ecommerce_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ecommerce_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}