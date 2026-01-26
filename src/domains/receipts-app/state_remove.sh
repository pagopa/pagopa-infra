#!/bin/bash
# Generated with `generate_imports.py`

# resource.azurerm_api_management_api_version_set.api_receipts_api
sh terraform.sh state weu-dev rm 'azurerm_api_management_api_version_set.api_receipts_api'

# module.apim_api_receipts_api_v1
sh terraform.sh state weu-dev rm 'module.apim_api_receipts_api_v1.azurerm_api_management_api.this'

# module.apim_api_receipts_api_v1
sh terraform.sh state weu-dev rm 'module.apim_api_receipts_api_v1.azurerm_api_management_api_policy.this[0]'

# module.apim_api_receipts_api_v1
sh terraform.sh state weu-dev rm 'module.apim_api_receipts_api_v1.azurerm_api_management_product_api.this["receipts"]'

# module.apim_receipts_product
sh terraform.sh state weu-dev rm 'module.apim_receipts_product.azurerm_api_management_product.this'

# module.apim_receipts_product
sh terraform.sh state weu-dev rm 'module.apim_receipts_product.azurerm_api_management_product_policy.this[0]'
