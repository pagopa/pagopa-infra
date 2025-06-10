# resource "azurerm_security_center_subscription_pricing" "DefenderForStorage" {
#   count = var.env_short == "p" ? 1 : 0
#   tier          = "Standard"
#   resource_type = "StorageAccounts"
#   subplan       = "DefenderForStorageV2"

#   extension {
#     name = "OnUploadMalwareScanning"
#     additional_extension_properties = {
#       CapGBPerMonthPerStorageAccount = "10000"
#     }
#   }

#   extension {
#     name = "SensitiveDataDiscovery"
#   }
# }