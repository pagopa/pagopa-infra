prefix          = "pagopa"
env_short       = "p"
env             = "prod"
domain          = "core"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"
instance        = "prod"

tags = {
  CreatedBy   = "Terraform"
  Environment = "PROD"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra/"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

### External resources

monitor_resource_group_name                 = "pagopa-p-monitor-rg"
log_analytics_workspace_name                = "pagopa-p-law"
log_analytics_workspace_resource_group_name = "pagopa-p-monitor-rg"

#
# Dns
#
external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.platform"

#
# CIRDs
#
cidr_subnet_dns_forwarder_backup = ["10.1.251.0/29"]
cidr_subnet_tools_cae            = ["10.1.248.0/23"]

dns_forwarder_backup_is_enabled = true
dns_forwarder_vm_image_name     = "pagopa-p-dns-forwarder-ubuntu2204-image-v1"


#
# replica settings
#
geo_replica_enabled        = true
geo_replica_location       = "northeurope"
geo_replica_location_short = "neu"
geo_replica_cidr_vnet      = ["10.2.0.0/16"]
geo_replica_ddos_protection_plan = {
  id     = "/subscriptions/0da48c97-355f-4050-a520-f11a18b8be90/resourceGroups/sec-p-ddos/providers/Microsoft.Network/ddosProtectionPlans/sec-p-ddos-protection"
  enable = true
}

postgres_private_dns_enabled = true

enable_logos_backup                              = true
logos_backup_retention                           = 30
logos_donations_storage_account_replication_type = "GZRS"

#
# Feature Flags
#
enabled_resource = {
  container_app_tools_cae = false
}


# to avoid https://docs.microsoft.com/it-it/azure/event-hubs/event-hubs-messaging-exceptions#error-code-50002
ehns_auto_inflate_enabled     = true
ehns_maximum_throughput_units = 5
ehns_capacity                 = 5
ehns_zone_redundant           = true

eventhubs_02 = [
  {
    name              = "nodo-dei-pagamenti-negative-awakable-biz-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-negative-final-biz-evt"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-biz-evt-rx", "pagopa-biz-evt-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-biz-evt-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-biz-evt-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "quality-improvement-alerts"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-qi-alert-rx", "pagopa-qi-alert-rx-pdnd", "pagopa-qi-alert-rx-debug"]
    keys = [
      {
        name   = "pagopa-qi-alert-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx-pdnd"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-alert-rx-debug"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "quality-improvement-psp-kpi"
    partitions        = 32
    message_retention = 7
    consumers         = ["pagopa-qi-psp-kpi-rx", "pagopa-qi-psp-kpi-rx-pdnd"]
    keys = [
      {
        name   = "pagopa-qi-psp-kpi-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "pagopa-qi-psp-kpi-rx"
        listen = true
        send   = false
        manage = false
      },
      {
        name   = "pagopa-qi-psp-kpi-rx-pdnd"
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-cache"
    partitions        = 32
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-cache-sync-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-cache-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-cache-sync-rx" # node-cfg-sync
        listen = true
        send   = false
        manage = false
      }
    ]
  },
  {
    name              = "nodo-dei-pagamenti-stand-in"
    partitions        = 32
    message_retention = 7
    consumers         = ["nodo-dei-pagamenti-stand-in-sync-rx"]
    keys = [
      {
        name   = "nodo-dei-pagamenti-stand-in-tx"
        listen = false
        send   = true
        manage = false
      },
      {
        name   = "nodo-dei-pagamenti-stand-in-sync-rx" # node-cfg-sync
        listen = true
        send   = false
        manage = false
      }
    ]
  }
]
