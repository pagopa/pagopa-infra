# Enforce a list of allowed locations / availability zones for each provider

package it.pagopa.azure.pagopa.terraform.location

import input as tfplan


allowed_locations = {
    "azurerm": ["westeurope", "northeurope", "italynorth", "germanywestcentral", "global"]
}


array_contains(arr, elem) if {
  arr[_] = elem
}

get_basename(path) = basename if {
    arr := split(path, "/")
    basename:= arr[count(arr)-1]
}

eval_expression(plan, expr) = constant_value if {
    constant_value := expr.constant_value
} else = reference if {
    ref = expr.references[0]
    startswith(ref, "var.")
    var_name := replace(ref, "var.", "")
    reference := plan.variables[var_name].value
}

get_location(resource, plan) = azure_location if {
    provider_name := get_basename(resource.provider_name)
    "azurerm" == provider_name
    azure_location := resource.change.after.location
} 

deny contains reason if {
    resource := tfplan.resource_changes[_]
    location := get_location(resource, tfplan)
    provider_name := get_basename(resource.provider_name)
    not array_contains(allowed_locations[provider_name], location)

    reason := sprintf(
        "%s: location %q is not allowed",
        [resource.address, location]
    )
}