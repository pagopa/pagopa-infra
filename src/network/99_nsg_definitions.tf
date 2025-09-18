
locals {
  westeurope_nsg = {
    # fixme add db replica with access from db main
    fdrWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.weu_postgres_base_inbound_rules
      outbound_rules = []
    }

    gpsWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.weu_postgres_base_inbound_rules
      outbound_rules = []
    }

    nodoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.weu_postgres_base_inbound_rules
      outbound_rules = []
    }

    nodoStoricoWeuPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-weu-nodo-storico-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_core_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = concat(
        local.weu_postgres_base_inbound_rules,
        [local.nsg_rule_library.allow_nodo_weu_to_postgres]
      )
      outbound_rules = []
    }
  }

  italynorth_nsg = {
    crusc8ItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-crusc8-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.itn_postgres_base_inbound_rules
      outbound_rules = []
    }
  }

  italynorth_prod_nsg = {
    metabaseItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-dbsecurity-pgflex-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.itn_postgres_base_inbound_rules
      outbound_rules = []
    }

    fdrItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-fdr-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.itn_postgres_base_inbound_rules
      outbound_rules = []
    }


    gpsItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-gps-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.itn_postgres_base_inbound_rules
      outbound_rules = []
    }

    nodoItnPostgre = {
      target_subnet_name      = "pagopa-${var.env_short}-itn-nodo-pgres-flexible-snet"
      target_subnet_vnet_name = local.vnet_italy_name
      watcher_enabled         = var.nsg_network_watcher_enabled

      inbound_rules  = local.itn_postgres_base_inbound_rules
      outbound_rules = []
    }
  }


  weu_postgres_base_inbound_rules = concat([
        local.nsg_rule_library.allow_azdo_to_postgres,
        local.nsg_rule_library.allow_tools_cae_to_postgres,
        local.nsg_rule_library.allow_aks_weu_to_postgres,
        local.nsg_rule_library.allow_data_factory_to_postgres,
        local.nsg_rule_library.allow_data_factory_proxy_to_postgres,
        local.nsg_rule_library.deny_from_all_vnet,
        local.nsg_rule_library.allow_pe_subnet_to_postgres,
      ],
          var.enabled_features.metabase ? [local.nsg_rule_library.allow_metabase_to_postgres] : [],
          # inbound rule for vpn kept separated because the structure is different and terraform gives error if kept in the same list
          var.enabled_features.vpn_database_access ? [local.nsg_rule_library.allow_vpn_subnet_to_postgres] : [],
          var.enabled_features.vpn_database_access ? [local.nsg_rule_library.allow_vpn_gateway_to_postgres] : []
      )
  itn_postgres_base_inbound_rules = concat([
        local.nsg_rule_library.allow_azdo_to_postgres,
        local.nsg_rule_library.allow_tools_cae_to_postgres,
        local.nsg_rule_library.allow_aks_itn_system_to_postgres,
        local.nsg_rule_library.allow_aks_itn_user_to_postgres,
        local.nsg_rule_library.allow_data_factory_to_postgres,
        local.nsg_rule_library.allow_data_factory_proxy_to_postgres,
        local.nsg_rule_library.deny_from_all_vnet,
      ],
          var.enabled_features.metabase ? [local.nsg_rule_library.allow_metabase_to_postgres] : [],
          # inbound rule for vpn kept separated because the structure is different and terraform gives error if kept in the same list
          var.enabled_features.vpn_database_access ? [local.nsg_rule_library.allow_vpn_subnet_to_postgres] : [],
          var.enabled_features.vpn_database_access ? [local.nsg_rule_library.allow_vpn_gateway_to_postgres] : []
      )

  nsg_rule_library = {
      allow_all_to_postgres = {
          name                       = "AllowPostgreSQL"
          priority                   = 100
          target_service             = "postgresql"
          source_address_prefixes    = ["*"]
          description                = "Allow all subnets to access PostgreSQL"
      }
      allow_vpn_subnet_to_postgres = {
        name                       = "AllowVpnSubnetPostgreSQL"
        priority                   = 300
        target_service             = "postgresql"
        source_subnet_name         = "GatewaySubnet"
        source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
        description                = "Allow vpn subnet to access PostgreSQL"
      }
      allow_vpn_gateway_to_postgres = {
          name                       = "AllowVpnGWPostgreSQL"
          priority                   = 301
          target_service             = "postgresql"
          source_address_prefixes    = [var.vpn_gateway_address_space]
          description                = "Allow vpn gw to access PostgreSQL"
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
          priority                   = 401
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-${var.env}-user-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS user itn to access PostgreSQL"
      }
      allow_aks_itn_system_to_postgres = {
          name                       = "AllowAKSItnSystemPostgreSQL"
          priority                   = 402
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-${var.env}-system-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS system itn to access PostgreSQL"
      }
      allow_aks_itn_paywallet_to_postgres = {
          name                       = "AllowAKSItnPaywalletPostgreSQL"
          priority                   = 403
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-pay-wallet-user-aks"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow AKS pay wallet itn to access PostgreSQL"
      }
      allow_metabase_to_postgres = {
          name                       = "AllowMetabasePostgreSQL"
          priority                   = 404
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-dbsecurity-app-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow metabase to access PostgreSQL"
      }
      allow_azdo_to_postgres = {
          name                       = "AllowAZDOPostgreSQL"
          priority                   = 405
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-azdoa-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow AZDO to access PostgreSQL"
      }
      allow_tools_cae_to_postgres = {
          name                       = "AllowToolsCaePostgreSQL"
          priority                   = 406
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-tools-cae-subnet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow Container app tools to access PostgreSQL"
      }
      allow_tools_cae_itn_to_postgres = {
          name                       = "AllowToolsCaeItnPostgreSQL"
          priority                   = 407
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-itn-core-tools-cae-subnet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow Container app tools itn to access PostgreSQL"
      }
      allow_gh_runner_itn_to_postgres = {
          name                       = "AllowGhRunnerItnPostgreSQL"
          priority                   = 408
          target_service             = "postgresql"
          source_subnet_name         = "github-runner-snet-ita"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-itn-vnet"
          description                = "Allow gh runner itn to access PostgreSQL"
      }
      allow_gh_runner_weu_to_postgres = {
          name                       = "AllowGhRunnerWeuPostgreSQL"
          priority                   = 409
          target_service             = "postgresql"
          source_subnet_name         = "github-runner-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow gh runner weu to access PostgreSQL"
      }
      allow_data_factory_to_postgres = {
          name                       = "AllowDataFactoryPostgreSQL"
          priority                   = 410
          target_service             = "postgresql"
          source_address_prefixes    = ["DataFactory"]
          description                = "Allow data factory to access PostgreSQL"
      }
      allow_data_factory_proxy_to_postgres = var.enabled_features.data_factory_proxy ? {
          name                       = "AllowDataFactoryProxyPostgreSQL"
          priority                   = 411
          target_service             = "postgresql"
          source_address_prefixes    = [data.azurerm_virtual_machine.data_factory_proxy[0].private_ip_address]
          description                = "Allow data factory proxy to access PostgreSQL"
      } : null
      allow_pe_subnet_to_postgres = {
          name                       = "AllowPESubnetPostgreSQL"
          priority                   = 412
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-common-private-endpoint-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow PE subnet to access PostgreSQL"
      }
      allow_nodo_weu_to_postgres = {
          name                       = "AllowNodoPostgreSQL"
          priority                   = 450
          target_service             = "postgresql"
          source_subnet_name         = "pagopa-${var.env_short}-weu-nodo-pgres-flexible-snet"
          source_subnet_vnet_name    = "pagopa-${var.env_short}-vnet"
          description                = "Allow nodo weu to access PostgreSQL"
      }

      deny_from_all_vnet = {
          name                       = "DenyFromAllVNet"
          priority                   = 4096
          destination_port_ranges    = ["*"]
          source_address_prefixes    = ["*"]
          protocol = "*"
          description                = "Deny Everyone to access PostgreSQL"
          access = "Deny"
      }
  }

}
