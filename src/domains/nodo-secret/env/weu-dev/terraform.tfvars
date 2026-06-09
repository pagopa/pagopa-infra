prefix         = "pagopa"
env_short      = "d"
env            = "dev"
domain         = "nodo"
location       = "westeurope"
location_short = "weu"
input_file     = "./secret/weu-dev/configs.json"

enable_iac_pipeline = true

az_nodo_sa_share_name_firmatore = "firmatore"
upload_firmatore = {
  "firmatore.zip" = "./env/weu-dev/resources/firmatore.zip"
}

cacerts_path = "./env/weu-dev/resources/cacerts"
