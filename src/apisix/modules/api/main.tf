resource "terracurl_request" "upstreams" {
  for_each = var.enabled ? var.services : {}

  name   = "upstream_${each.value.name}a"
  url    = "${var.apisix_admin_base_path}/upstreams/${md5(each.value.name)}"
  method = "PUT"

  headers = {
    X-API-KEY = var.admin_token
  }

  request_body = jsonencode({
    name   = each.value.name
    type   = "roundrobin"
    nodes  = each.value.nodes,
    scheme = each.value.scheme,
  })

  response_codes = [200, 201]

  destroy_url    = "${var.apisix_admin_base_path}/upstreams/${md5(each.value.name)}"
  destroy_method = "DELETE"

  destroy_headers = {
    X-API-KEY = var.admin_token
  }

  destroy_response_codes = [200]
}

resource "terracurl_request" "services" {
  for_each = var.enabled ? var.services : {}

  name   = "service_${each.value.name}"
  url    = "${var.apisix_admin_base_path}/services/${md5(each.value.name)}"
  method = "PUT"

  headers = {
    X-API-KEY = var.admin_token
  }

  request_body = jsonencode(merge(
    {
      name        = each.value.name
      upstream_id = jsondecode(terracurl_request.upstreams[each.value.name].response).value.id
      plugins     = jsondecode(each.value.plugins)
    },
  ))

  response_codes = [200, 201]

  destroy_url    = "${var.apisix_admin_base_path}/services/${md5(each.value.name)}"
  destroy_method = "DELETE"

  destroy_headers = {
    X-API-KEY = var.admin_token
  }

  destroy_response_codes = [200]
}

resource "terracurl_request" "routes" {
  for_each = var.enabled ? {for i, route in var.routes: "${route.name}-${var.services[route.service].name}" => route} : {}

  name   = each.value.name
  url    = "${var.apisix_admin_base_path}/routes/${md5("${var.services[each.value.service].name}-${each.value.name}")}"
  method = "PUT"

  headers = {
    X-API-KEY = var.admin_token
  }

  request_body = jsonencode(merge(
    {
      name       = "${var.services[each.value.service].name}[${each.value.name}]"
      uris       = [for uri in each.value.uris: "${var.services[each.value.service].base_path}${uri}"]
      methods    = each.value.methods
      service_id = jsondecode(terracurl_request.services[each.value.service].response).value.id
      priority   = can(each.value.priority) ? each.value.priority : 0
    },
    can(each.value.desc) ? { desc = each.value.desc } : {},
    can(each.value.host) ? { host = each.value.host } : {},
    can(each.value.vars) ? { vars = each.value.vars } : {},
    can(each.value.plugins) && each.value.plugins != null ? { plugins = jsondecode(each.value.plugins) } : {}
  ))

  response_codes = [200, 201]

  destroy_url    = "${var.apisix_admin_base_path}/routes/${md5("${var.services[each.value.service].name}-${each.value.name}")}"
  destroy_method = "DELETE"

  destroy_headers = {
    X-API-KEY = var.admin_token
  }

  destroy_response_codes = [200]
}
