env_short      = "d"
env            = "dev"
location       = "italynorth"
location_short = "itn"
location_string = "Italy North"


external_domain          =  "pagopa.it"
dns_zone_internal_prefix = "internal.dev.platform"
dns_zone_prefix          = "qa.itn"

qa_hub_plan_idh_tier = "basic"
qa_hub_autoscale_settings = {
    max_capacity                  = 1
    scale_up_requests_threshold   = 250
    scale_down_requests_threshold = 150
}
qa_hub_image = {
    docker_image         = "latest"
    docker_image_tag           = "latest"
    docker_registry_url  = "https://index.docker.io"
}
qa_hub_always_on = true


