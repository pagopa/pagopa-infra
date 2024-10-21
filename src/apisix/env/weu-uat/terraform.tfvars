# general
prefix          = "pagopa"
env_short       = "u"
env             = "uat"
domain          = "uat"
location        = "westeurope"
location_short  = "weu"
location_string = "West Europe"

tags = {
  CreatedBy   = "Terraform"
  Environment = "Uat"
  Owner       = "pagoPA"
  Source      = "https://github.com/pagopa/pagopa-infra"
  CostCenter  = "TS310 - PAGAMENTI & SERVIZI"
}

# chart releases: https://github.com/apache/apisix-helm-chart/releases
# apisix image tags: https://hub.docker.com/r/apache/apisix/tags
# etcd image tags: https://hub.docker.com/r/bitnami/etcd/tags
# apisix-dashboard image tags: https://hub.docker.com/r/apache/apisix-dashboard/tags
apisix_helm = {
  chart_version = "2.10.0"
  apisix = {
    image_name = "apache/apisix"
    image_tag  = "3.11.0-debian@sha256:178d1f79c2c39834f50213bf6ace90284f6b985dc8189cc50f3666d9fb1037ad"
  }
  etcd = {
    image_name = "bitnami/etcd"
    image_tag  = "3.5.16-debian-12-r2@sha256:27d447e33d5788dac3367ee170667ef6a2113f8bf8cfdf8b98308bce6d5894cc"
  }
  apisix_dashboard = {
    image_name = "apache/apisix-dashboard"
    image_tag  = "3.0.0-alpine@sha256:692c786310efa4375143015a9cc2d43396af63ed316aba243041329a08b517fc"
  }
}
