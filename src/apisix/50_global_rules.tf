# locals {
#   global_rules = {
#     key-auth = {
#       _meta            = { disabled = false }
#       header           = "Ocp-Apim-Subscription-Key"
#       hide_credentials = true
#     }
#   }
# }
#
# resource "terracurl_request" "global_rules" {
#   name   = "global_rules"
#   url    = "${local.apisix_admin_base_path}/global_rules/1"
#   method = "PUT"
#
#   headers = {
#     X-API-KEY = data.azurerm_key_vault_secret.admin_apikey.value
#   }
#
#   request_body = jsonencode({ plugins = local.global_rules })
#
#   response_codes = [200, 201]
#
#   destroy_url    = "${local.apisix_admin_base_path}/global_rules/1"
#   destroy_method = "DELETE"
#
#   destroy_headers = {
#     X-API-KEY = data.azurerm_key_vault_secret.admin_apikey.value
#   }
#
#   destroy_response_codes = [200]
# }
