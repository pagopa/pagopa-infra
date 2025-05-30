resource "azurerm_resource_group" "nodo_switcher" {
  name     = "${local.project}-nodo-switcher-rg"
  location = var.location
}

resource "azurerm_user_assigned_identity" "nodo_switcher_identity" {
  location            = var.location
  name                = "${local.project}-nodo-switcher-identity"
  resource_group_name = azurerm_resource_group.nodo_switcher.name
}


resource "azurerm_role_assignment" "apim_values_editor_to_switcher_identity" {
  scope                = data.azurerm_api_management.apim.id
  role_definition_name = "API Management Service Contributor"
  principal_id         = azurerm_user_assigned_identity.nodo_switcher_identity.principal_id
}

resource "azurerm_logic_app_workflow" "nodo_switcher_step_1" {
  name                = "${local.project}-switcher-step-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_switcher.name
  workflow_parameters = {
    "enable_switch_approval" = jsonencode({
      "type"         = "bool",
      "defaultValue" = var.nodo_switcher.enable_switch_approval
      "metadata" : {
        "description" : "If true, triggers the approval notification before updating the APIM configuration"
      }
    })
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.nodo_switcher_identity.id]
  }

  tags = module.tag_config.tags
}


resource "azurerm_logic_app_workflow" "nodo_switcher_step_2" {
  name                = "${local.project}-switcher-step-2"
  location            = var.location
  resource_group_name = azurerm_resource_group.nodo_switcher.name
  workflow_parameters = {
    "allowed_slack_users" = jsonencode({
      "type"         = "Array"
      "defaultValue" = concat(jsondecode(data.azurerm_key_vault_secret.nodo_switcher_allowed_slack_users.value), [data.azurerm_key_vault_secret.nodo_switcher_static_slack_user_id.value])
      "metadata" : {
        "description" : "List of slack user ids allowed to authorize the switch"
      }
    })
    "allowed_slack_team" = jsonencode({
      "type"         = "String"
      "defaultValue" = data.azurerm_key_vault_secret.nodo_switcher_slack_team_id.value
      "metadata" : {
        "description" : "slack team id allowed to execute the switch"
      }
    })
    "allowed_slack_channel" = jsonencode({
      "type"         = "String"
      "defaultValue" = data.azurerm_key_vault_secret.nodo_switcher_slack_channel_id.value
      "metadata" : {
        "description" : "slack channel id allowed to execute the switch"
      }
    })
    "allowed_slack_app" = jsonencode({
      "type"         = "String"
      "defaultValue" = data.azurerm_key_vault_secret.nodo_switcher_slack_app_id.value
      "metadata" : {
        "description" : "slack app id allowed to execute the switch"
      }
    })
    "force_execution_for_old_triggers" = jsonencode({
      "type"         = "bool"
      "defaultValue" = var.nodo_switcher.force_execution_for_old_triggers
      "metadata" : {
        "description" : "If true, allows old trigger message to execute the switch"
      }
    })
  }
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.nodo_switcher_identity.id]
  }

  tags = module.tag_config.tags
}


resource "azurerm_logic_app_trigger_http_request" "trigger_step_1" {
  name         = "trigger"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_1.id

  schema = <<SCHEMA
    {
        "type": "object",
        "properties": {
        }
    }
    SCHEMA

}

resource "azurerm_logic_app_trigger_http_request" "trigger_step_2" {
  name         = "trigger"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_2.id
  method       = "POST"
  schema       = <<SCHEMA
    {
      "type": "object",
      "properties": {
        "$content-type": {
          "type": "string"
        },
        "$content": {
          "type": "string"
        },
        "$formdata": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "key": {
                "type": "string"
              },
              "value": {
                "type": "string"
              }
            },
            "required": [
              "key",
              "value"
            ]
          }
        }
      }
    }
    SCHEMA

}




resource "azurerm_logic_app_action_custom" "call_nodo" {
  name         = "call-pagopa-nodo"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_1.id
  depends_on   = [azurerm_logic_app_trigger_http_request.trigger_step_1]
  body         = <<BODY
  {
      "description": "Checks if pagoPA's nodo is up and running",
      "inputs": {
          "authentication": {
              "audience": "",
              "type": "ManagedServiceIdentity",
              "identity": "${azurerm_user_assigned_identity.nodo_switcher_identity.id}"
          },
          "method": "POST",
          "uri": "${var.nodo_switcher.pagopa_nodo_url}"
      },
      "runAfter": {},
      "runtimeConfiguration": {
          "contentTransfer": {
              "transferMode": "Chunked"
          }
      },
      "type": "Http"
  }
  BODY

}



resource "azurerm_logic_app_action_custom" "checks" {
  name         = "check-pagopa-nodo"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_1.id
  depends_on   = [azurerm_logic_app_action_custom.call_nodo]
  body         = <<BODY
  {
    "type": "If",
    "expression": {
        "and": [
            {
              "equals": [
                "@outputs('call-pagopa-nodo')?['statusCode']",
                200
              ]
            }
          ]
      },
      "actions": {
        "check-approval": {
          "description": "Checks if the approval is enabled",
          "type": "If",
          "expression": {
            "and": [
              {
                "equals": [
                  "@parameters('enable_switch_approval')",
                  true
                ]
              }
            ]
          },
          "actions": {
            "send-approval-message": {
              "type": "Http",
              "inputs": {
                "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                "method": "POST",
                "headers": {
                  "Content-Type": "application/json"
                },
                "body": {
                  "text": "Eseguire lo switch del nodo?",
                  "blocks": [
                    {
                      "type": "section",
                      "fields": [
                        {
                          "type": "mrkdwn",
                          "text": ":warning: :exclamation: *${var.env}* - Procedere con lo switch verso il NdP di PagoPA?"
                        }
                      ]
                    },
                    {
                      "type": "section",
                      "fields": [
                        {
                          "type": "mrkdwn",
                          "text": ":clock3: Azione valida per ${var.nodo_switcher.trigger_max_age_minutes} minuti"
                        }
                      ]
                    },
                    {
                      "type": "actions",
                      "elements": [
                        {
                          "type": "button",
                          "text": {
                            "type": "plain_text",
                            "text": "Si",
                            "emoji": true
                          },
                          "style": "danger",
                          "confirm": {
                            "title": {
                                "type": "plain_text",
                                "text": "Confermi?"
                            },
                            "text": {
                                "type": "plain_text",
                                "text": "Vuoi procedere con lo switch in ambiente ${var.env}?"
                            },
                            "confirm": {
                                "type": "plain_text",
                                "text": "Procedi"
                            },
                            "deny": {
                                "type": "plain_text",
                                "text": "Annulla"
                            }
                          },
                          "value": "@utcNow()"

                        },
                        {
                          "type": "button",
                          "text": {
                            "type": "plain_text",
                            "text": "No",
                            "emoji": false
                          },
                          "value": "false"

                        }
                      ]
                    }
                  ]
                }
              },
              "runtimeConfiguration": {
                "contentTransfer": {
                  "transferMode": "Chunked"
                }
              }
            }
          },
          "else": {
            "actions": {
              "trigger-step-2": {
                "type": "Http",
                "inputs": {
                  "uri": "${azurerm_logic_app_workflow.nodo_switcher_step_2.access_endpoint}",
                  "method": "POST",
                  "body": {
                    "$content-type": "application/x-www-form-urlencoded",
                    "$content": "not used",
                    "$formdata": [
                      {
                        "key": "payload",
                        "value": "{ \"type\": \"block_actions\", \"user\": {\"id\": \"${data.azurerm_key_vault_secret.nodo_switcher_static_slack_user_id.value}\",\"username\": \"AZ.logicApp\",\"name\": \"AZ.logicApp\",\"team_id\": \"${data.azurerm_key_vault_secret.nodo_switcher_slack_team_id.value}\" }, \"api_app_id\": \"${data.azurerm_key_vault_secret.nodo_switcher_slack_app_id.value}\", \"token\": \"\", \"container\": {}, \"trigger_id\": \"\", \"team\": {}, \"enterprise\": null, \"is_enterprise_install\": false, \"channel\": { \"id\": \"${data.azurerm_key_vault_secret.nodo_switcher_slack_channel_id.value}\"}, \"message\": {}, \"state\": {}, \"response_url\": \"\", \"actions\": [{ \"action_id\": \"\", \"block_id\": \"\", \"text\": { \"type\": \"plain_text\", \"text\": \"Si\", \"emoji\": true }, \"value\": \"@utcNow()\", \"type\": \"button\", \"action_ts\": \"\"} ]}"
                      }
                    ]
                  }
                },
                "runtimeConfiguration": {
                  "contentTransfer": {
                    "transferMode": "Chunked"
                  }
                }
              }
            }
          }
        }
      },
      "else": {
        "actions": {
          "send-failure-message": {
              "type": "Http",
              "inputs": {
                "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                "method": "POST",
                "headers": {
                  "Content-Type": "application/json"
                },
                "body": {
                  "text": ":warning: Ricevuto alert, ma il nodo target non è disponibile."
                }
              },
              "runtimeConfiguration": {
                "contentTransfer": {
                  "transferMode": "Chunked"
                }
              }
          },
          "end": {
            "description": "pagopa nodo not available. teminating",
            "type": "Terminate",
            "inputs": {
              "runStatus": "Cancelled"
            },
            "runAfter": {
              "send-failure-message": [
                  "SUCCEEDED"
              ]
            }
          }
        }
      },
      "runAfter": {
        "call-pagopa-nodo": [
            "SUCCEEDED"
          ]
      },
      "description": "Checks if pagoPA nodo is up and running"
  }
  BODY
}







resource "azurerm_logic_app_action_custom" "parse_request" {
  name         = "parse-request"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_2.id
  depends_on   = [azurerm_logic_app_action_custom.call_nodo]
  body         = <<BODY
    {
      "type": "ParseJson",
      "inputs": {
        "content": "@triggerBody()?['$formdata']",
        "schema": {
          "type": "array",
          "items": {
            "type": "object",
            "properties": {
              "key": {
                "type": "string"
              },
              "value": {
                "type": "string"
              }
            },
            "required": [
              "key",
              "value"
            ]
          }
        }
      },
      "runAfter": {}
    }
  BODY
}

resource "azurerm_logic_app_action_custom" "elaborate_request" {
  name         = "elaborate-request"
  logic_app_id = azurerm_logic_app_workflow.nodo_switcher_step_2.id
  depends_on   = [azurerm_logic_app_action_custom.parse_request]
  body         = <<BODY
    {
      "type": "Foreach",
      "foreach": "@outputs('parse-request')['body']",
      "description": "for each item in the request $formdata",
      "actions": {
        "parse-content": {
          "type": "ParseJson",
          "description": "Parse slack action body",
          "inputs": {
            "content": "@items('elaborate-request')['value']",
            "schema": {
              "type": "object",
              "properties": {
                "type": {
                  "type": "string"
                },
                "user": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "username": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    },
                    "team_id": {
                      "type": "string"
                    }
                  }
                },
                "api_app_id": {
                  "type": "string"
                },
                "token": {
                  "type": "string"
                },
                "container": {
                  "type": "object",
                  "properties": {
                    "type": {
                      "type": "string"
                    },
                    "message_ts": {
                      "type": "string"
                    },
                    "channel_id": {
                      "type": "string"
                    },
                    "is_ephemeral": {
                      "type": "boolean"
                    }
                  }
                },
                "trigger_id": {
                  "type": "string"
                },
                "team": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "domain": {
                      "type": "string"
                    }
                  }
                },
                "enterprise": {},
                "is_enterprise_install": {
                  "type": "boolean"
                },
                "channel": {
                  "type": "object",
                  "properties": {
                    "id": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  }
                },
                "message": {
                  "type": "object",
                  "properties": {
                    "subtype": {
                      "type": "string"
                    },
                    "text": {
                      "type": "string"
                    },
                    "type": {
                      "type": "string"
                    },
                    "ts": {
                      "type": "string"
                    },
                    "bot_id": {
                      "type": "string"
                    },
                    "blocks": {
                      "type": "array",
                      "items": {
                        "type": "object",
                        "properties": {
                          "type": {
                            "type": "string"
                          },
                          "block_id": {
                            "type": "string"
                          },
                          "text": {
                            "type": "object",
                            "properties": {
                              "type": {
                                "type": "string"
                              },
                              "text": {
                                "type": "string"
                              },
                              "verbatim": {
                                "type": "boolean"
                              }
                            }
                          },
                          "elements": {
                            "type": "array",
                            "items": {
                              "type": "object",
                              "properties": {
                                "type": {
                                  "type": "string"
                                },
                                "action_id": {
                                  "type": "string"
                                },
                                "text": {
                                  "type": "object",
                                  "properties": {
                                    "type": {
                                      "type": "string"
                                    },
                                    "text": {
                                      "type": "string"
                                    },
                                    "emoji": {
                                      "type": "boolean"
                                    }
                                  }
                                },
                                "value": {
                                  "type": "string"
                                }
                              },
                              "required": [
                                "type",
                                "action_id",
                                "text",
                                "value"
                              ]
                            }
                          }
                        },
                        "required": [
                          "type",
                          "block_id"
                        ]
                      }
                    }
                  }
                },
                "state": {
                  "type": "object",
                  "properties": {
                    "values": {
                      "type": "object",
                      "properties": {}
                    }
                  }
                },
                "response_url": {
                  "type": "string"
                },
                "actions": {
                  "type": "array",
                  "items": {
                    "type": "object",
                    "properties": {
                      "action_id": {
                        "type": "string"
                      },
                      "block_id": {
                        "type": "string"
                      },
                      "text": {
                        "type": "object",
                        "properties": {
                          "type": {
                            "type": "string"
                          },
                          "text": {
                            "type": "string"
                          },
                          "emoji": {
                            "type": "boolean"
                          }
                        }
                      },
                      "value": {
                        "type": "string"
                      },
                      "type": {
                        "type": "string"
                      },
                      "action_ts": {
                        "type": "string"
                      }
                    },
                    "required": [
                      "action_id",
                      "block_id",
                      "text",
                      "value",
                      "type",
                      "action_ts"
                    ]
                  }
                }
              }
            }
          }
        },
        "check-allowed-user": {
          "type": "If",
          "description": "Check if the user who clicked on the action is allowed to approve the switch",
          "expression": {
            "and": [
              {
                "contains": [
                  "@parameters('allowed_slack_users')",
                  "@body('parse-content')?['user']?['id']"
                ]
              },
              {
                "equals": [
                  "@parameters('allowed_slack_team')",
                  "@body('parse-content')?['user']?['team_id']"
                ]
              },
              {
                "equals": [
                  "@parameters('allowed_slack_app')",
                  "@body('parse-content')?['api_app_id']"
                ]
              },
              {
                "equals": [
                  "@parameters('allowed_slack_channel')",
                  "@body('parse-content')?['channel']?['id']"
                ]
              }
            ]
          },
          "actions": {
            "for-each-input-action": {
              "type": "Foreach",
              "description": "for each action in the action list. it should always be one",
              "foreach": "@outputs('parse-content')?['body']?['actions']",
              "actions": {
                "check-action-not-false": {
                  "description": "check if action value is not false. if not, it contains the message timestamp",
                  "type": "If",
                  "expression": {
                    "and": [
                      {
                        "not": {
                          "equals": [
                            "@items('for-each-input-action')?['value']",
                            "false"
                          ]
                        }
                      }
                    ]
                  },
                  "actions": {
                    "check-action-timestamp": {
                      "type": "If",
                      "description": "checks if the message timestamps is not older than the defined threshold and if ",
                      "expression": {
                        "or": [
                          {
                            "greater": [
                              "@items('for-each-input-action')?['value']",
                              "@addMinutes(utcNow(), -${var.nodo_switcher.trigger_max_age_minutes})"
                            ]
                          },
                          {
                            "equals": [
                              "@parameters('force_execution_for_old_triggers')",
                              true
                            ]
                          }
                        ]
                      },
                      "actions": {
                        "update-apim-values": {
                          "type": "Scope",
                          "actions": {
                            %{for i, variable in var.nodo_switcher.apim_variables}
                            "update-${variable.name}": {
                              "description": "Update APIm named value to switch toward pagoPA's nodo",
                              "type": "Http",
                              "inputs": {
                                "uri": "https://management.azure.com/subscriptions/${data.azurerm_subscription.current.subscription_id}/resourceGroups/${local.pagopa_apim_rg}/providers/Microsoft.ApiManagement/service/${local.pagopa_apim_name}/namedValues/${variable.name}?api-version=2022-08-01",
                                "method": "PATCH",
                                "body": {
                                  "properties": {
                                    "value": "${variable.value}"
                                  }
                                },
                                "headers": {
                                      "If-Match": "*"
                                },
                                "authentication": {
                                    "type": "ManagedServiceIdentity",
                                    "identity": "${azurerm_user_assigned_identity.nodo_switcher_identity.id}"
                                }
                              },
                              "runtimeConfiguration": {
                                "contentTransfer": {
                                    "transferMode": "Chunked"
                                }
                              }
                            } %{if i < length(var.nodo_switcher.apim_variables) - 1},%{endif}
                            %{endfor}
                          }
                        },
                        "send-success-message": {
                          "type": "Http",
                          "inputs": {
                            "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                            "method": "POST",
                            "headers": {
                              "Content-Type": "application/json"
                            },
                            "body": {
                              "text": ":white_check_mark: Switch completato"
                            }
                          },
                          "runtimeConfiguration": {
                            "contentTransfer": {
                              "transferMode": "Chunked"
                            }
                          },
                          "runAfter": {
                            "update-apim-values": [
                              "Succeeded"
                            ]
                          }
                        },
                        "send-failure-message": {
                          "type": "Http",
                          "inputs": {
                            "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                            "method": "POST",
                            "headers": {
                              "Content-Type": "application/json"
                            },
                            "body": {
                              "text": ":large_red_square: Switch fallito"
                            }
                          },
                          "runtimeConfiguration": {
                            "contentTransfer": {
                              "transferMode": "Chunked"
                            }
                          },
                          "runAfter": {
                            "update-apim-values": [
                              "Failed"
                            ]
                          }
                        }
                      },
                      "else": {
                        "actions": {
                          "send-action-too-old-message": {
                            "type": "Http",
                            "inputs": {
                              "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                              "method": "POST",
                              "headers": {
                                "Content-Type": "application/json"
                              },
                              "body": {
                                "text": ":hourglass: Approvazione inviata fuori tempo massimo (${var.nodo_switcher.trigger_max_age_minutes} minuti)"
                              }
                            },
                            "runtimeConfiguration": {
                              "contentTransfer": {
                                "transferMode": "Chunked"
                              }
                            }
                          }
                        }
                      }
                    }
                  },
                  "else": {
                    "actions": {
                      "send-not-approved-message": {
                        "type": "Http",
                        "inputs": {
                          "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                          "method": "POST",
                          "headers": {
                            "Content-Type": "application/json"
                          },
                          "body": {
                            "text": ":negative_squared_cross_mark: Switch non approvato. Operazione interrotta"
                          }
                        },
                        "runtimeConfiguration": {
                          "contentTransfer": {
                            "transferMode": "Chunked"
                          }
                        }
                      }
                    }
                  }
                }
              }
            }
          },
          "else": {
            "actions": {
              "send-user-not-allowed-message": {
                "type": "Http",
                "inputs": {
                  "uri": "${data.azurerm_key_vault_secret.nodo_switcher_slack_webhook.value}",
                  "method": "POST",
                  "headers": {
                    "Content-Type": "application/json"
                  },
                  "body": {
                    "text": ":hand: Utente non abilitato allo switch. Operazione interrotta"
                  }
                },
                "runtimeConfiguration": {
                  "contentTransfer": {
                    "transferMode": "Chunked"
                  }
                }
              }
            }
          },
          "runAfter": {
            "parse-content": [
              "Succeeded"
            ]
          }
        }
      },
      "runAfter": {
        "parse-request": [
          "Succeeded"
        ]
      }
    }
  BODY
}




