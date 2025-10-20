prefix         = "pagopa"
env_short      = "d"
env            = "dev"

databases = {
  gpd = {
    type = "postgresql"
    host = "pagopa-d-weu-gpd-pgflex.postgres.database.azure.com"
    schema_name = "apd"
    username = "apduser"
    password_required = true
    password_secret_kv_name = "pagopa-d-gps-kv"
    password_secret_kv_rg = "pagopa-d-gps-sec-rg"
    password_secret_key = "db-apd-user-password"
  }
  paymenttrinoTF = {
    type = "mongodb"
    host = "10.1.131.14"
    port = "8080"
    schema_name = "payment-wallet"
    username = "admin"
    password_required = false
    catalog = "pagopa-d-itn-pay-wallet-cosmos-account"
  }
}
