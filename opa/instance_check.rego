package terraform.analysis

import input as tfplan

########################
# Parameters for Policy
########################

# acceptable score for automated authorization
blast_radius := 55

# weights assigned for each operation on each resource-type
weights := {
	"azurerm_storage_account": {"delete": 100, "create": 10, "modify": 10},
	"azurerm_monitor_metric_alert": {"delete": 100, "create": 1, "modify": 10},
}

# Consider exactly these resource types in calculations
resource_types := {"azurerm_storage_account", "azurerm_monitor_metric_alert"}

#########
# Policy
#########

# Authorization holds if score for the plan is acceptable and no changes are made to IAM
default authz := false

authz if {
	score < blast_radius
	not touches_iam
}

# Compute the score for a Terraform plan as the weighted sum of deletions, creations, modifications
score := s if {
	all_resources := [x |
		some resource_type, crud in weights

		del := crud.delete * num_deletes[resource_type]
		new := crud.create * num_creates[resource_type]
		mod := crud.modify * num_modifies[resource_type]
		x := (del + new) + mod
	]
	s := sum(all_resources)
}

# Whether there is any change to IAM
touches_iam if {
	all_resources := resources.aws_iam
	count(all_resources) > 0
}

####################
# Terraform Library
####################

# list of all resources of a given type
resources[resource_type] := all_resources if {
	some resource_type, _ in resource_types

	all_resources := [name |
		some name in tfplan.resource_changes
		name.type == resource_type
	]
}

# number of creations of resources of a given type
num_creates[resource_type] := num if {
	some resource_type, _ in resource_types

	all_resources := resources[resource_type]
	creates := [res |
		some res in all_resources
		"create" in res.change.actions
	]
	num := count(creates)
}

# number of deletions of resources of a given type
num_deletes[resource_type] := num if {
	some resource_type, _ in resource_types

	all_resources := resources[resource_type]

	deletions := [res |
		some res in all_resources
		"delete" in res.change.actions
	]
	num := count(deletions)
}

# number of modifications to resources of a given type
num_modifies[resource_type] := num if {
	some resource_type, _ in resource_types

	all_resources := resources[resource_type]

	modifies := [res |
		some res in all_resources
		"update" in res.change.actions
	]
	num := count(modifies)
}