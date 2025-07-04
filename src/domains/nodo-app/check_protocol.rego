package main.pagopa.opa.apim

not_allowed_uri_protocol := "http://"

is_in_scope(resource, type) if {
	resource.mode == "managed"
	data.utils.is_create_or_update(resource.change.actions)
	resource.type == type
}

is_not_valid_uri(uri) if {
	regex.match(not_allowed_uri_protocol, uri)
}

deny contains reason if {
	resource := input.resource_changes[_]
	is_in_scope(resource, "azurerm_api_management_api_policy")
	#resource.change.after.type == "HTTP"
	uri_output := resource.change.after.xml_content
	is_not_valid_uri(uri_output)
	message := "pagoPa-OPA: Protocol provided in URL for HTTP backend integration should be set to https '%s'"
	reason := sprintf(message, [resource.address])
}
