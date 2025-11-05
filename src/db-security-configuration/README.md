# db-security-configuration

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azuread"></a> [azuread](#requirement\_azuread) | ~> 3.1 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 4.16 |
| <a name="requirement_null"></a> [null](#requirement\_null) | <= 3.2.1 |
| <a name="requirement_restapi"></a> [restapi](#requirement\_restapi) | 2.0.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tag_config"></a> [tag\_config](#module\_tag\_config) | ../tag_config | n/a |

## Resources

| Name | Type |
|------|------|
| [restapi_object.databases](https://registry.terraform.io/providers/Mastercard/restapi/2.0.1/docs/resources/object) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_key_vault.key_vault_core](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault.password_keyvault](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_key_vault_secret.database_password](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_key_vault_secret.metabase_api_key](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault_secret) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_databases"></a> [databases](#input\_databases) | Map of database name and connection properties to be added to metabase | <pre>map(object({<br/>    type                    = string<br/>    host                    = string<br/>    port                    = optional(string, null)<br/>    db_name                 = optional(string, null)<br/>    username                = string<br/>    password_required       = bool<br/>    password_secret_kv_name = optional(string, null)<br/>    password_secret_kv_rg   = optional(string, null)<br/>    password_secret_key     = optional(string, null)<br/>    catalog                 = optional(string, null)<br/>    schema                  = optional(string, null)<br/>    user_control_scheduling = optional(bool, null)<br/>    advanced_options        = optional(bool, null)<br/>  }))</pre> | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | n/a | `string` | n/a | yes |
| <a name="input_env_short"></a> [env\_short](#input\_env\_short) | n/a | `string` | n/a | yes |
| <a name="input_prefix"></a> [prefix](#input\_prefix) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
