#################################### [PAY WALLET] ####################################
locals {

  wallet_namespace = "paywallet"

  wallet_space = replace(trimsuffix(trimprefix(templatefile("${path.module}/pagopa/${local.wallet_namespace}/namespace/namespace.json", {
    name = "${local.wallet_namespace}"
  }), "\""), "\""), "'", "'\\''")
}

## space
resource "null_resource" "paywallet_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.wallet_space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}