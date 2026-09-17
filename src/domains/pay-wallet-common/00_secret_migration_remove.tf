removed {
  from = azurerm_key_vault_secret.personal-data-vault-api-key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.wallet-jwt-signing-key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.payment-method-api-key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.elastic_otel_token_header

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.npg_service_api_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.wallet-token-test-key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.paypal_psp_api_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.npg_notifications_jwt_secret_key

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.wallet_migration_api_key_test_dev

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.wallet_migration_cstar_api_key_test_dev

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.migration_wallet_token_test_dev

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.payment_wallet_opsgenie_webhook_token

  lifecycle {
    destroy = false
  }
}

removed {
  from = azurerm_key_vault_secret.payment_wallet_gha_bot_pat

  lifecycle {
    destroy = false
  }
}

