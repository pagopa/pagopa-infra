#################################### [PAGOPA ECOMMERCE] ####################################
locals {
  ecommerce_dashboard_path = "${path.module}/pagopa/ecommerce/dashboards/*.ndjson"
}

resource "null_resource" "pagopaecommerce_upload_dashboard" {

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.ecommerce_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/ecommerce/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT 
    interpreter = ["/bin/bash", "-c"]
  }
}
