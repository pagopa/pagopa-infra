# general
env_short = "p"
env       = "prod"

# dns/network
external_domain                           = "pagopa.it"
dns_zone_prefix                           = "platform"
cidr_subnet_canoneunico_common            = ["10.1.140.0/24"]
private_endpoint_network_policies_enabled = false
public_network_access_enabled             = true

lock_enable = true

# acr
acr_enabled = true

# docker image
image_name = "canone-unico"
image_tag  = "0.0.14"

# canone unico
canoneunico_plan_sku_tier = "PremiumV3"
canoneunico_plan_sku_size = "P1v3"

canoneunico_function_always_on         = true
canoneunico_function_autoscale_minimum = 1
canoneunico_function_autoscale_maximum = 3
canoneunico_function_autoscale_default = 1

canoneunico_queue_message_delay = 3600 // in seconds = 1h

canoneunico_runtime_version = "~3"

storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

function_storage_account_info = {
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = "GZRS"
  access_tier                       = "Hot"
  advanced_threat_protection_enable = true
}

canoneunico_delete_retention_days = 31
canoneunico_backup_retention_days = 30
enable_canoneunico_backup         = true
canoneunico_enable_versioning     = true
canoneunico_schedule_batch        = "0 */15 * * * *" # 4 times an hour: every 15 minutes of every hour of each day


# local users
corporate_cup_users = [
  {
    username : "tim"
  },
  {
    username : "enelsole"
  },
  {
    username : "retidistribuzione"
  },
  # {
  #   username : "snamretegas" NOT USED
  # },
  {
    username : "infrtrasportogas"
  },
  {
    username : "stoccaggigasitalia"
  },
  {
    username : "hera"
  },
  {
    username : "openfiber"
  },
  {
    username : "veritas"
  },
  {
    username : "aimag"
  },
  {
    username : "novareti"
  },
  {
    username : "setdistribuzione"
  },
  {
    username : "acantho"
  },
  {
    username : "heracomm"
  },
  {
    username : "heracommmarche"
  },
  {
    username : "heratrading"
  },
  {
    username : "heratech"
  },
  {
    username : "inretedistrenergia"
  },
  {
    username : "uniflotte"
  },
  {
    username : "herambiente"
  },
  {
    username : "hasiheraservind"
  },
  {
    username : "feafrulloenambiente"
  },
  {
    username : "aceagasapsamga"
  },
  {
    username : "aceagasapsamgase"
  },
  {
    username : "estenergy"
  },
  {
    username : "heraluce"
  },
  {
    username : "hestambiente"
  },
  {
    username : "trigenscarl"
  },
  {
    username : "italgasreti"
  },
  {
    username : "edistribuzione"
  },
  {
    username : "medea"
  },
  {
    username : "metanodottofriuli"
  },
  {
    username : "smvalletanaro"
  },
  {
    username : "toscanaenergia"
  },
  {
    username : "asretigas"
  },
  {
    username : "snamretegasdnordocc"
  },
  {
    username : "snamretegasdnord"
  },
  {
    username : "snamretegasdcentroori"
  },
  {
    username : "snamretegasdcentroocc"
  },
  {
    username : "snamretegasdsudocc"
  },
  {
    username : "snamretegasdsudori"
  },
  {
    username : "snamretegasdsicilia"
  },
  # {
  #   username : "infrtraspgasdnordocc" NOT USED
  # },
  {
    username : "infrtraspgasdcentroori"
  },
  {
    username : "planetel"
  },
  {
    username : "verizon"
  },
  {
    username : "apmgroup"
  },
  {
    username : "piaservizi"
  },
  {
    username : "fenenergia"
  },
  {
    username : "gei"
  },
  {
    username : "padaniaacque"
  },
  {
    username : "petrolgas"
  },
  {
    username : "fibercop"
  },
  {
    username : "bbbeell"
  },
  {
    username : "windtre"
  },
  {
    username : "gemedicalsystemm"
  },
  {
    username : "gehealthcare"
  },
  {
    username : "deval"
  },
  {
    username : "blureti"
  },
  {
    username : "lereti"
  },
  {
    username : "irenenergia"
  },
  {
    username : "retelitds"
  },
  {
    username : "2iretegas"
  },
  {
    username : "fastweb"
  },
  {
    username : "rete"
  },
  {
    username : "terna"
  },
  {
    username : "erogasmet"
  },
  {
    username : "snamretegasdnordori"
  },
  {
    username : "infrtraspgasdnordori"
  },
  {
    username : "sisem"
  },
  {
    username : "raiway"
  },
  {
    username : "mynet"
  }
]

### External resources
monitor_resource_group_name = "pagopa-p-monitor-rg"
