#TODO TO REMOVE: delete all those removed blocks once applied in all envs
removed {
  from = azurerm_key_vault_secret.elastic_otel_token_header

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.checkout_opsgenie_webhook_token

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.checkout_oneidentity_onboarding_api_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.checkout_oneidentity_onboarding_params

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.one_identity_client_secret

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.one_identity_client_secret_test

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.checkout_gha_bot_pat

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.checkout_feature_flags_map

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.one_identity_admin_for_checkout

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.github_token_for_tas_integration_checkout

  lifecycle {
    destroy = false
  }
}
