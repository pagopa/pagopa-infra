env_short       = "p"
env             = "prod"
location        = "italynorth"
location_short  = "itn"
location_string = "Italy North"


external_domain          = "pagopa.it"
dns_zone_internal_prefix = "internal.prod.platform"
dns_zone_prefix          = "qa.itn"

qa_hub_plan_idh_tier = "basic"
qa_hub_autoscale_settings = {
  max_capacity                  = 1
  scale_up_requests_threshold   = 250
  scale_down_requests_threshold = 150
}
qa_hub_image = {
  docker_registry_url = "https://pagopapcommonacr.azurecr.io"
  docker_image        = "pagopa-qa-centralhub-fe"
  docker_image_tag    = "latest"
}
qa_hub_always_on = true


