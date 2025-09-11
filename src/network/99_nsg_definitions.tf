
locals {
  westeurope_nsg = {
    fdrWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }

    gpsWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }

    nodoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }

    nodoStoricoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-storico-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }
  }

  italynorth_nsg = {
    crusc8ItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-crusc8-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }
  }

  italynorth_prod_nsg = {
    metabaseItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-dbsecurity-pgflex-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }

    fdrItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }


    gpsItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-gps-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }

    nodoItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = [
        local.nsg_rule_library.allow_all_to_postgres,
        local.nsg_rule_library.allow_vpn_to_postgres
      ]
      outbound_rules = []
    }
  }


  nsg_rule_library = {
      allow_all_to_postgres = {
          name                       = "AllowPostgreSQL"
          priority                   = 100
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
      }
      allow_vpn_to_postgres = {
        name                       = "AllowVpnPostgreSQL"
        priority                   = 300
        target_service             = "postgresql"
        source_subnet_name         = "GatewaySubnet"
        source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
        description                = "Allow vpn to access PostgreSQL"
      }
      allow_aks_weu_to_postgres = {
          name                       = "AllowAKSWeuPostgreSQL"
          priority                   = 400
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-weu-${var.env}-aks-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow AKS weu to access PostgreSQL"
      }
      allow_aks_itn_user_to_postgres = {
          name                       = "AllowAKSItnUserPostgreSQL"
          priority                   = 400
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-${var.env}-user-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS user itn to access PostgreSQL"
      }
      allow_aks_itn_system_to_postgres = {
          name                       = "AllowAKSItnSystemPostgreSQL"
          priority                   = 400
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-${var.env}-system-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS system itn to access PostgreSQL"
      }
      allow_aks_itn_paywallet_to_postgres = {
          name                       = "AllowAKSItnPaywalletPostgreSQL"
          priority                   = 400
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-pay-wallet-user-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS pay wallet itn to access PostgreSQL"
      }
      allow_metabase_to_postgres = {
          name                       = "AllowMetabasePostgreSQL"
          priority                   = 400
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-dbsecurity-app-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow metabase to access PostgreSQL"
      }


  }

}
