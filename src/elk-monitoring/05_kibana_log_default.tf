#################################### [NDP] ####################################
locals {

  default_snapshot_key = "default_snapshot_backup"
  default_snapshot_repo = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/snapshot_repo.json", {
    snapshot_container_name = local.deafult_snapshot_container_name
  }), "\""), "\""), "'", "'\\''")

  default_snapshot_policy_key = "default-nightly-snapshots"
  default_snapshot_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/snapshot_policy.json", {
    repository_name = local.default_snapshot_key
  }), "\""), "\""), "'", "'\\''")

  logs_key = "logs"
  logs_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "default policy for the logs index template installed by x-pack reviewed by PagoPA",
    managed = true,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")

  metrics_key = "metrics"
  metrics_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "default policy for the metrics index template installed by x-pack reviewed by PagoPA",
    managed = true,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")

  logs_apm_key = "logs-apm.app_logs-default_policy"
  logs_apm_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "apm reviewed by PagoPA",
    managed = true,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")
  
  logs_error_apm_key = "logs-apm.error_logs-default_policy"
  logs_error_apm_ilm_policy = replace(trimsuffix(trimprefix(templatefile("${path.module}/log-template/ilm-policy.json", {
    name = "apm reviewed by PagoPA",
    managed = true,
    policy_name = local.default_snapshot_policy_key
  }), "\""), "\""), "'", "'\\''")

}

resource "null_resource" "snapshot_repo" {
  depends_on = [module.elastic_stack]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_snapshot/${local.default_snapshot_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.default_snapshot_repo}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "snapshot_policy" {
  depends_on = [module.elastic_stack, null_resource.snapshot_repo]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_slm/policy/${local.default_snapshot_policy_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.default_snapshot_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "logs_ilm_policy" {
  depends_on = [module.elastic_stack,null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.logs_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.logs_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "metrics_ilm_policy" {
  depends_on = [module.elastic_stack,null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.metrics_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.metrics_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "apm_log_ilm_policy" {
  depends_on = [module.elastic_stack,null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.logs_apm_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.logs_apm_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}

resource "null_resource" "apm_log_error_ilm_policy" {
  depends_on = [module.elastic_stack,null_resource.snapshot_policy]

  triggers = {
    always_run = "${timestamp()}"
  }

  provisioner "local-exec" {
    command     = <<EOT
      curl -k -X PUT "${local.elastic_url}/_ilm/policy/${local.logs_error_apm_key}" \
      -H 'kbn-xsrf: true' \
      -H 'Content-Type: application/json' \
      -d '${local.logs_error_apm_ilm_policy}'
    EOT
    interpreter = ["/bin/bash", "-c"]
  }
}
