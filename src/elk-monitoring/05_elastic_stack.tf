module "elastic_stack" {
  source = "git::https://github.com/pagopa/azurerm.git//elastic_stack?ref=v4.9.0"

  namespace      = local.elk_namespace
  nodeset_config = var.nodeset_config

  kibana_external_domain = var.env_short == "p" ? "https://kibana.platform.pagopa.it/kibana" : "https://kibana.${var.env}.platform.pagopa.it/kibana"

  secret_name   = var.env_short == "p" ? "${var.location_short}${var.env}-kibana-internal-platform-pagopa-it" : "${var.location_short}${var.env}-kibana-internal-${var.env}-platform-pagopa-it"
  keyvault_name = module.key_vault.name

  kibana_internal_hostname = var.env_short == "p" ? "${var.location_short}${var.env}.kibana.internal.platform.pagopa.it" : "${var.location_short}${var.env}.kibana.internal.${var.env}.platform.pagopa.it"
}

#data "http" "elastic_health_check" {
#  depends_on = [module.elastic_stack]
#
#  url    = "https://elastic:6MvwX984Z72Gme6Ee24RH0pk@kibana.${var.env}.platform.pagopa.it/_cluster/health"
#  method = "GET"
#
#  request_headers = {}
#
#  request_body = ""
#}

#data "http" "create_nodo_api_key" {
#  depends_on = [data.http.elastic_health_check]
#
#  #########!!!!! user/password da leggere da kv? !!!!!!######
#  url    = "https://elastic:6MvwX984Z72Gme6Ee24RH0pk@kibana.${var.env}.platform.pagopa.it/_security/api_key?pretty"
#  method = "POST"
#
#  request_headers = {
#    Content-Type = "application/json;charset=UTF-8"
#    kbn-xsrf     = true
#  }
#
#  request_body = jsonencode(
#    {
#      "name" : "nodo-api-key",
#      "expiration" : "1d",
#      "role_descriptors" : {
#        "role-a" : {
#          "cluster" : [
#            "all"
#          ],
#          "index" : [
#            {
#              "names" : [
#                "index-a*"
#              ],
#              "privileges" : [
#                "read"
#              ]
#            }
#          ]
#        },
#        "role-b" : {
#          "cluster" : [
#            "all"
#          ],
#          "index" : [
#            {
#              "names" : [
#                "index-b*"
#              ],
#              "privileges" : [
#                "all"
#              ]
#            }
#          ]
#        }
#      },
#      "metadata" : {
#        "application" : "ndp",
#        "environment" : {
#          "level" : 1,
#          "trusted" : true,
#          "tags" : [
#            "dev",
#            "staging"
#          ]
#        }
#      }
#    }
#  )
#}

#data "http" "base_json_log_pipeline" {
#  depends_on = [data.http.create_nodo_api_key]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/_ingest/pipeline/base_json_log_pipeline"
#  method = "PUT"
#
#  request_headers = {
#    Accept   = "application/json"
#    kbn-xsrf = true
#  }
#
#  request_body = jsonencode(
#    {
#      "processors" : [
#        {
#          "json" : {
#            "field" : "message",
#            "target_field" : "json_message",
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.message",
#                  "value" : "Field 'message' is not a json format and not create 'json_message"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "set" : {
#            "field" : "message",
#            "copy_from" : "json_message.message",
#            "ignore_failure" : true,
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.message",
#                  "value" : "Field 'json_message.message' not found"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "set" : {
#            "field" : "app",
#            "copy_from" : "json_message.app",
#            "ignore_failure" : true,
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.app",
#                  "value" : "Field 'json_message.app' not found"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.app-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "remove" : {
#            "field" : "json_message",
#            "ignore_missing" : true
#          }
#        }
#      ]
#    }
#  )
#}

#data "http" "nodo_json_log_pipeline" {
#  depends_on = [data.http.base_json_log_pipeline]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/_ingest/pipeline/nodo_json_log_pipeline"
#  method = "POST"
#
#  request_headers = {
#    Accept        = "application/json"
#    kbn-xsrf      = true
#    Authorization = "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = jsonencode(
#    {
#      "processors" : [
#        {
#          "json" : {
#            "field" : "message",
#            "target_field" : "json_message",
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.message",
#                  "value" : "Field 'message' is not a json format and not create 'json_message"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "set" : {
#            "field" : "app",
#            "copy_from" : "json_message.app",
#            "ignore_failure" : true,
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.app",
#                  "value" : "Field 'json_message.app' not found"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.app-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "set" : {
#            "if" : "ctx.app?.reJsonLog != 'true'",
#            "field" : "message",
#            "copy_from" : "json_message.message",
#            "ignore_failure" : true,
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-info.message",
#                  "value" : "Field 'json_message.message' not found"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "json" : {
#            "if" : "ctx.app?.reJsonLog == 'true'",
#            "field" : "json_message.message",
#            "target_field" : "re",
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-re-info.message",
#                  "value" : "Field 'json_message.message' is not a json format and not create 're"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-re-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              },
#              {
#                "remove" : {
#                  "field" : "json_message",
#                  "ignore_missing" : true
#                }
#              }
#            ]
#          }
#        },
#        {
#          "set" : {
#            "if" : "ctx.app?.reJsonLog == 'true'",
#            "field" : "message",
#            "copy_from" : "re.internalMessage",
#            "ignore_failure" : true,
#            "on_failure" : [
#              {
#                "set" : {
#                  "field" : "error-re-internalMessage-info.message",
#                  "value" : "Field 're.internalMessage' not found"
#                }
#              },
#              {
#                "set" : {
#                  "description" : "Record error detail",
#                  "field" : "error-re-internalMessage-info.message-detail",
#                  "value" : "Processor {{ _ingest.on_failure_processor_type }} with tag {{ _ingest.on_failure_processor_tag }} in pipeline {{ _ingest.on_failure_pipeline }} failed with message {{ _ingest.on_failure_message }}"
#                }
#              }
#            ]
#          }
#        },
#        {
#          "drop" : {
#            "if" : "ctx.app?.reXmlLog == 'true'"
#          }
#        },
#        {
#          "remove" : {
#            "field" : "json_message",
#            "ignore_missing" : true
#          }
#        }
#      ]
#    }
#  )
#}

#data "http" "rule_pipeline" {
#  depends_on = [data.http.nodo_json_log_pipeline]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/_ingest/pipeline/rule_pipeline"
#  method = "POST"
#
#  request_headers = {
#    Accept        = "application/json"
#    kbn-xsrf      = true
#    Authorization = "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = jsonencode(
#    {
#      "processors" : [
#        {
#          "pipeline" : {
#            "description" : "Nodo - if 'kubernetes.namespace' is 'nodo' and 'kubernetes.labels.app_kubernetes_io/instance' is 'ndp' use 'nodo_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'ndp'",
#            "name" : "nodo_json_log_pipeline"
#          }
#        },
#        {
#          "pipeline" : {
#            "description" : "Nodo Replica - if 'kubernetes.namespace' is 'nodo' and 'kubernetes.labels.app_kubernetes_io/instance' is 'ndp-replica' use 'nodo_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'ndp-replica'",
#            "name" : "nodo_json_log_pipeline"
#          }
#        },
#        {
#          "pipeline" : {
#            "description" : "Nodo Cron - if 'kubernetes.namespace' is 'nodo-cron' and 'kubernetes.labels.app_kubernetes_io/instance' is 'ndp-cron' use 'nodo_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo-cron' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'ndp-cron'",
#            "name" : "nodo_json_log_pipeline"
#          }
#        },
#        {
#          "pipeline" : {
#            "description" : "Nodo Cron Replica - if 'kubernetes.namespace' is 'nodo-cron' and 'kubernetes.labels.app_kubernetes_io/instance' is 'ndp-cron' use 'nodo_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo-cron' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'ndp-cron-replica'",
#            "name" : "nodo_json_log_pipeline"
#          }
#        },
#        {
#          "pipeline" : {
#            "description" : "Webbo - if 'kubernetes.namespace' is 'nodo' and 'kubernetes.labels.app_kubernetes_io/instance' is 'pagopawebbo' use 'base_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'pagopawebbo'",
#            "name" : "base_json_log_pipeline"
#          }
#        },
#        {
#          "pipeline" : {
#            "description" : "Wfesp - if 'kubernetes.namespace' is 'nodo' and 'kubernetes.labels.app_kubernetes_io/instance' is 'pagopawfespwfesp' use 'base_json_log_pipeline'",
#            "if" : "ctx.data_stream?.dataset == 'kubernetes.container_logs' && ctx.kubernetes?.namespace == 'nodo' && ctx.kubernetes.labels['app_kubernetes_io/instance'] == 'pagopawfespwfesp'",
#            "name" : "base_json_log_pipeline"
#          }
#        }
#      ]
#    }
#  )
#}

#data "http" "logs_pagopa" {
#  depends_on = [data.http.rule_pipeline]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/_ilm/policy/logs_pagopa"
#  method = "POST"
#
#  request_headers = {
#    Accept        = "application/json"
#    kbn-xsrf      = true
#    Authorization = "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = jsonencode(
#    {
#      "policy" : {
#        "phases" : {
#          "hot" : {
#            "min_age" : "0ms",
#            "actions" : {
#              "rollover" : {
#                "max_primary_shard_size" : "50gb",
#                "max_age" : "2d"
#              }
#            }
#          },
#          "warm" : {
#            "min_age" : "2d",
#            "actions" : {
#              "set_priority" : {
#                "priority" : 50
#              }
#            }
#          },
#          "cold" : {
#            "min_age" : "4d",
#            "actions" : {
#              "set_priority" : {
#                "priority" : 0
#              }
#            }
#          },
#          "delete" : {
#            "min_age" : "7d",
#            "actions" : {
#              "delete" : {
#
#              }
#            }
#          }
#        },
#        "_meta" : {
#          "description" : "default policy for the logs index template installed pagopa",
#          "managed" : false
#        }
#      }
#    }
#  )
#}

#data "http" "logs_container_logs_custom" {
#  depends_on = [data.http.logs_pagopa]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/_component_template/logs-kubernetes.container_logs@custom"
#  method = "POST"
#
#  request_headers = {
#    Accept        = "application/json"
#    kbn-xsrf      = true
#    Authorization = "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = jsonencode(
#    {
#      "template" : {
#        "settings" : {
#          "index" : {
#            "default_pipeline" : "rule_pipeline",
#            "lifecycle.name" : "logs_pagopa"
#          }
#        }
#      },
#      "_meta" : {
#        "package" : {
#          "name" : "kubernetes"
#        },
#        "managed_by" : "fleet",
#        "managed" : true
#      }
#    }
#  )
#}

#data "http" "ingest_pipeline_rollover" {
#  depends_on = [data.http.logs_container_logs_custom]
#
#  url    = "https://kibana.${var.env}.platform.pagopa.it/logs-kubernetes.container_logs-default/_rollover/"
#  method = "POST"
#
#  request_headers = {
#    Accept        = "application/json"
#    kbn-xsrf      = true
#    Authorization = "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = ""
#}

#data "http" "dashboard" {
#  depends_on = [module.elastic_stack]
#
#  url = "https://kibana.${var.env}.platform.pagopa.it/kibana/api/saved_objects/_import"
#  method = "POST"
#
#  request_headers = {
#    Accept = "application/json"
#    kbn-xsrf= true
#    Authorization= "ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ=="
#  }
#
#  request_body = file("./nodo/dashboard/ndp_Global.ndjson")
#}

#resource "null_resource" "dashboard_destroy" {
#  provisioner "local-exec" {
#    when    = destroy
#    command = <<EOT
#      curl -X GET https://kibana.dev.platform.pagopa.it/kibana/api/saved_objects/_find \
#        -H 'kbn-xsrf:true' \
#        -H 'Content-Type: application/json' \
#        -H 'Authorization: ApiKey TjlKdmw0WUJmaTNUeWhSVkZYSGc6VDZNYTJUMkxRckN4cHRjTEd5VkRiQQ==' \
#        -G --data-urlencode 'type=dashboard' --data-urlencode 'search_fields=title' --data-urlencode 'search="[ndp"'
#    EOT
#  }
#}
