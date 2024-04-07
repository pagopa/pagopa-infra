#!/usr/bin/env sh

./app_service_slot/migrate.sh \
  module.node_forwarder_slot_staging.azurerm_app_service_slot.this \
  module.node_forwarder_slot_staging.azurerm_linux_web_app_slot.this

./app_service/migrate.sh \
  module.node_forwarder_app_service.azurerm_app_service.this \
  module.node_forwarder_app_service.azurerm_linux_web_app.this
