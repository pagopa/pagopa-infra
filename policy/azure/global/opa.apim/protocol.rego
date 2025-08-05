package azure.global.opa.apim.protocol

# METADATA
# title: Deny http backend
# description: Protocol in URL backend should be set to HTTPS
# custom:
#  severity: MEDIUM
#  package_string: azure.global.opa.apim.protocol
#  message: "Found HTTP protocol in URL backend: should be set to HTTPS"
#  label: pagoPa-OPA

deny contains {
		sprintf("%s | %s %s: '%s'", [annotation.custom.package_string, annotation.custom.label, annotation.custom.message, resource.address])
} if {
	resource := input.resource_changes[_]
	annotation := rego.metadata.rule()
	is_in_scope(resource, "azurerm_api_management_api_policy")
	uri_output := resource.change.after.xml_content
	is_not_valid_uri(uri_output)
	
}


not_allowed_uri_protocol := "http://"

is_in_scope(resource, type) if {
	resource.mode == "managed"
	data.utils.is_create_or_update(resource.change.actions)
	resource.type == type
}

is_not_valid_uri(uri) if {
	regex.match(not_allowed_uri_protocol, uri)
}



