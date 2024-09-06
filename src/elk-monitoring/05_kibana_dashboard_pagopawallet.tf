#################################### [PAGOPA WALLET] ####################################
locals {
  wallet_dashboard_path = "${path.module}/pagopa/paywallet/dashboards/*.ndjson"
}

resource "null_resource" "pagopapaywallet_migration_dashboard" {
  depends_on = [null_resource.paywallet_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.wallet_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/paywallet/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT 
    interpreter = ["/bin/bash", "-c"]
  }
}
