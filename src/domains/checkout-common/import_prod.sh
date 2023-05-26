#!/bin/bash
# Generated with `generate_imports.py`

# module.pagopa_proxy_redis_snet
echo 'Importing module.pagopa_proxy_redis_snet.azurerm_subnet.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_redis_snet.azurerm_subnet.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-vnet-rg/providers/Microsoft.Network/virtualNetworks/pagopa-p-vnet/subnets/pagopa-p-pagopa-proxy-redis-snet'


# resource.azurerm_resource_group.pagopa_proxy_rg
echo 'Importing azurerm_resource_group.pagopa_proxy_rg'
./terraform.sh import weu-prod 'azurerm_resource_group.pagopa_proxy_rg' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]'
./terraform.sh import weu-prod 'module.pagopa_proxy_redis.azurerm_private_endpoint.this[0]' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Network/privateEndpoints/pagopa-p-pagopa-proxy-redis-private-endpoint'


# module.pagopa_proxy_redis
echo 'Importing module.pagopa_proxy_redis.azurerm_redis_cache.this'
./terraform.sh import weu-prod 'module.pagopa_proxy_redis.azurerm_redis_cache.this' '/subscriptions/b9fc9419-6097-45fe-9f74-ba0641c91912/resourceGroups/pagopa-p-pagopa-proxy-rg/providers/Microsoft.Cache/Redis/pagopa-p-pagopa-proxy-redis'


echo 'Import executed succesfully on prod environment! ⚡'
