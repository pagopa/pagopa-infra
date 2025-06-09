# nodo-switcher

This domain creates 2 logic app workflows dedicated to switch automatically (with approval step if configured) between different instances of "nodo dei pagamenti".

The first step checks if the target "NdP" is up and running, and if configured sends the approval message to the configured slack webhook (se below), which will lead to the step 2. It triggers the second step immediately if configured to not send the approval message

In order to properly setup this domain you need a slack application and its webhook and you need to follow these steps:

- configure the following secrets:
  - `nodo-switcher-static-slack-user-id`: identifier used by the logic app step 1 to call the step 2 directly
  - `nodo-switcher-slack-webhook`: webhook provided by slack to send messages to the desired channel
  - `nodo-switcher-slack-team-id`*: slack team (organization) identifier, from which the requests to step 2 will come
  - `nodo-switcher-slack-channel-id`*: slack channel identifier, from which the requests to tep 2 wille come
  - `nodo-switcher-slack-app-id`: slack application identifier, from which the requests to tep 2 wille come
  - `nodo-switcher-allowed-slack-users`: array of slack user identifier that are allowed to approve the switch, in json encoded format (eg: `"[\"myid1\", \"myid2\"]"`)
- once the logic apps are deployed, copy the url of step 2 and configure it as `Request URL` in the slack app `Interactivity & Shortcuts` section


#### *: where to find slack team id and channel id?
opening slack on your browser and navigating to the desired channel, you will find the ids in the url

    https://app.slack.com/client/XXXXX/YYYYY

- `XXXXX` is the team id
- `YYYYY` is the channel id

<!-- markdownlint-disable -->
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azapi"></a> [azapi](#requirement\_azapi) | <= 1.3.0 |
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | <= 2.30.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | <= 3.53.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_logic_app_action_custom.call_nodo](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_custom) | resource |
| [azurerm_logic_app_action_custom.checks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_custom) | resource |
| [azurerm_logic_app_action_custom.elaborate_request](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_custom) | resource |
| [azurerm_logic_app_action_custom.parse_request](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_action_custom) | resource |
| [azurerm_logic_app_trigger_http_request.trigger_step_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_trigger_http_request) | resource |
| [azurerm_logic_app_trigger_http_request.trigger_step_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_trigger_http_request) | resource |
| [azurerm_logic_app_workflow.nodo_switcher_step_1](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_logic_app_workflow.nodo_switcher_step_2](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_workflow) | resource |
| [azurerm_resource_group.nodo_switcher](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.apim_values_editor_to_switcher_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_user_assigned_identity.nodo_switcher_identity](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity) | resource |
| [azurerm_api_management.apim](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/api_management) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.kv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.nodo_switcher_allowed_slack_users](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_switcher_slack_app_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_switcher_slack_channel_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_switcher_slack_team_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_switcher_slack_webhook](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.nodo_switcher_static_slack_user_id](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain"></a> [domain](#input\_domain) | n/a | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | One of westeurope, northeurope | `string` | n/a | yes |
| <a name="input_location_short"></a> [location\_short](#input\_location\_short) | One of wue, neu | `string` | n/a | yes |
| <a name="input_location_string"></a> [location\_string](#input\_location\_string) | One of West Europe, North Europe | `string` | n/a | yes |
| <a name="input_nodo_switcher"></a> [nodo\_switcher](#input\_nodo\_switcher) | n/a | <pre>object({<br/>    pagopa_nodo_url                  = string<br/>    trigger_max_age_minutes          = number<br/>    enable_switch_approval           = bool<br/>    force_execution_for_old_triggers = bool<br/>    apim_variables = list(object({<br/>      name  = string<br/>      value = string<br/>    }))<br/>  })</pre> | <pre>{<br/>  "apim_variables": [<br/>    {<br/>      "name": "apim_enable_nm3_decoupler_switch",<br/>      "value": "false"<br/>    },<br/>    {<br/>      "name": "apim_enable_routing_decoupler_switch",<br/>      "value": "false"<br/>    },<br/>    {<br/>      "name": "default_node_id",<br/>      "value": "NDP003PROD"<br/>    },<br/>    {<br/>      "name": "default-nodo-backend",<br/>      "value": "https://10.79.20.34"<br/>    }<br/>  ],<br/>  "enable_switch_approval": true,<br/>  "force_execution_for_old_triggers": false,<br/>  "pagopa_nodo_url": "https://httpbin.org/status/200",<br/>  "trigger_max_age_minutes": 30<br/>}</pre> | no |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
