prefix         = "pagopa"
env_short      = "d"
env            = "dev"
location       = "italynorth"
location_short = "itn"
location_string = "Italy North"


external_domain          =  "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "tstdmo.itn"

_plan_idh_tier = "basic"
_autoscale_settings = {
    max_capacity                  = 1
    scale_up_requests_threshold   = 250
    scale_down_requests_threshold = 150
}
_image = {
    docker_image         = ""
    docker_tag           = "latest"
    docker_registry_url  = "https://index.docker.io"
}
_always_on = true


_plan_idh_tier = "basic"
_autoscale_settings = {
  max_capacity                  = 1
  scale_up_requests_threshold   = 250
  scale_down_requests_threshold = 150
}
_image = {
  docker_image         = ""
  docker_tag           = "latest"
  docker_registry_url  = "https://index.docker.io"
}
_always_on = true

