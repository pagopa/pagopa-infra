#################################### [ECOMMERCE] ####################################
locals {

  ecommerce_namespace = "ecommerce"

  ecommerce_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/${local.ecommerce_namespace}/namespace/namespace.json", {
    name = "${local.ecommerce_namespace}"
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