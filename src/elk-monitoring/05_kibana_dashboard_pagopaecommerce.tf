#################################### [PAGOPA ECOMMERCE] ####################################
locals {
  pagopa_namespace         = "pagopa"
  pagopaecommerce_key      = "ecommerce"
  ecommerce_dashboard_path = "${path.module}/${local.pagopa_namespace}/${local.pagopaecommerce_key}/dashboards/*.ndjson"
}

resource "null_resource" "pagopaecommerce_upload_dashboard" {

  triggers = {
    always_run = "${timestamp()}"
  }

  for_each = fileset(path.module, local.ecommerce_dashboard_path)

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/s/${local.pagopa_namespace}/api/saved_objects/_import?overwrite=true" \
      -H 'kbn-xsrf: true' \
      --form "file=@./${each.value}"
    EOT 
    interpreter = ["/bin/bash", "-c"]
  }
}
