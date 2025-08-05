package azure.global.opa.storage_account.replication

is_in_scope(resource, type) if {
    resource.type == type
	data.utils.is_create_or_update(resource)
	
}

validzrs(resource) if {
	resource.values.account_replication_type == "ZRS"
}
validgzrs(resource) if {
	resource.values.account_replication_type == "GZRS"
}

deny contains reason if  {
	resource := input.resource_changes[_]
   	is_in_scope(resource, "azurerm_storage_account")
	not validzrs(resource)
	not validgzrs(resource)
	reason := sprintf("pagoPa-OPA: Storage Accounts should be ZRS or GZRS: '%s'", [resource.values.name])
}