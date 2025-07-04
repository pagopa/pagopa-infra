package main.pagopa.opa.storage_account


is_in_scope(resource, type) if {
	#resource.mode == "managed"
    resource.type == type
	data.utils.is_create_or_update(resource)
	
}

valid(resource) if {
	resource.values.account_replication_type == "LRS"
}


deny contains reason if  {
	resource := input.resource_changes[_]
   	is_in_scope(resource, "azurerm_storage_account")
	not valid(resource)
	reason := sprintf("Storage Accounts should be LRS: '%s'", [resource.values.name])
}