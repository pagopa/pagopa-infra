#################################### [PAGOPA PAYMENT OPTIONS] ####################################
locals {
  paymentoptions_dashboard_path = "${path.module}/pagopa/paymentoptions/dashboards/*.ndjson"
}

resource "null_resource" "pagopapaymentoptions_migration_dashboard" {
  depends_on = [null_resource.paymentoptions_kibana_space]

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.paymentoptions_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/paymentoptions/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
