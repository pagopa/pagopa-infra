locals {
  westeurope_nsg = {
    fdrWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }

    gpsWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }

    nodoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }

    nodoStoricoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-storico-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }
  }

  italynorth_nsg = {
    crusc8ItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-crusc8-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }
  }

  italynorth_prod_nsg = {
    metabaseItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-dbsecurity-pgflex-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }
  }

  northeurope_nsg = {
    fdrNeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-neu-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_replica_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }


    gpsNeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-neu-gps-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_replica_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }

    nodoNeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-neu-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_replica_name
      watcher_enabled         = false

      inbound_rules  = [
        {
          name                       = "AllowPostgreSQL"
          priority                   = 200
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
        }
      ]
      outbound_rules = []
    }

  }
}
