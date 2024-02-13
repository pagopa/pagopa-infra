#################################### [NDP-AUX] ####################################
locals {
  ndpAux_domain = {
    space = "ndp-aux"
  }

  ndpAux_kibana = {
    space = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/space.json", {
      name = "${local.ndpAux_domain.space}"
    }), "\""), "\""), "'", "'\\''")
  }
}

## space
resource "null_resource" "ndp_aux_kibana_space" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X POST "${local.kibana_url}/api/spaces/space" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.ndpAux_kibana.space}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

