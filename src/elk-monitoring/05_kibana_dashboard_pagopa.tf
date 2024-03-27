#################################### [PAGOPA ECOMMERCE] ####################################
locals {
  pagopa_dashboard_path = "${path.module}/pagopa/dashboard.ndjson"
}

resource "null_resource" "pagopa_upload_dashboard" {

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.pagopa_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/pagopa/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT 
    interpreter = ["/bin/bash", "-c"]
  }
}
