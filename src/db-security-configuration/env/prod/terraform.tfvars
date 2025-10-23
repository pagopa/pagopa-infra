prefix    = "pagopa"
env_short = "p"
env       = "prod"


databases = {
  GPS = {
    type                    = "postgresql"
    host                    = "pagopa-p-weu-gpd-pgflex.postgres.database.azure.com"
    db_name                 = "apd"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  Cruscotto = {
    type                    = "postgresql"
    host                    = "pagopa-p-itn-crusc8-flexible-postgresql.postgres.database.azure.com"
    db_name                 = "cruscotto"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  Nodo = {
    type                    = "postgresql"
    host                    = "pagopa-p-itn-nodo-flexible-postgresql.postgres.database.azure.com"
    db_name                 = "nodo"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  "NodoStorico" = {
    type                    = "postgresql"
    host                    = "pagopa-p-weu-nodo-storico-flexible-postgresql.postgres.database.azure.com"
    db_name                 = "nodo"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  FDR = {
    type                    = "postgresql"
    host                    = "pagopa-p-itn-fdr-flexible-postgresql.postgres.database.azure.com"
    db_name                 = "fdr"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  FDR3 = {
    type                    = "postgresql"
    host                    = "pagopa-p-itn-fdr-flexible-postgresql.postgres.database.azure.com"
    db_name                 = "fdr3"
    username                = "metabase"
    password_required       = true
    password_secret_kv_name = "pagopa-p-itn-core-kv"
    password_secret_kv_rg   = "pagopa-p-itn-core-sec-rg"
    password_secret_key     = "metabase-reader-password"
  }
  NodoNexi-online = {
    type              = "nexi"
    host              = "10.1.131.14"
    port              = "8080"
    username          = "admin"
    password_required = false
    schema            = "nodo_online"
    catalog           = "nexi"
  }
  NodoNexi-offline = {
    type              = "nexi"
    host              = "10.1.131.14"
    port              = "8080"
    username          = "admin"
    password_required = false
    schema            = "nodo_offline"
    catalog           = "nexi"
  }
  PayWallet = {
    type              = "mongodb"
    host              = "10.1.131.14"
    port              = "8080"
    schema            = "payment-wallet"
    username          = "admin"
    password_required = false
    catalog           = "pagopa-p-itn-pay-wallet-cosmos-account"
  }
  Ecommerce = {
    type              = "mongodb"
    host              = "10.1.131.14"
    port              = "8080"
    schema            = "ecommerce"
    username          = "admin"
    password_required = false
    catalog           = "pagopa-p-weu-ecommerce-cosmos-account"
  }
}
