package it.pagopa.opa.terraform.plan.apply_score

import input as tfplan

########################
# Parameters for Policy
########################

# acceptable score for authorization
blast_radius := 100

# weights assigned for each operation on each resource-type
weights := {{"delete": 50, "create": 1, "modify": 20}}

# Consider exactly these resource types in calculations
resource_types := {"*"}

#########
# Policy
#########

# Authorization holds if score for the plan is acceptable and no changes are made to IAM
default authz := false

authz if {
	score < blast_radius
}

# Compute the score for a Terraform plan as the weighted sum of deletions, creations, modifications
score := s if {
	all_resources := [x |
		some crud in weights
		print(crud)
		del := crud.delete * num_deletes
		print(num_deletes)
		new := crud.create * num_creates
		print(num_creates)
		mod := crud.modify * num_modifies
		print(num_modifies)
		x := (del + new) + mod
	]
	s := sum(all_resources)
	
}

####################
# Terraform Library
####################

# list of all resources of a given type
resources := all_resources if {

	all_resources := [name |
		some name in tfplan.resource_changes
	]
}

# number of creations of resources of a given type
num_creates := num if {

	all_resources := resources
	creates := [res |
		some res in all_resources
		"create" in res.change.actions
	]
	num := count(creates)
	print(num)
}

# number of deletions of resources of a given type
num_deletes := num if {

	all_resources := resources
	deletions := [res |
		some res in all_resources
		"delete" in res.change.actions
	]

	num := count(deletions)
	print(num)
}

# number of modifications to resources of a given type
num_modifies := num if {

	all_resources := resources

	modifies := [res |
		some res in all_resources
		"update" in res.change.actions
	]
	num := count(modifies)
	print(num)
}